import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../Controller/AllSettingController.dart';
import '../../../Service/SettingsServices.dart';
import '../../../Utils/AppStyle.dart';
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
                    'Get in Touch'.tr,
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
                            labelText: 'Your Name'.tr,
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your name'.tr;
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 10),

                        TextFormField(
                          controller: emailController,
                          decoration: InputDecoration(
                            labelText: 'your_email'.tr,
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value!.isEmpty || !value.contains('@')) {
                              return 'Please enter a valid email'.tr;
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 10),

                        TextFormField(
                          controller: messageController,
                          maxLines: 4,
                          decoration: InputDecoration(
                            labelText: 'your_message'.tr,
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your message'.tr;
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 20),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                print('Message Sent: ${messageController.text}'.tr);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('success_message'.tr)),
                                );
                              }
                            },
                            child: Text('send_message'.tr,
                              style: TextStyle(color:LightGrey,
                              fontSize: 18),

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
                  Text(
                    'contact_info'.tr,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),

                  Row(
                    children: [
                      Icon(Icons.phone, color: Colors.blue),
                      SizedBox(width: 10),
                      Text('07822999990'),
                    ],
                  ),
          
                  SizedBox(height: 10),

                  Row(
                    children: [
                      Icon(Icons.location_on, color: Colors.blue),
                      SizedBox(width: 10),
                      Text('العراق - بغداد'),
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



