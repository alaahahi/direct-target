import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:direct_target/Utils/AppStyle.dart';
import 'package:image_picker/image_picker.dart';
import '../../Controller/AllSettingController.dart';
import '../../Controller/CardController.dart';
import '../../Controller/TokenController.dart';
import '../../Controller/VerificationWhatsappController.dart';
import '../../Model/RequestCardModel.dart';
import '../../Service/CardServices.dart';
import '../../Service/SettingsServices.dart';
import '../../Widgets/AuthFormFiled.dart';
class RequestSpecificCard extends StatefulWidget {
  final int cardId;


  RequestSpecificCard({required this.cardId});
  @override
  _RequestSpecificCardState createState() => _RequestSpecificCardState();
}

class _RequestSpecificCardState extends State<RequestSpecificCard> {
  String? userPhone;
  bool? isAdmin;
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();
  final _cardNumberController = TextEditingController();
  File? _selectedImage;
  final TextEditingController _familyCountController = TextEditingController();
  RxList<TextEditingController> familyNamesControllers = <TextEditingController>[].obs;
  final TokenController tokenController = Get.put(TokenController());
  final ImagePicker _picker = ImagePicker();
  final CardController _controller = Get.put(CardController(CardServices()));
  final storage = GetStorage();
  final VerificationWhatsappController _userphoneController =
  Get.put(VerificationWhatsappController());
  final AllSettingController _appController = Get.put(AllSettingController(SettingsServices()));

