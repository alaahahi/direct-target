import 'package:direct_target/Utils/AppStyle.dart';
import 'package:flutter/material.dart';


class DoctorDetailsList extends StatelessWidget {
  final String image;
  final String maintext;
  final String subtext;
  final String firstmaintext;
  final int secondmaintext;
  final int thirdmaintext;
  DoctorDetailsList({
    required this.image,
    required this.maintext,
    required this.subtext,
    required this.firstmaintext,
    required this.secondmaintext,
    required this.thirdmaintext,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.1,
            width: MediaQuery.of(context).size.height * 0.1,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              image: DecorationImage(
                image: image.isNotEmpty && image.startsWith("http")
                    ? NetworkImage(image)
                    : AssetImage('Assets/images/person.jpg') as ImageProvider,
                filterQuality: FilterQuality.high,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            maintext,
            style: Theme.of(context).textTheme.headlineLarge,
            textAlign: TextAlign.center,
          ),
          Text(
            subtext,
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 30),
          Container(
            height: MediaQuery.of(context).size.height * 0.15,
            width: MediaQuery.of(context).size.width * 0.9,
            decoration: BoxDecoration(
              color: PrimaryColor,
              borderRadius: BorderRadius.circular(18),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.1,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Color.fromARGB(255, 226, 226, 226)),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "+",
                                  style: TextStyle(
                                    fontSize: 32,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue,
                                  ),
                                ),

                                const SizedBox(width: 1),
                                Text(
                                  firstmaintext,
                                  style: Theme.of(context).textTheme.displayLarge?.copyWith(
                                    color: Colors.blue,
                                  ),
                                  textAlign: TextAlign.center,
                                ),

                              ],
                            ),
                            const SizedBox(height: 5),
                            Text(
                              "Reviews Rate",
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: TextGrey,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        )
                        ,
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.1,
                      child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Color.fromARGB(255, 226, 226, 226)),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "+",
                                    style: TextStyle(
                                      fontSize: 32,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.green,
                                    ),
                                  ),

                                  const SizedBox(width: 1),
                                  Text(
                                    secondmaintext.toString(),
                                    style: Theme.of(context).textTheme.displayLarge?.copyWith(
                                      color: Colors.green,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),

                                ],
                              ),
                              const SizedBox(height: 5),
                              Text(
                                "Exp Years",
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  color: TextGrey,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          )
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.1,
                      child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Color.fromARGB(255, 226, 226, 226)),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "+",
                                    style: TextStyle(
                                      fontSize: 32,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.deepPurple,
                                    ),
                                  ),

                                  const SizedBox(width: 1),
                                  Text(
                                    thirdmaintext.toString(),
                                    style: Theme.of(context).textTheme.displayLarge?.copyWith(
                                      color:  Colors.deepPurple,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),

                                ],
                              ),
                              const SizedBox(height: 5),
                              Text(
                                "Patients",
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  color: TextGrey,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          )
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )

        ],
      ),
    );
  }
}
