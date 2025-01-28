import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:direct_target/Screen/Home/DashboardScreen.dart';
import 'package:direct_target/Screen/Services/ServiceScreen.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CardScreenBody extends StatefulWidget {
  const CardScreenBody({super.key});

  @override
  State<CardScreenBody> createState() => _CardScreenBodyState();
}

class _CardScreenBodyState extends State<CardScreenBody> {
  @override
  Widget build(BuildContext context) {
    return  SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CarouselSlider(
                items: [
                  'Assets/images/1.jpg',
                  'Assets/images/2.jpg',
                  'Assets/images/3.jpg'
                ].map((item) {
                  return Builder(
                    builder: (BuildContext context) {
                      return GestureDetector(
                        onTap: () {

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Servicescreen(),
                            ),
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
                          width: MediaQuery.of(context).size.width,
                          height: 50,
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(20.0),
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: 150,
                                    child: Image.asset(item, fit: BoxFit.cover),
                                  ),
                                ),
                                SizedBox(height: 8.0),
                                Text(
                                  'News for up-to-the-minute news, breaking news, video, audio and feature stories.'.tr,

                                  maxLines: 2,

                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }).toList(),
                options: CarouselOptions(
                  height: 250,
                  enlargeCenterPage: true,
                  autoPlay: true,
                  aspectRatio: 4 / 3,
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enableInfiniteScroll: true,
                  autoPlayAnimationDuration: Duration(milliseconds: 800),
                  viewportFraction: 0.8,
                ),
              ),
              DashboardScreen(),

            ]
        ),
      ),
    );

  }
}
