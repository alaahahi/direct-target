
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import '../../../Controller/VerifySmsController.dart';
import '../../../Utils/AppStyle.dart';


class OtpScreen extends StatelessWidget {
  final String verificationId;
  final String phoneNumber;
  final String firebaseToken;

  OtpScreen({required this.verificationId, required this.phoneNumber, required this.firebaseToken});

  @override
  Widget build(BuildContext context) {
    final OtpController otpController = Get.put(OtpController());
    otpController.setVerificationData(verificationId, phoneNumber, firebaseToken);

    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: TextStyle(
        fontSize: 22,
        color: Colors.black,
        fontWeight: FontWeight.w600,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const SizedBox(height: 50),
            Text("Enter verification code we have sent to your number".tr),
            const SizedBox(height: 20),
            Form(
              child: Column(
                children: [
                  Pinput(
                    length: 6,
                    defaultPinTheme: defaultPinTheme,
                    onChanged: (value) {
                      otpController.otp.value = value;
                    },
                    validator: (value) {
                      if (value == null || value.length != 6) {
                        return 'Please enter a valid 6-digit OTP'.tr;
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  Obx(
                        () => otpController.isLoading.value
                        ? CircularProgressIndicator()
                        : ElevatedButton(
                      onPressed: () => otpController.verifyOtp(otpController.otp.value),
                      child: Text('Verify'.tr),
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
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
