import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:direct_target/Utils/AppStyle.dart';

class shedule_card extends StatelessWidget {
  final String mainText;
  final String subText;
  final String image;
  final String date;

  final VoidCallback? onCancel;
  final VoidCallback? onReschedule;

  shedule_card({
    required this.mainText,
    required this.subText,
    required this.date,
    required this.image,
    this.onCancel,
    this.onReschedule,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.28,
      width: MediaQuery.of(context).size.width * 0.9,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.black12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.09,
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          mainText,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        Text(
                          subText,
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(color: TextGrey),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.09,
                  width: MediaQuery.of(context).size.width * 0.2,
                  decoration: BoxDecoration(
                    color: PrimaryColor,
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage(image),
                      filterQuality: FilterQuality.high,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.03,
            width: MediaQuery.of(context).size.width * 0.85,
            child: Row(
              children: [
                Icon(Icons.calendar_today, size: 18, color: TextGrey),
                SizedBox(width: 4),
                Text(date,
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(color: TextGrey)),
                SizedBox(width: 12),
                Icon(Icons.access_time, size: 18, color: TextGrey),
                SizedBox(width: 4),

              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: onCancel,
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.045,
                    width: MediaQuery.of(context).size.width * 0.38,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 232, 233, 233),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        "Cancel".tr,
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge
                            ?.copyWith(color: TextGrey),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: onReschedule,
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.045,
                    width: MediaQuery.of(context).size.width * 0.38,
                    decoration: BoxDecoration(
                      color: PrimaryColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        "Reschedule".tr,
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge
                            ?.copyWith(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
