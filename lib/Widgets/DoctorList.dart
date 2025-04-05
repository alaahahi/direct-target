import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import '../Utils/AppStyle.dart';

class doctorList extends StatelessWidget {
  final String image;
  final String maintext;
  final String subtext;
  final String firstmaintext;

  doctorList({
    required this.image,
    required this.maintext,
    required this.subtext,
    required this.firstmaintext,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Color.fromARGB(255, 226, 226, 226)),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 10.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.09,
                    width: MediaQuery.of(context).size.width * 0.2,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.grey.withOpacity(0.5), width: 1),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 5,
                          offset: Offset(2, 2),
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
                  const SizedBox(width: 15),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          maintext,
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: Colors.black,
                            fontWeight: FontWeight.w900,
                          ),
                          softWrap: true,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          subtext,
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: TextGrey,
                          ),
                          softWrap: true,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0,),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          firstmaintext,
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(width: 5),
                        Icon(
                          Icons.star,
                          color: Colors.yellow,
                          size: 18,
                        ),
                      ],
                    ),
                    const SizedBox(width: 30),
                    Container(
                      width: 160,
                      height: 35,
                      decoration: BoxDecoration(
                        color: ButtonGrey,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: InkWell(
                        onTap: () {},
                        splashColor: Colors.white.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(8),
                        child: Center(
                          child: Text(
                            "Book Appointment".tr,
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: PrimaryColor,
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
    );
  }
}
