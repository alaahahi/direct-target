import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'package:get_storage/get_storage.dart';
import 'package:rxdart/rxdart.dart';
import '../../Model/WheelItemModel.dart';
import 'dart:async';
import '../../Utils/AppStyle.dart';
import 'package:get/get.dart';
import '../../Controller/WheelItemController.dart';


class RewardWheelScreen extends StatefulWidget {
  final VoidCallback onClose;
  final List<WheelItem> wheelItems;
  RewardWheelScreen({required this.onClose, required this.wheelItems});

  @override
  _RewardWheelScreenState createState() => _RewardWheelScreenState();
}

class _RewardWheelScreenState extends State<RewardWheelScreen> {
  final selected = BehaviorSubject<int>();
  final rewardController = Get.put(WheelItemController());
  late int randomIndex;
  bool isButtonDisabled = false;
  Duration remainingTime = Duration.zero;
  Timer? countdownTimer;

  final box = GetStorage();

  @override
  void initState() {
    super.initState();
    final canLots = box.read('canLots') ?? 0;
    if (canLots == 0) {
      final lastSpinTimeStr = box.read('lastSpinTime');
      if (lastSpinTimeStr != null) {
        final lastSpinTime = DateTime.tryParse(lastSpinTimeStr);
        if (lastSpinTime != null) {
          final now = DateTime.now();
          final diff = now.difference(lastSpinTime);
          if (diff < Duration(hours: 24)) {
            setState(() {
              isButtonDisabled = true;
              remainingTime = Duration(hours: 24) - diff;
            });
            startCountdownTimer();
          }
        }
      }
    }
    randomIndex = Random().nextInt(widget.wheelItems.length);
    selected.add(randomIndex + widget.wheelItems.length * 10);
  }

  void startCountdownTimer() {
    countdownTimer?.cancel();
    countdownTimer = Timer.periodic(Duration(seconds: 1), (_) {
      if (remainingTime.inSeconds <= 1) {
        setState(() {
          isButtonDisabled = false;
          remainingTime = Duration.zero;
        });
        countdownTimer?.cancel();
      } else {
        setState(() {
          remainingTime -= Duration(seconds: 1);
        });
      }
    });
  }

  void spinLikeSecondHand() async {
    box.write('lastSpinTime', DateTime.now().toIso8601String());
    box.write('canLots', 0);
    setState(() {
      isButtonDisabled = true;
      remainingTime = Duration(hours: 24);
    });

    startCountdownTimer();

    int stepsCount = 8;
    int baseDelay = 150;
    int maxDelay = 600;
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

    final selectedItem = widget.wheelItems[targetIndex];
    rewardController.showRewardDialog(context, selectedItem);
    print('Wheel item ID: ${selectedItem.id}');

    if (selectedItem.id != null) {
      rewardController.storeWheelResult(
        context: context,
        wheelItemId: selectedItem.id!,
        item: selectedItem,
      );
    } else {
      print('Invalid wheel item ID');
    }
  }

  @override
  void dispose() {
    selected.close();
    countdownTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final canLots = box.read('canLots') ?? 0;
    return Scaffold(
      appBar: AppBar(
        title: Text('Wheel of Fortune'.tr),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            if (canLots == 0 && isButtonDisabled)
              Text(
                "You can try after:".tr + "${formatDuration(remainingTime)}",
                style: TextStyle(color: Colors.red, fontSize: 16),
              ),
            SizedBox(
              height: 100,
            ),

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
                onPressed: isButtonDisabled ? null : spinLikeSecondHand,
                style: ElevatedButton.styleFrom(
                  backgroundColor: isButtonDisabled ? Colors.grey : PrimaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Text(
                  "Spin The Wheel".tr,
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

  String formatDuration(Duration d) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final h = twoDigits(d.inHours);
    final m = twoDigits(d.inMinutes.remainder(60));
    final s = twoDigits(d.inSeconds.remainder(60));
    return "$h:$m:$s";
  }
}










