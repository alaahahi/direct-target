import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:direct_target/Utils/AppStyle.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../Controller/AllSettingController.dart';
import '../../../Controller/VerificationWhatsappController.dart';
import '../../../Service/SettingsServices.dart';
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
  final AllSettingController _appController = Get.put(AllSettingController(SettingsServices()));

  String? _verificationId;
  final VerificationWhatsappController controller =
  Get.put(VerificationWhatsappController());
  final _formKey = GlobalKey<FormState>();
  int _selectedTab = 0;
  bool _hasError = false;
  String _errorMessage = '';

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
            SnackBar(content: Text('Verification failed: ${e.message}'.tr)),
          );
        },
        codeSent: (String verificationId, int? resendToken) async {
          _verificationId = verificationId;
          if (resendToken != null) {
            final storage = GetStorage();
            await storage.write('token', resendToken.toString());
          }
          Get.to(
                () => OtpScreen(
              verificationId: verificationId,
              phoneNumber: "+964" + _phoneController.text.trim(),
              firebaseToken: resendToken.toString(),
            ),
          );
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          _verificationId = verificationId;
        },
      );
    }
  }
  bool _isLoading = false;
  bool _isDisabled = false;

  @override
  @override
  Widget build(BuildContext context) {
    List<bool> availableTabs = [
      _appController.appSmsActivate.value,
      _appController.appWhatsappActivate.value
    ];
    int activeTabsCount = availableTabs.where((e) => e).length;

    if (activeTabsCount == 1) {
      _selectedTab = _appController.appSmsActivate.value ? 0 : 1;
    }

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: _hasError ? Colors.red : Colors.grey,
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
                        color: Colors.grey,
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
                              _hasError = true;
                              _errorMessage = "يجب إدخال رقم الهاتف".tr;
                            });
                            return '';
                          } else if (value.length != 10) {
                            setState(() {
                              _hasError = true;
                              _errorMessage = "يجب أن يكون الرقم مكونًا من 10 أرقام".tr;
                            });
                            return '';
                          }
                          setState(() {
                            _hasError = false;
                            _errorMessage = '';
                          });
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
              ),
              if (_hasError)
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
              if (activeTabsCount > 1)
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
                              color: _selectedTab == 0 ? LightGrey : Theme.of(context).textTheme.bodyMedium?.color,
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
                              color: _selectedTab == 1 ? LightGrey : Theme.of(context).textTheme.bodyMedium?.color,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              const SizedBox(height: 60),

              if (activeTabsCount > 0)
                Container(
                  height: MediaQuery.of(context).size.height * 0.05,
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: ElevatedButton(
                    onPressed: _isDisabled
                        ? null
                        : () async {
                      if (_formKey.currentState!.validate()) {
                        setState(() {
                          _isLoading = true;
                          _isDisabled = true;
                        });

                        if (_selectedTab == 0) {
                          _sendCodeToPhoneNumber();
                        } else {
                          await controller.sendVerificationCode(
                            "+964" + _phoneController.text.trim(),
                            context,
                          );
                        }

                        setState(() {
                          _isLoading = false;
                          _isDisabled = false;
                        });
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: PrimaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: _isLoading
                        ? CircularProgressIndicator(color: LightGrey)
                        : Text(
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
        ),
      ),
    );
  }

}
