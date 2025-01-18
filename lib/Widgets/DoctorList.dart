import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:direct_target/Utils/AppStyle.dart';
import 'package:easy_localization/easy_localization.dart';
class doctorList extends StatelessWidget {
  final String image;
  final String maintext;
  final String subtext;
  final String numRating;
  final String distance;

  doctorList(
      {required this.distance,
      required this.image,
      required this.maintext,
      required this.numRating,
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
              children: [
                const SizedBox(
                  width: 10,
                ),

                Container(
                  height: MediaQuery.of(context).size.height * 0.1200,
                  width: MediaQuery.of(context).size.width * 0.2400,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      image: DecorationImage(
                          image: AssetImage(image),
                          filterQuality: FilterQuality.high,
                          fit: BoxFit.contain)),
                ),
                const SizedBox(
                  width: 10,
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
                      const SizedBox(
                        height: 25,
                      ),
                      Row(
                        children: [
                          Container(
                            height: MediaQuery.of(context).size.height * 0.01500,
                            width: MediaQuery.of(context).size.width * 0.08,

                            child: Row(children: [
                              Container(
                                height:
                                MediaQuery.of(context).size.height * 0.01500,
                                width: MediaQuery.of(context).size.width * 0.03,
                                 child:  Icon(
                  Icons.star,
                  size: MediaQuery.of(context).size.height * 0.01500,
                  color: Colors.yellow,
                ),
                              ),
                              Text(
                                numRating,
                                style: GoogleFonts.poppins(
                                    fontSize: 11,
                                    color: Color.fromARGB(255, 4, 179, 120),
                                    fontWeight: FontWeight.bold),
                              ),
                            ]),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(children: [
                        Container(
                          height: MediaQuery.of(context).size.height * 0.01500,
                          width: MediaQuery.of(context).size.width * 0.03,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(
                                  "Assets/icons/Location.png",
                                ),
                                filterQuality: FilterQuality.high),
                          ),
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        Text(
                          distance,
                          style: GoogleFonts.poppins(
                              fontSize: 11,
                              color: Color.fromARGB(255, 133, 133, 133),
                              fontWeight: FontWeight.bold),
                        ),
                      ]),
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
