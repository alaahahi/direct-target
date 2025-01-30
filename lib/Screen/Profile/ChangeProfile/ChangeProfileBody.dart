import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../Controller/LoaderController.dart';
import '../../../Controller/ProfileCardController.dart';
import '../../../Utils/AppStyle.dart';
import '../../../Widgets/AuthFormFiled.dart';

class ChangePasswordBody extends StatefulWidget {
  const ChangePasswordBody({super.key});

  @override
  State<ChangePasswordBody> createState() => _ChangePasswordBodyState();
}

class _ChangePasswordBodyState extends State<ChangePasswordBody> {
  final _formKey = GlobalKey<FormState>();
  final ProfileCardController controller = Get.put(ProfileCardController());
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController familyController = TextEditingController();
  LoaderController loaderController = Get.put(LoaderController());

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
                  SizedBox(
                    height: Get.height * 0.05,
                  ),
                  AuthFormField(
                    controller: nameController,
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(12.0),
                    ),
                    hint: 'Your Name'.tr,

                  ),
                  SizedBox(
                    height: Get.height * 0.05,
                  ),
                  AuthFormField(
                    controller: phoneController,
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(12.0),
                    ),
                    hint: 'Your Phone Number'.tr,

                  ),
                  SizedBox(
                    height: Get.height * 0.05,
                  ),
                  AuthFormField(
                    controller: familyController,
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(12.0),

                    ),
                    hint: 'Your Family names'.tr,

                  ),
                  SizedBox(
                    height: Get.height * 0.05,
                  ),
                ],
              ),
            ),

            Obx(() {
              return  loaderController.loading.value
                  ? const Center(
                child: CircularProgressIndicator(
                  color: PrimaryColor,
                ),
              )
                  : ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    controller.updateProfile({
                      "name": nameController.text,
                      "phone_number": phoneController.text,
                      "family": familyController.text,
                    });
                  }
                },
                child: Text("Update Profile"),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: PrimaryColor,
                  shadowColor: Colors.black,
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              );
            }),

            Padding(
              padding: const EdgeInsets.only(
                right: 8.0,
                left: 8.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