  void updateFamilyFields() {
    int count = int.tryParse(_familyCountController.text) ?? 0;
    setState(() {
      if (count > 0) {
        familyNamesControllers.assignAll(
          List.generate(count, (index) => TextEditingController()),
        );
      } else {
        familyNamesControllers.clear();
      }
    });
  }
  bool isPhoneValid = false;
  String? _validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone number is required';
    }
    if (value.length != 10 || !RegExp(r'^[0-9]+$').hasMatch(value)) {
      return 'Phone number must be 10 digits';
    }
    return null;
  }
  void _phoneListener() {
    setState(() {
      isPhoneValid = _phoneController.text.length == 10 && RegExp(r'^[0-9]+$').hasMatch(_phoneController.text);
    });
  }


  @override
  void initState() {
    super.initState();
    GetStorage.init().then((_) {
      setState(() {
        userPhone = _userphoneController.phoneNumber.value;
        isAdmin = _userphoneController.isAdmin.value;
      });
    });

    _phoneController.addListener(_phoneListener);
  }

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    final cardId = widget.cardId;
    return Scaffold(

      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Obx(() {
                  if (tokenController.token.value.isNotEmpty){
                    return Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            _pickImage();
                          },
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.07,
                            width: MediaQuery.of(context).size.width * 0.9,
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: _selectedImage != null
                                ? ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.file(
                                _selectedImage!,
                                fit: BoxFit.cover,
                                width: 300,
                                height: 200,
                              ),
                            )
                                : Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Center(
                                  child: Icon(
                                    Icons.add,
                                    color: Colors.grey,
                                    size: 30,
                                  ),
                                ),
                                Center(
                                  child: Text(
                                    'Add Card Image'.tr,
                                    style: TextStyle(color: Colors.black12),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        AuthFormField(
                          controller: _nameController,
                          hint: 'Full Name'.tr,
                          onChanged: (value) {},
                        ),
                        SizedBox(height: 20),
                        AuthFormField(
                          controller: _phoneController,
                          hint: 'Phone Number'.tr,
                          onChanged: (value) {},
                          validator: _validatePhone,
                        ),
                        SizedBox(height: 20),
                        AuthFormField(
                          controller: _addressController,
                          hint: 'Address'.tr,
                          onChanged: (value) {},
                        ),
                        SizedBox(height: 20),

                        if (isAdmin != null && isAdmin!)
                          AuthFormField(
                            controller: _cardNumberController,
                            hint: 'Card Number'.tr,
                            onChanged: (value) {},
                          ),
                        SizedBox(height: 20),

                        TextFormField(
                          controller: _familyCountController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: 'Number of family members'.tr,
                            border: OutlineInputBorder(),
                          ),
                          onChanged: (value) {
                            updateFamilyFields();
                          },
                        ),
                        const SizedBox(height: 10),

                        Column(
                          children: List.generate(familyNamesControllers.length, (index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              child: TextFormField(
                                controller: familyNamesControllers[index],
                                decoration: InputDecoration(
                                  labelText: 'Member Name ${index + 1}'.tr,
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            );
                          }),
                        ),

                        const SizedBox(height: 20),

                        const SizedBox(height: 20),
                        Obx(() {
                          return _controller.isLoading.value
                              ? Center(child: CircularProgressIndicator())
                              : Container(
                            height: MediaQuery.of(context).size.height * 0.07,
                            width: MediaQuery.of(context).size.width * 0.9,
                            child: ElevatedButton(
                              onPressed: isPhoneValid
                                  ? () {
                                if (_formKey.currentState!.validate()) {
                                  final cardRequest = RequestCardData(
                                      name: _nameController.text,
                                      phone: _phoneController.text,
                                      address: _addressController.text,
                                      cardNumber: tokenController.token.value.isNotEmpty && isAdmin!
                                          ? _cardNumberController.text
                                          : '',
                                      familyMembersNames: familyNamesControllers.isNotEmpty
                                          ? familyNamesControllers.map((controller) => controller.text.trim()).where((name) => name.isNotEmpty).toList()
                                          : null,
                                      image: _selectedImage?.path,
                                      id: cardId
                                  );
                                  _controller.RequestCard(cardRequest);
                                }
                              }
                                  : null,
                              child: Text(
                                "Request Card".tr,
                                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                  color: LightGrey,
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.white,
                                backgroundColor: PrimaryColor,
                                shadowColor: Colors.black,
                                elevation: 5,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                            ),
                          );
                        }),
                      ],
                    );

                  }
                  return Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          _pickImage();
                        },
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.07,
                          width: MediaQuery.of(context).size.width * 0.9,
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: _selectedImage != null
                              ? ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.file(
                              _selectedImage!,
                              fit: BoxFit.cover,
                              width: 300,
                              height: 200,
                            ),
                          )
                              : Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Center(
                                child: Icon(
                                  Icons.add,
                                  color: Colors.grey,
                                  size: 30,
                                ),
                              ),
                              Center(
                                child: Text(
                                  'Add Card Image'.tr,
                                  style: TextStyle(color: Colors.black12),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 20),

                      AuthFormField(
                        controller: _nameController,
                        hint: 'Full Name'.tr, onChanged: (value) {  },
                      ),
                      SizedBox(height: 20),
                      AuthFormField(
                        controller: _phoneController,
                        hint: 'Phone Number'.tr, onChanged: (value) {  },
                      ),
                      SizedBox(height: 20),
                      AuthFormField(
                        controller: _addressController,
                        hint: 'Address'.tr, onChanged: (value) {  },
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        controller: _familyCountController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'Number of family members'.tr,
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (value) {
                          updateFamilyFields();
                        },
                      ),

                      const SizedBox(height: 10),

                      Column(
                        children: List.generate(familyNamesControllers.length, (index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: TextFormField(
                              controller: familyNamesControllers[index],
                              decoration: InputDecoration(
                                labelText: 'Member Name ${index + 1}'.tr,
                                border: OutlineInputBorder(),
                              ),
                            ),
                          );
                        }),
                      ),


                      const SizedBox(height: 20),
                      const SizedBox(
                        height: 20,
                      ),
                      Obx(() {
                        return _controller.isLoading.value
                            ? Center(child: CircularProgressIndicator())
                            : Container(
                          height: MediaQuery.of(context).size.height * 0.07,
                          width: MediaQuery.of(context).size.width * 0.9,
                          child: ElevatedButton(
                            onPressed: isPhoneValid
                                ? () {
                              if (_formKey.currentState!.validate()) {
                                final cardRequest = RequestCardData(
                                  name: _nameController.text,
                                  phone: _phoneController.text,
                                  address: _addressController.text,
                                  familyMembersNames: familyNamesControllers.isNotEmpty
                                      ? familyNamesControllers.map((controller) => controller.text.trim()).where((name) => name.isNotEmpty).toList()
                                      : null,
                                  image: _selectedImage?.path,
                                  id: cardId
                                );
                                _controller.RequestCard(cardRequest);
                              }
                            }
                                : null,
                            child: Text(
                              "Request Card".tr,
                              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                color: LightGrey,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: PrimaryColor,
                              shadowColor: Colors.black,
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                          ),
                        );
                      }),
                    ],
                  );

                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
