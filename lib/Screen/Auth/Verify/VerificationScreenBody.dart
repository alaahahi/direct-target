import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

import '../../../Controller/VerificationWhatsappController.dart';

import 'package:flutter/cupertino.dart';

import 'package:get/get.dart';

import '../../../Utils/AppStyle.dart';

class VerifyCodeScreen extends StatefulWidget {
  const VerifyCodeScreen({Key? key}) : super(key: key);

  @override
  State<VerifyCodeScreen> createState() => _VerifyCodeScreenState();
}

class _VerifyCodeScreenState extends State<VerifyCodeScreen> {
  final VerificationWhatsappController _controller =
  Get.find<VerificationWhatsappController>(); // جلب الكونترولر

  final TextEditingController _verificationCodeController =
  TextEditingController();
  final _formKey = GlobalKey<FormState>();
  Timer? _timer;
  int _timeLeft = 60;
  bool _isTimerActive = true;

  @override
  void initState() {
    super.initState();
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
          'Verify Phone Number'.tr,
          style: Theme.of(context).textTheme.bodyLarge,
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
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 5),
            Text(
              _controller.phoneNumber.value, 
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Theme.of(context).textTheme.bodyMedium?.color, 
              ),
            ),
            const SizedBox(height: 30),
            Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Pinput(
                    length: 6,
                    defaultPinTheme: defaultPinTheme,
                    onChanged: (value) {
                      _verificationCodeController.text = value;
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
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Theme.of(context).textTheme.bodyMedium?.color, 
                      ),
                    ),

                  const SizedBox(height: 20),

                  Center(
                    child: SizedBox(
                      width: 250.0,
                      child: _controller.isLoading.value
                          ? const CircularProgressIndicator()
                          : ElevatedButton(
                        onPressed: _isTimerActive
                            ? () {
                          _controller.verifyCode(
                            _verificationCodeController.text,
                            context,
                          );
                        }
                            : null,
                        child: Text('Verify Code'.tr,
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
                  // _controller.resendCode();
                },
                child: Text(
                  "Resend Code".tr,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color:Theme.of(context).textTheme.bodyMedium?.color, 
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
