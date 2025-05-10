import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'package:get_storage/get_storage.dart';
import 'package:rxdart/rxdart.dart';
import '../../Controller/LoaderController.dart';
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

class _RewardWheelScreenState extends State<RewardWheelScreen>  with TickerProviderStateMixin{
  final selected = BehaviorSubject<int>();
  final rewardController = Get.put(WheelItemController());
  late int randomIndex;
  Duration remainingTime = Duration.zero;
  Timer? countdownTimer;
  late TabController tabController;
  final box = GetStorage();
  LoaderController loaderController = Get.put(LoaderController());

  void startCountdownTimer() {
    countdownTimer?.cancel();
    countdownTimer = Timer.periodic(Duration(seconds: 1), (_) {
      if (remainingTime.inSeconds <= 1) {
        setState(() {

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

    setState(() {
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
  void initState() {
    super.initState();
    rewardController.fetchWinsItems();
    final canLots = box.read('canLots') ?? 0;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (canLots == 1 ) {
        spinLikeSecondHand();
      }
    });
    if (canLots == 1) {
      final lastSpinTimeStr = box.read('lastSpinTime');
      if (lastSpinTimeStr != null) {
        final lastSpinTime = DateTime.tryParse(lastSpinTimeStr);
        if (lastSpinTime != null) {
          final now = DateTime.now();
          final diff = now.difference(lastSpinTime);
          if (diff < Duration(hours: 24)) {
            setState(() {

              remainingTime = Duration(hours: 24) - diff;
            });
            startCountdownTimer();
          }
        }
      }
    }

    tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    selected.close();
    countdownTimer?.cancel();
    tabController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final canLots = box.read('canLots') ?? 0;
    return Scaffold(
      appBar: AppBar(
        title: Text('Wheel of Fortune'.tr),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(70),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 10),
              TabBar(
                controller: tabController,
                indicator: BoxDecoration(
                  color: PrimaryColor,
                  borderRadius: BorderRadius.circular(28),
                ),
                dividerColor: Colors.transparent,
                indicatorColor: const Color.fromARGB(255, 241, 241, 241),
                unselectedLabelColor: Colors.grey,
                labelColor: Color.fromARGB(255, 255, 255, 255),
                tabs: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 32, vertical: 2),
                    child: Tab(text: "Wheel of Fortune".tr),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 32, vertical: 2),
                    child: Tab(text: "Other Content".tr),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: TabBarView(
          controller: tabController,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  if (canLots == 1 )
                    ...[
                      SizedBox(height: 100),
                      SizedBox(
                        height: 400,
                        child:
                        FortuneWheel(
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
                    ]
                ],

              ),
            ),
            GetBuilder<WheelItemController>(
              builder: (_) {
                if (_.loaderController.loading.value) {
                  return Center(child: CircularProgressIndicator());
                }

                if (_.allWinsData == null || _.allWinsData!.isEmpty) {
                  return Center(child: Text("لا توجد جوائز حالياً"));
                }

                return ListView.builder(
                  itemCount: _.allWinsData!.length,
                  itemBuilder: (context, index) {
                    final win = _.allWinsData![index];
                    final wheelItem = win.wheelItem;

                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                      color: wheelItem?.color != null
                          ? Color(int.parse(wheelItem!.color!.replaceAll('#', '0xFF')))
                          : Colors.grey[300],
                      child: ListTile(
                        title: Text(
                          wheelItem?.label ?? 'بدون اسم',
                          style: const TextStyle(color: Colors.white70, fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          'تم المطالبة؟: ${win.isClaimed == true ? 'نعم' : 'لا'}\n'
                              'التاريخ: ${win.createdAt ?? "غير متوفر"}',
                          style: const TextStyle(color: Colors.white70),
                        ),
                        trailing: Icon(
                          win.isClaimed == true ? Icons.check_circle : Icons.hourglass_empty,
                          color: Colors.white,
                        ),
                      ),
                    );
                  },
                );
              },
            )

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











