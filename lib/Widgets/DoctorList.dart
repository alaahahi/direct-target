import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class doctorList extends StatelessWidget {
  final String image;
  final String maintext;
  final String subtext;
  doctorList(
      {
        required this.image,
        required this.maintext,
        required this.subtext});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Center(
          child: Container(
            height: MediaQuery.of(context).size.height * 0.2,
            width: MediaQuery.of(context).size.width * 0.9,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Color.fromARGB(255, 226, 226, 226)),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                Align(
                  // alignment: Alignment.topCenter, // محاذاة الصورة في الأعلى قليلاً
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.180,
                    width: MediaQuery.of(context).size.width * 0.250,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        image:DecorationImage(
                          image: image.isNotEmpty && image.startsWith("http")
                              ? NetworkImage(image) // تحميل الصورة من API إذا كانت متوفرة
                              : AssetImage('Assets/images/person.png') as ImageProvider, // صورة افتراضية
                          filterQuality: FilterQuality.high,
                          fit: BoxFit.cover,
                        ),),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.1200,
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        maintext,
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        subtext,
                        style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Colors.black54),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

