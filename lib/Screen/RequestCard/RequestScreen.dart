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
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              Icons.arrow_back,
              size: 24,
              color: PrimaryColor,
            ),
          ),
        ),
        title: Text(
          "Request Card".tr,
          style: GoogleFonts.poppins(color: Theme.of(context).textTheme.bodyLarge?.color, fontSize: 18),
        ),
        centerTitle: true,
        elevation: 0,
        toolbarHeight: 100,
      ),
      body: RequestScreenBody()

    );
  }
}


