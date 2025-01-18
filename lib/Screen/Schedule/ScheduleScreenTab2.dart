import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
class shedule_tab2 extends StatelessWidget {
  const shedule_tab2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Center(
          child: Text(
            "Nothing to show".tr,
            style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              color: Theme.of(context).textTheme.bodyLarge?.color,),
          ),
        )
      ]),
    );
  }
}
