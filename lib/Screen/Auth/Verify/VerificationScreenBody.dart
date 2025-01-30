import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';

import '../../../Controller/VerificationWhatsappController.dart';

import 'package:flutter/cupertino.dart';

import 'package:get/get.dart';

import '../../../Utils/AppStyle.dart';


class VerifyCodeScreen extends StatefulWidget {
  const VerifyCodeScreen({super.key});

  @override
  State<VerifyCodeScreen> createState() => _VerifyCodeScreenState();
}

class _VerifyCodeScreenState extends State<VerifyCodeScreen> {
  final TextEditingController _verificationCodeController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String _otp = '';
  @override
  Widget build(BuildContext context) {
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
      appBar: AppBar(title: Text('Verify Code'.tr)),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child:GetBuilder<VerificationWhatsappController>(
          init: VerificationWhatsappController(),
          builder: (controller) {
            return Column(
              children: [
                const SizedBox(height: 50),
                Text(
                  "Enter verification code we have sent to your number".tr,
                  style: GoogleFonts.poppins(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    color: Theme.of(context).textTheme.bodyLarge?.color,
                  ),
                ),
                const SizedBox(height: 20),
                Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Pinput(
                        length: 6,
                        defaultPinTheme: defaultPinTheme,
                        focusedPinTheme: defaultPinTheme.copyWith(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.blue),
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        submittedPinTheme: defaultPinTheme.copyWith(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.blue),
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onChanged: (value) {
                          // _otp = value;
                          _verificationCodeController.text=value;
                        },
                        validator: (value) {
                          if (value == null || value.length != 6) {
                            return 'Please enter a valid 6-digit OTP'.tr;
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20),

                      Center(
                        child: SizedBox(
                          width: 250.0,
                          child:controller.isLoading.value
                              ? CircularProgressIndicator()
                              : ElevatedButton(
                            onPressed: () {
                              controller.verifyCode(

                                _verificationCodeController.text,
                                context,
                              );
                            },
                            child: Text('Verify Code'.tr),
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
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't receive code yet? ".tr,
                      style: GoogleFonts.poppins(
                        fontSize: 15,
                        color: Theme.of(context).textTheme.bodyLarge?.color,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                      },
                      child: Text(
                        "Resend".tr,
                        style: GoogleFonts.poppins(
                          fontSize: 15,
                          color: Colors.blue,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}


















