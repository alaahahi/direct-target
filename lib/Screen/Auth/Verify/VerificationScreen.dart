
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import '../../../Controller/VerifySmsController.dart';
import '../../../Utils/AppStyle.dart';

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
      _timeLeft = 60;
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
            Text(
              widget.phoneNumber,
              style: TextStyle(
                  fontSize: 16, fontWeight: FontWeight.bold, color: Colors.blue),
            ),

            const SizedBox(height: 30),

            Form(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Pinput(
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

                  const SizedBox(height: 20),

                  if (_isTimerActive)
                    Text(
                      "Code expires in $_timeLeft sec".tr,
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
                  _startTimer();
            
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
