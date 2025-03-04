import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import '../Utils/AppStyle.dart';

class doctorList extends StatelessWidget {
  final String image;
  final String maintext;
  final String subtext;
  final String firstmaintext;
  doctorList(
      {
        required this.image,
        required this.maintext,
        required this.subtext,
        required this.firstmaintext});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.15,
          width: MediaQuery.of(context).size.width * 0.9,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Color.fromARGB(255, 226, 226, 226)),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 7.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Align(
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.09,
                        width: MediaQuery.of(context).size.width * 0.2,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle, // تعيين الشكل ليكون دائري
                          border: Border.all(
                            color: Colors.grey.withOpacity(0.5), // تحديد لون الحدود
                            width: 1, // سمك الحدود
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2), // تحديد لون الظل
                              blurRadius: 5, // تحديد تأثير الضبابية للظل
                              offset: Offset(2, 2), // تحديد اتجاه الظل
                            ),
                          ],
                          image: DecorationImage(
                            image: image.isNotEmpty && image.startsWith("http")
                                ? NetworkImage(image)
                                : AssetImage('Assets/images/person.jpg') as ImageProvider,
                            filterQuality: FilterQuality.high,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Text(
                          firstmaintext,
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color:  Colors.black,

                          ),
                          textAlign: TextAlign.center,
                        ),
                        Icon(
                          Icons.star,
                          color: Colors.yellow,
                          size: 18, // حجم الأيقونة (يمكنك تغييره حسب الحاجة)
                        ),
                      ],
                    )

                  ],
                ),
                const SizedBox(
                  width: 20,
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.1200,
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        maintext,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color:  Colors.black,
                          fontWeight: FontWeight.w900
                        ),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Text(
                        "Specialization : ".tr + " "+ subtext,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: TextGrey,
                        ),
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        width: 120,
                        height: 30,
                        child: Container(
                          decoration: BoxDecoration(
                            color: ButtonGrey,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: InkWell(
                            onTap: () {

                            },
                            splashColor: Colors.white.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(8),
                            child: Center(
                              child: Text(
                                "Book Appointment".tr,
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color:PrimaryColor,
                                ),
                              ),
                            ),
                          ),
                        ),
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
