import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:get/get.dart';
import 'package:direct_target/Screen/Services/Doctor/SearchScreen.dart';
import 'package:direct_target/Controller/ThemeController.dart';
import 'package:google_fonts/google_fonts.dart';
class Servicescreen extends StatelessWidget {
  final List<Map<String, dynamic>> centers = [
    {
      'name': 'مركز الشفاء',
      'discount': 20,
      'services': ['فحص شامل', 'استشارة طبية'],
      'image': 'Assets/images/capsules.png',
      'doctors': [
        {'name': 'د. أحمد', 'specialty': 'طبيب عام', 'phone': '0123456789'},
        {'name': 'د. ليلى', 'specialty': 'أخصائي أطفال', 'phone': '0123456788'},
      ],
    },
    {
      'name': 'مركز الأمل',
      'discount': 15,
      'services': ['تحاليل طبية', 'علاج طبيعي'],
      'image': 'Assets/images/capsules2.png',
      'doctors': [
        {'name': 'د. سامي', 'specialty': 'أخصائي قلب', 'phone': '0123456787'},
      ],
    },
  ];
  final List<Map<String, dynamic>> services = [
    {'icon': Icons.local_hospital, 'name': 'Doctors'},
    {'icon': Icons.local_pharmacy, 'name': 'Pharmacy'},
    {'icon': Icons.biotech, 'name': 'Laboratories'},
    {'icon': Icons.camera_alt, 'name': 'Radiology'},
    {'icon': Icons.healing, 'name': 'Therapy'},
    {'icon': Icons.vaccines, 'name': 'Vaccination'},
  ];
  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.find<ThemeController>();

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 1,
            ),
            itemCount: services.length,
            itemBuilder: (context, index) {
              final service = services[index];

              return GestureDetector(
                onTap: () {

                  print("Selected ${service['name']}");

                  Navigator.pushReplacement(
                    context,
                    PageTransition(
                      type: PageTransitionType.rightToLeft,
                      child: doctor_search(),
                    ),
                  );
                },
                child: Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        service['icon'],
                        size: 48,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        service['name'],
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),

    );
  }
}



