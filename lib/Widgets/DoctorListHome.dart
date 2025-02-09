import 'package:flutter/material.dart';
import 'package:direct_target/Utils/AppStyle.dart';
class list_doctor1 extends StatelessWidget {
  final String image;
  final String maintext;
  final String subtext;
  final String numRating;
  final String distance;

  list_doctor1(
      {required this.distance,
      required this.image,
      required this.maintext,
      required this.numRating,
      required this.subtext});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Color.fromARGB(134, 228, 227, 227)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 15,
            ),
            Center(
              child: Container(
                alignment: Alignment.topCenter,
                height: 80,
                width: 100,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(image),
                        filterQuality: FilterQuality.high,
                        fit: BoxFit.cover),
                    shape: BoxShape.circle),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 10,
                  ),

                  Text(
                    maintext,
                      style: Theme.of(context).textTheme.bodySmall
                  ),

                  Text(
                    subtext,
                      style: Theme.of(context).textTheme.bodySmall
                  ),
                  const SizedBox(
                    height: 15,
                  ),

                  Row(
                    children: [

                      Row(
                        children: [
                          Icon(
                            Icons.star,
                            size: 16,
                            color: Colors.yellow,
                          ),
                          const SizedBox(width: 5),
                          Text(
                            numRating,
                              style: Theme.of(context).textTheme.bodySmall
                          ),
                        ],
                      ),

                      const SizedBox(width: 10),

                      Row(
                        children: [
                          Container(
                            height: 16,
                            width: 16,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(
                                  "Assets/icons/Location.png",
                                ),
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          const SizedBox(width: 5),
                          Text(
                            distance,
                              style: Theme.of(context).textTheme.bodySmall
                          ),
                        ],
                      ),
                    ],
                  ),

                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
