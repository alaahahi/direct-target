import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:page_transition/page_transition.dart';
import 'package:direct_target/Utils/AppStyle.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../Controller/VerificationWhatsappController.dart';
import '../../Start/StartScreen.dart';
import '../Verify/VerificationScreen.dart';

class SignInScreenBody extends StatefulWidget {
  const SignInScreenBody({super.key});

  @override
  State<SignInScreenBody> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreenBody>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _phoneController = TextEditingController();
  String? _verificationId;
  final VerificationWhatsappController controller =
      Get.put(VerificationWhatsappController());
  final _formKey = GlobalKey<FormState>();
  int _selectedTab = 0;
  bool _hasError = false; // قم بإزالة final هنا
  String _errorMessage = ''; // لتخزين رسالة الخطأ

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 2);
    _tabController.addListener(() {
      setState(() {
        _selectedTab = _tabController.index;
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

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
            SnackBar(content: Text('Verification failed: ${e.message}')),
          );
        },
        codeSent: (String verificationId, int? resendToken) async {
          _verificationId = verificationId;
          if (resendToken != null) {
            final storage = GetStorage();
            await storage.write('token', resendToken.toString());
          }
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => OtpScreen(
                verificationId: verificationId,
                phoneNumber: "+964" + _phoneController.text.trim(),
                firebaseToken: resendToken.toString(),
              ),
            ),
          );
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          _verificationId = verificationId;
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Theme.of(context).textTheme.bodyMedium?.color),
          onPressed: () {
            Navigator.push(
              context,
              PageTransition(
                type: PageTransitionType.leftToRight,
                child: StartScreen(),
              ),
            );
          },
        ),
        centerTitle: true,
        title: Text("Login".tr, style: Theme.of(context).textTheme.titleMedium),
        toolbarHeight: 110,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: _hasError ? Colors.red : Colors.grey, // تغيير اللون إلى الأحمر عند وجود خطأ
                    width: 2,
                  ),
                ),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: Image.asset(
                        'Assets/images/iraq.png',
                        width: 28,
                        height: 20,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '+964',
                      style: TextStyle(
                        fontSize: 16,
                        color: Theme.of(context).textTheme.bodyMedium?.color,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextFormField(
                        controller: _phoneController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "7 XXX XXX XX",
                          hintStyle: TextStyle(color: Colors.grey),
                        ),
                        keyboardType: TextInputType.phone,
                        style: TextStyle(color: Colors.black),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            setState(() {
                              _hasError = true; // تفعيل الخطأ
                              _errorMessage = "يجب إدخال رقم الهاتف";
                            });
                            return ''; // إرجاع قيمة فارغة لمنع رسالة الخطأ من الظهور داخل الـ Input
                          } else if (value.length != 10) {
                            setState(() {
                              _hasError = true; // تفعيل الخطأ
                              _errorMessage = "يجب أن يكون الرقم مكونًا من 10 أرقام";
                            });
                            return ''; // إرجاع قيمة فارغة
                          }
                          setState(() {
                            _hasError = false; // إلغاء الخطأ إذا كانت القيمة صحيحة
                            _errorMessage = ''; // إلغاء رسالة الخطأ
                          });
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
              ),
              if (_hasError) // عرض الرسالة إذا كان هناك خطأ
                Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: Text(
                    _errorMessage,
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 12,
                    ),
                  ),
                ),
              const SizedBox(height: 50),
              TabBar(
                unselectedLabelColor: BorderGrey,
                labelColor: Colors.white,
                indicatorColor: Colors.transparent,
                indicatorWeight: 2,
                indicator: BoxDecoration(
                  color: PrimaryColor,
                  borderRadius: BorderRadius.circular(22),
                ),
                indicatorSize: TabBarIndicatorSize.tab,
                dividerColor: Colors.transparent,
                controller: _tabController,
                tabs: [
                  Tab(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.0),
                      child: Text(
                        "SMS Code".tr,
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Theme.of(context).textTheme.bodyMedium?.color,
                        ),
                      ),
                    ),
                  ),
                  Tab(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12.0),
                      child: Text(
                        "WhatsApp".tr,
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Theme.of(context).textTheme.bodyMedium?.color,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 60),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.05,
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          if (_selectedTab == 0) {
                            _sendCodeToPhoneNumber();
                          } else {
                            controller.sendVerificationCode(
                              "+964" + _phoneController.text.trim(),
                              context,
                            );
                          }
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: PrimaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: Text(
                        _selectedTab == 0 ? "Verify SMS".tr : "Verify WhatsApp".tr,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: LightGrey,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
