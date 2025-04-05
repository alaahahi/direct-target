import 'package:flutter/material.dart';

import 'package:get/get.dart';
class CategoryList extends StatelessWidget {
  final String image;
  final String maintext;
  final int subtext;

  CategoryList(
      {
        required this.image,
        required this.maintext,
        required this.subtext,});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.14,
          width: MediaQuery.of(context).size.width ,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Color.fromARGB(255, 226, 226, 226)),
            borderRadius: BorderRadius.circular(12),
          ),
          child:  Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.1,
                  width: MediaQuery.of(context).size.height * 0.9,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    image: DecorationImage(
                      image: image.isNotEmpty && image.startsWith("http")
                          ? NetworkImage(image)
                          : AssetImage('Assets/images/hospital.png') as ImageProvider,
                      filterQuality: FilterQuality.high,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Text(
                  maintext,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color:  Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),

              Expanded(
                flex: 1,
                child: Text(
                  "discount".tr + " " + " ${subtext.toString()}%",
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Colors.green,
                  ),
                  textAlign: TextAlign.center,
                ),

              ),
            ],
          ),
        ),
      ),
    );

  }
}
