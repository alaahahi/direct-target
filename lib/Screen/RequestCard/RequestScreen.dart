import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../Utils/AppStyle.dart';
import 'package:page_transition/page_transition.dart';
import 'package:direct_target/Screen/Home/HomeScreen.dart';
import 'RequestScreenBody.dart';
class RequestScreen extends StatefulWidget {
  const RequestScreen({super.key});

  @override
  State<RequestScreen> createState() => _RequestScreenState();
}

class _RequestScreenState extends State<RequestScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
            onTap: () {
              Navigator.pushReplacement(
                  context,
                  PageTransition(
                      type: PageTransitionType.fade, child: Homepage()));
            },
            child: Container(
              height: 10,
              width: 10,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("Assets/icons/back1.png"),
                  )),
            ),
          ),
          title: Text(
            "Request Card".tr,
            style: GoogleFonts.poppins(
                color: Theme.of(context).textTheme.bodyLarge?.color,
                fontSize: 18),
          ),
          centerTitle: true,
          elevation: 0,
          toolbarHeight: 100,
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                height: 10,
                width: 10,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("Assets/icons/more.png"),
                    )),
              ),
            ),
          ],
        ),
      body: RequestScreenBody()

    );
  }
}


