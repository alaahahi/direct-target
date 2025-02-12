import 'dart:async';
import 'package:flutter/material.dart';
import 'package:direct_target/Screen/OnBoard/BoardingScreen.dart';
import 'package:direct_target/Utils/AppStyle.dart';
import 'package:get/get.dart';
import '../Controller/AllSettingController.dart';
import '../Service/SettingsServices.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final AllSettingController _controller = Get.put(AllSettingController(SettingsServices()));

  Future<void> _loadImages() async {
    await _controller.fetchWelcomeImages();

    for (String url in [
      _controller.firstImageUrl.value,
      _controller.secondImageUrl.value,
      _controller.thirdImageUrl.value,
    ]) {
      if (url.isNotEmpty) {
        await precacheImage(NetworkImage(url), context);
      }
    }

  }

  @override
  void initState() {
    super.initState();
    _loadImages();
    WidgetsBinding.instance.addPostFrameCallback((_) {

      setState(() {});
    });
    Timer(const Duration(seconds: 4), () {
    Get.off(() => const on_boarding());
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
