import 'dart:async';
import 'package:flutter/material.dart';
import 'package:direct_target/Screen/OnBoard/BoardingScreen.dart';
import 'package:direct_target/Utils/AppStyle.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {


  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {

      setState(() {});
    });

    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const on_boarding()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height * 0.2;
    return Scaffold(
      backgroundColor: BGColor,
      body: Center(
        child: Container(
          height: height,
          width: MediaQuery.of(context).size.width * 0.6,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("Assets/images/logo1.png"),
            ),
          ),
        ),
      ),
    );
  }
}
