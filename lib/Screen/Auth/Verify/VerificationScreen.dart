
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import '../../../Controller/VerifySmsController.dart';
import '../../../Utils/AppStyle.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:direct_target/Utils/AppStyle.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../Controller/VerificationWhatsappController.dart';
import '../Verify/VerificationScreen.dart';
class OtpScreen extends StatefulWidget {
  final String verificationId;
  final String phoneNumber;
  final String firebaseToken;

  OtpScreen({
    required this.verificationId,
    required this.phoneNumber,
    required this.firebaseToken,
  });

  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final OtpController otpController = Get.put(OtpController());
  Timer? _timer;
  int _timeLeft = 60;
  bool _isTimerActive = true;
  final TextEditingController _phoneController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String? _verificationId;
  final VerificationWhatsappController controller =
  Get.put(VerificationWhatsappController());
  final _formKey = GlobalKey<FormState>();

  void _sendCodeToPhoneNumber() async {
    if (_formKey.currentState!.validate()) {
      await _auth.verifyPhoneNumber(
        phoneNumber: "+964" + _phoneController.text.trim(),
        timeout: Duration(seconds: 120),
        verificationCompleted: (PhoneAuthCredential credential) {
          _auth.signInWithCredential(credential);
        },
        verificationFailed: (FirebaseAuthException e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('فشل التحقق: ${e.message}'.tr)),
          );
        },
        codeSent: (String verificationId, int? resendToken) async {
          _verificationId = verificationId;
          if (resendToken != null) {
            final storage = GetStorage();
            await storage.write('token', resendToken.toString());
          }
          _startTimer();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('تم إرسال الرمز بنجاح'.tr)),
          );
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          _verificationId = verificationId;
        },
      );
    }
  }

  @override
  void initState() {
    super.initState();
    otpController.setVerificationData(
        widget.verificationId, widget.phoneNumber, widget.firebaseToken);
    _startTimer();
  }

  void _startTimer() {
    setState(() {
      _isTimerActive = true;
      _timeLeft = 180;
    });

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_timeLeft > 0) {
        setState(() {
          _timeLeft--;
        });
      } else {
        _timer?.cancel();
        setState(() {
          _isTimerActive = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

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
        color: Colors.white,
      ),
    );

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        elevation: 0,
        title: Text(
          "Verify Phone Number".tr,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            Text(
              "We sent a verification code to".tr,
              style: TextStyle(fontSize: 15),
            ),
            const SizedBox(height: 5),
            Directionality(
              textDirection: TextDirection.ltr,
              child: Text(
                widget.phoneNumber,
                style: TextStyle(
                    fontSize: 16, fontWeight: FontWeight.bold, color: Colors.blue),
              ),
            ),

            const SizedBox(height: 30),

            Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Directionality(
                    textDirection: TextDirection.ltr,
                    child: Pinput(
                      length: 6,
                      defaultPinTheme: defaultPinTheme,
                      enabled: _isTimerActive, 
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
                  ),

                  const SizedBox(height: 20),

                  if (_isTimerActive)
                    Text(
                      "Code expires in".tr + "$_timeLeft" + "sec".tr,
                      style: TextStyle(fontSize: 14),
                    ),

                  const SizedBox(height: 20),

                  Obx(
                        () => otpController.isLoading.value
                        ? CircularProgressIndicator()
                        : Container(
                      height: MediaQuery.of(context).size.height * 0.07,
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: ElevatedButton(
                        onPressed: _isTimerActive
                            ? () => otpController
                            .verifyOtp(otpController.otp.value)
                            : null, 
                        child: Text('Verify'.tr,
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: LightGrey,
                          ),),
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

            if (!_isTimerActive)
              GestureDetector(
                onTap: () {
                  _sendCodeToPhoneNumber();
                },
                child: Text(
                  "Resend Code".tr,
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.blue,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
