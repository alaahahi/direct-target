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
          height: MediaQuery.of(context).size.height * 0.14,
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
                        height: MediaQuery.of(context).size.height * 0.07,
                        width: MediaQuery.of(context).size.width * 0.1,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          image: DecorationImage(
                            image: image.isNotEmpty && image.startsWith("http")
                                ? NetworkImage(image)
                                : AssetImage('Assets/images/person.png') as ImageProvider,
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
                          style: Theme.of(context).textTheme.bodySmall,
                          textAlign: TextAlign.center,
                        ),
                        Icon(Icons.star, color: Colors.yellow),
                      ],
                    )
                  ],
                ),
                const SizedBox(
                  width: 50,
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.1200,
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        maintext,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      Text(
                        subtext,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: TextGrey,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
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
                                    "Appointment".tr,
                                    style: GoogleFonts.poppins(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: BorderGrey,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(width: 10),
                          Icon(
                            Icons.favorite,
                            color:PrimaryColor,
                          ),
                        ],
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
