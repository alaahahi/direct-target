import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Controller/AllSettingController.dart';
import '../../../Service/SettingsServices.dart';
import '../../../Utils/AppStyle.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:direct_target/Screen/Auth/SignIn/SignInScreen.dart';
import 'package:page_transition/page_transition.dart';
import 'package:direct_target/Screen/Home/HomeScreen.dart';
import 'package:direct_target/Utils/AppStyle.dart';
import 'package:direct_target/Widgets/ThemeToggleButton.dart';
import 'package:direct_target/Widgets/LangToggleButton.dart';
import 'package:direct_target/Controller/ThemeController.dart';
class ContactBodyScreen extends StatefulWidget {
  const ContactBodyScreen({super.key});

  @override
  State<ContactBodyScreen> createState() => __ContactBodyScreenState();
}

class __ContactBodyScreenState extends State<ContactBodyScreen> {
  final AllSettingController _controller = Get.put(AllSettingController(SettingsServices()));
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController messageController = TextEditingController();
  final ThemeController themeController = Get.find<ThemeController>();

  @override
  Widget build(BuildContext context) {
    String logoPath = themeController.isDarkMode.value
        ? "Assets/images/start2.png"
        : "Assets/images/start.png";
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    Color Iconcolor = themeController.isDarkMode.value
        ? LightGrey
        : PrimaryColor;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: screenHeight * 0.3,
              width: screenHeight * 0.3,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(logoPath),
                  filterQuality: FilterQuality.high,
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Get in Touch',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: nameController,
                          decoration: InputDecoration(
                            labelText: 'Your Name',
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your name';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 10),

                        TextFormField(
                          controller: emailController,
                          decoration: InputDecoration(
                            labelText: 'Your Email',
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value!.isEmpty || !value.contains('@')) {
                              return 'Please enter a valid email';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 10),

                        TextFormField(
                          controller: messageController,
                          maxLines: 4,
                          decoration: InputDecoration(
                            labelText: 'Your Message',
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your message';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 20),

                        // زر الإرسال
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                // تنفيذ إرسال الرسالة عبر البريد الإلكتروني
                                print('Message Sent: ${messageController.text}');
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Message Sent Successfully!')),
                                );
                              }
                            },
                            child: Text('Send Message',
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: PrimaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 30),

                  // معلومات الاتصال
                  Text(
                    'Contact Information',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),

                  Row(
                    children: [
                      Icon(Icons.phone, color: Colors.blue),
                      SizedBox(width: 10),
                      Text('+964 123 456 789'),
                    ],
                  ),
                  SizedBox(height: 10),

                  Row(
                    children: [
                      Icon(Icons.email, color: Colors.blue),
                      SizedBox(width: 10),
                      Text('support@example.com'),
                    ],
                  ),
                  SizedBox(height: 10),

                  Row(
                    children: [
                      Icon(Icons.location_on, color: Colors.blue),
                      SizedBox(width: 10),
                      Text('123 Street, City, Country'),
                    ],
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



