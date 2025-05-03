import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'package:rxdart/rxdart.dart';
import '../../Model/WheelItemModel.dart';
import 'dart:async';
import '../../Utils/AppStyle.dart';
import 'package:get/get.dart';
class RewardWheelScreen extends StatefulWidget {
  final VoidCallback onClose;
  final List<WheelItem> wheelItems;
  RewardWheelScreen({required this.onClose,required this.wheelItems});

  @override
  _RewardWheelScreenState createState() => _RewardWheelScreenState();
}

class _RewardWheelScreenState extends State<RewardWheelScreen> {
  final selected = BehaviorSubject<int>();

  late int randomIndex;

  @override
  void initState() {
    super.initState();
    randomIndex = Random().nextInt(widget.wheelItems.length);
    selected.add(randomIndex + widget.wheelItems.length * 10);

  }
  void showRewardDialog(WheelItem item) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        backgroundColor: Color(int.parse(item.color!.replaceAll('#', '0xFF'))),
        title: Center(
          child: Icon(Icons.emoji_events, size: 60, color: Colors.amberAccent),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "مبروك! 🎉",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            SizedBox(height: 10),
            Text(
                "لقد ربحت:",
                style: TextStyle(fontSize: 18, color: PrimaryColor ,)
            ),
            SizedBox(height: 10),
            Text(
              item.label ?? 'جائزة غير معروفة',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
              textAlign: TextAlign.center,
            ),
          ],
        ),
        actions: [
          Center(
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text("حسناً"),
            ),
          )
        ],
      ),
    );
  }
  @override
  void dispose() {
    selected.close();
    super.dispose();
  }
  void spinLikeSecondHand() async {
    int stepsCount =  8;
    int baseDelay =150;
    int maxDelay = 600;
    double decelerationPower = 2.5;

    int targetIndex = Random().nextInt(widget.wheelItems.length);

    for (int i = 0; i < stepsCount; i++) {
      double t = i / stepsCount;
      double easedT = Curves.easeOut.transform(t);
      int currentDelay = baseDelay + ((maxDelay - baseDelay) * easedT).toInt();
      await Future.delayed(Duration(milliseconds: currentDelay));

      int indexToSelect = i % widget.wheelItems.length;
      selected.add(indexToSelect);
    }

    selected.add(targetIndex);
    selected.add(targetIndex);
    await Future.delayed(Duration(milliseconds: 800));
    showRewardDialog(widget.wheelItems[targetIndex]);

  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Spin the Wheel!"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 400,
              child: FortuneWheel(
                selected: selected.stream,
                physics: CircularPanPhysics(
                  duration: Duration(seconds: 5),
                  curve: Curves.easeOutCubic,
                ),

                items: [
                  for (var item in widget.wheelItems)
                    FortuneItem(
                      child: Text(
                        item.label ?? 'بدون اسم',
                        style: TextStyle(color: Colors.white),
                      ),
                      style: FortuneItemStyle(
                        color: Color(int.parse(item.color!.replaceAll('#', '0xFF'))),
                        borderColor: Colors.white,
                        borderWidth: 2,
                      ),
                    ),
                ],
                indicators: [
                  FortuneIndicator(
                    alignment: Alignment.topCenter,
                    child: TriangleIndicator(color: Colors.red),
                  ),
                ],
              ),

            ),
            SizedBox(height: 30),
            Container(
              height: MediaQuery.of(context).size.height * 0.07,
              width: MediaQuery.of(context).size.width * 0.9,
              child: ElevatedButton(
                onPressed:
                  spinLikeSecondHand ,
                style: ElevatedButton.styleFrom(
                  backgroundColor: PrimaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Text(
                  "Spin ".tr,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: LightGrey,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}








