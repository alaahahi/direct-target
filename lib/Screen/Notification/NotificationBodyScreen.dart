import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../Controller/AllSettingController.dart';
import '../../../Service/SettingsServices.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
class NotificationBodyScreen extends StatefulWidget {
  const NotificationBodyScreen({super.key});

  @override
  State<NotificationBodyScreen> createState() => _NotificationBodyScreenState();
}

class _NotificationBodyScreenState extends State<NotificationBodyScreen> {
  final AllSettingController _controller = Get.put(AllSettingController(SettingsServices()));

  getToken() async{
    String? myToken =  await FirebaseMessaging.instance.getToken();
    print("llllllllllllllllllllllllllllllllllllllllllllll");
    print(myToken);
  }
  @override
  void initState(){
    getToken();
super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Text("Notification")
        ],
      ),
    );
  }
}



