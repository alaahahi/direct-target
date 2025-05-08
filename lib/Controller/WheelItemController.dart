import 'dart:developer';

import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Model/WheelItemModel.dart';
import '../Service/WheelItemService.dart';
import '../Utils/AppStyle.dart';
import 'LoaderController.dart';
import 'MessageHandlerController.dart';


class WheelItemController extends GetxController {
  var isLoading = true.obs;
  List<WheelItem>? WheelItems = [];
  final WheelItemService _service = WheelItemService();
  LoaderController loaderController = Get.put(LoaderController());
  MessagesHandlerController msgController =
  Get.put(MessagesHandlerController());
  @override
  void onInit() {
    super.onInit();
    fetchItems();
  }

  Future<dynamic> fetchItems() async {
    loaderController.loading(true);
    update();
    try {
      var res = await _service.fetchWheelItems();
      WheelItems = res?.data;
      print('Fetched Data Length getCardServices ${WheelItems?.length}');
    } catch (e) {
      if (e is dio.DioException) {
        log(e.toString());
      } else {
        print('Error fetching data: $e');
      }
    }
    update();
    loaderController.loading(false);
  }

  void showRewardDialog(BuildContext context, WheelItem item) {
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
              style: TextStyle(fontSize: 18, color: PrimaryColor),
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
  Future<dynamic> storeWheelResult({
    required BuildContext context,
    required int wheelItemId,
    required WheelItem item,
  }) async {
    loaderController.loading(true);
    dio.FormData request = dio.FormData.fromMap({'wheel_item_id': wheelItemId});

    try {
      var response = await WheelItemService().storeWheelResult(request);

      print("FormData sent");

      if (response.message == "تمت العملية بنجاح") {
        showRewardDialog(context, item);
      } else {
        msgController.showErrorMessage(
          'فشل في إرسال الطلب',
          'حاول لاحقاً',
        );
      }
    } catch (e) {
      msgController.showErrorMessage(
        'حدث خطأ',
        'أثناء تنفيذ الطلب',
      );
      print(e.toString());
    } finally {
      loaderController.loading(false);
      isLoading(false);
    }
  }


}
