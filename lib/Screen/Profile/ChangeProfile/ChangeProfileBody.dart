import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../Controller/LoaderController.dart';
import '../../../Controller/ProfileCardController.dart';
import '../../../Utils/AppStyle.dart';
import '../../../Widgets/AuthFormFiled.dart';

class ChangeProfileBody extends StatefulWidget {
  const ChangeProfileBody({super.key});

  @override
  State<ChangeProfileBody> createState() => _ChangeProfileBodyState();
}
class _ChangeProfileBodyState extends State<ChangeProfileBody> {
  final _formKey = GlobalKey<FormState>();
  final ProfileCardController controller = Get.put(ProfileCardController());
  final LoaderController loaderController = Get.put(LoaderController());
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController familyController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController heightController = TextEditingController();

  String? selectedGender;

  final box = GetStorage();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(height: Get.height * 0.05),
                  AuthFormField(
                    controller: nameController,
                    hint: 'Your Name'.tr,
                    onChanged: (value) {},
                  ),
                  SizedBox(height: Get.height * 0.03),
                  AuthFormField(
                    controller: phoneController,
                    hint: 'Your Phone Number'.tr,
                    onChanged: (value) {},
                  ),
                  SizedBox(height: Get.height * 0.03),
                  AuthFormField(
                    controller: familyController,
                    hint: 'Your Family Names'.tr,
                    onChanged: (value) {},
                  ),
                  SizedBox(height: Get.height * 0.03),
                  AuthFormField(
                    controller: weightController,
                    hint: 'Your Weight (kg)'.tr,
                    keyboardType: TextInputType.number,
                    onChanged: (value) {},
                  ),
                  SizedBox(height: Get.height * 0.03),
                  AuthFormField(
                    controller: heightController,
                    hint: 'Your Height (cm)'.tr,
                    keyboardType: TextInputType.number,
                    onChanged: (value) {},
                  ),
                  SizedBox(height: Get.height * 0.03),
                  DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      hintText: "Select Gender".tr,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                    ),
                    value: selectedGender,
                    items: ["Male".tr, "Female".tr]
                        .map((gender) => DropdownMenuItem(
                      value: gender,
                      child: Text(gender),
                    ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedGender = value;
                      });
                    },
                  ),
                  SizedBox(height: Get.height * 0.05),
                ],
              ),
            ),

            Obx(() {
              return loaderController.loading.value
                  ? const Center(
                child: CircularProgressIndicator(color: PrimaryColor),
              )
                  : Container(
                height: MediaQuery.of(context).size.height * 0.07,
                width: MediaQuery.of(context).size.width * 0.9,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      controller.updateProfile({
                        "name": nameController.text,
                        "phone_number": phoneController.text,
                        "family": familyController.text,
                        "weight": weightController.text,
                        "height": heightController.text,
                        "gender": selectedGender ?? "",
                      });
                    }
                  },
                  child: Text(
                    "Update Profile".tr,
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

            Padding(
              padding: const EdgeInsets.only(right: 8.0, left: 8.0),
            ),
          ],
        ),
      ),
    );
  }
}
