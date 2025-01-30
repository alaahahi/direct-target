import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
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

class _SignInScreenState extends State<SignInScreenBody>  with SingleTickerProviderStateMixin  {
  late TabController _tabController;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _phoneController = TextEditingController();
  String? _verificationId;
  final VerificationWhatsappController controller = Get.put(VerificationWhatsappController());
  final _formKey = GlobalKey<FormState>();
  void _sendCodeToPhoneNumber() async {
    if (_formKey.currentState!.validate()) {
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: "+964" +_phoneController.text.trim(),
        timeout: Duration(seconds: 60),
        verificationCompleted: (PhoneAuthCredential credential) {
          FirebaseAuth.instance.signInWithCredential(credential);
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
            print('Token saved: ${resendToken.toString()}'); // تحقق من أنه تم حفظ التوكين
          }

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => OtpScreen(verificationId: verificationId, phoneNumber: "+964" +_phoneController.text.trim(), firebaseToken: resendToken.toString()),
            ),
          );
        },

        codeAutoRetrievalTimeout: (String verificationId) {
          _verificationId = verificationId;
        },
      );
    }
  }
  int _selectedTab = 0;
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Container(
            height: MediaQuery.of(context).size.height * 0.06,
            width: MediaQuery.of(context).size.width * 0.06,
            child: Image.asset("Assets/icons/back2.png"),
          ),
          onPressed: () {
            Navigator.push(
              context,
              PageTransition(
                type: PageTransitionType.leftToRight,
                child: Startscreen(),
              ),
            );
          },
        ),
        centerTitle: true,
        title: Text(
          "Login".tr,
          style: GoogleFonts.inter(
            color: Theme.of(context).textTheme.bodyLarge?.color,
            fontSize: 22,
            fontWeight: FontWeight.w700,
            letterSpacing: 0,
          ),
        ),
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
                  border: Border.all(color: Colors.grey),
                ),
                child: Row(
                  children: [
                    Row(
                      children: [
                        ClipRRect(
                          borderRadius:
                          BorderRadius.circular(4),
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
                          style: TextStyle(fontSize: 16,
                            color: Theme.of(context).textTheme.bodyMedium?.color,),
                        ),
                      ],
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextFormField(
                        controller: _phoneController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "07 XXX XXX XX",
                          hintStyle: TextStyle(color: Colors.grey),
                        ),
                        keyboardType: TextInputType.phone,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(
                height: 50,
              ),
              Column(
                children: [
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
                    tabs:  [
                      Tab(
                        child: Padding(
                          padding: EdgeInsets.only(left: 24.0, right: 24.0),
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
                          padding: EdgeInsets.only(left: 12.0, right: 12.0),
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
                  const SizedBox(
                    height:60,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 0.05,
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: ElevatedButton(
                          onPressed: () {
                            if (_selectedTab == 0) {
                              _sendCodeToPhoneNumber();
                            } else {
                              controller.sendVerificationCode("+964" +_phoneController.text.trim(), context);

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
                            style: GoogleFonts.poppins(
                              fontSize: 18,
                              color: LightGrey,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 0,
                            ),
                          ),
                        ),
                      ),
                    ],
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
