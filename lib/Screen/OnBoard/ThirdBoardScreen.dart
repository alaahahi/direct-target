import 'package:cached_network_image/cached_network_image.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import '../../Controller/AllSettingController.dart';
import '../../Service/SettingsServices.dart';
class OnBoard3 extends StatefulWidget {
  const OnBoard3({super.key});

  @override
  State<OnBoard3> createState() => _OnBoard3State();
}

class _OnBoard3State extends State<OnBoard3> {
  final AllSettingController _controller = Get.put(AllSettingController(SettingsServices()));
  Future<void> _preloadImages() async {
    if (_controller.thirdImageUrl.value.isNotEmpty) {
      await precacheImage(
        CachedNetworkImageProvider(_controller.thirdImageUrl.value),
        context,
      );
    }
  }
  @override
  void initState() {
    super.initState();
    _preloadImages();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Obx(() {
            return Container(
              height: MediaQuery.of(context).size.height * 0.5,
              width: MediaQuery.of(context).size.width * 0.8,
              child: _controller.thirdImageUrl.value.isNotEmpty
                  ? CachedNetworkImage(
                imageUrl: _controller.thirdImageUrl.value,
                placeholder: (context, url) => Center(
                  child: CircularProgressIndicator(),
                ),
                errorWidget: (context, url, error) => Center(
                  child: Icon(Icons.error, color: Colors.red),
                ),
                fit: BoxFit.cover,
              )
                  : Center(
                child: CircularProgressIndicator(),
              ),
            );
          }),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.2,
                  width: MediaQuery.of(context).size.width * 0.9,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color.fromARGB(255, 247, 247, 247),
                        const Color.fromARGB(255, 255, 255, 255),
                      ],
                    ),
                  ),
                  child: Center(
                    child: Text(
                      "Consult only with a doctor\nyou trust".tr,
                      style: GoogleFonts.inter(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: const Color.fromARGB(255, 37, 37, 37)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


