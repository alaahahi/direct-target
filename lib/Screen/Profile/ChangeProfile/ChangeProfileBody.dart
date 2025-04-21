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
  final TextEditingController familyController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController heightController = TextEditingController();

  String? selectedGender;

  final box = GetStorage();
  @override
  void initState() {
    super.initState();

    final profile = controller.profile.value.data;

    if (profile != null) {
      nameController.text = profile.name ?? '';
      familyController.text = profile.familyMembersNames ?? '';
      weightController.text = profile.weight?.toString() ?? '';
      heightController.text = profile.height?.toString() ?? '';
      selectedGender = profile.gender?.toString();

    }
  }

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
                    onChange: (value) {},
                  ),
                  SizedBox(height: Get.height * 0.03),
                  AuthFormField(
                    controller: familyController,
                    hint: 'Your Family Names'.tr,
                    onChange: (value) {
                    },
                  ),

                  SizedBox(height: Get.height * 0.03),
                  AuthFormField(
                    controller: weightController,
                    hint: 'Your Weight (kg)'.tr,
                    keyboardType: TextInputType.number,
                    onChange: (value) {},
                  ),
                  SizedBox(height: Get.height * 0.03),
                  AuthFormField(
                    controller: heightController,
                    hint: 'Your Height (cm)'.tr,
                    keyboardType: TextInputType.number,
                    onChange: (value) {},
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
                    items: [
                      DropdownMenuItem(
                        value: "1",
                        child: Text("Male".tr),
                      ),
                      DropdownMenuItem(
                        value: "2",
                        child: Text("Female".tr),
                      ),
                    ],
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
              return Container(
                height: MediaQuery.of(context).size.height * 0.07,
                width: MediaQuery.of(context).size.width * 0.9,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Map<String, dynamic> updatedProfile = {
                        "name": nameController.text.isNotEmpty
                            ? nameController.text
                            : controller.profile.value.data?.name,

                        "family_members_names": familyController.text.isNotEmpty
                            ? familyController.text
                            : controller.profile.value.data?.familyMembersNames,

                        "weight": weightController.text.isNotEmpty
                            ? int.tryParse(weightController.text)
                            : controller.profile.value.data?.weight,

                        "height": heightController.text.isNotEmpty
                            ? int.tryParse(heightController.text)
                            : controller.profile.value.data?.height,

                        "gender": selectedGender ?? controller.profile.value.data?.gender,
                        "device": controller.profile.value.data?.device,
                        "network": controller.profile.value.data?.network,
                        "fcm_token": controller.profile.value.data?.fcmToken,
                      };

                      controller.updateProfile(updatedProfile);
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
