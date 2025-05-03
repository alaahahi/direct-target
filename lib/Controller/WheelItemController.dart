import 'dart:developer';

import 'package:dio/dio.dart' as dio;
import 'package:get/get.dart';

import '../Model/WheelItemModel.dart';
import '../Service/WheelItemService.dart';
import 'LoaderController.dart';


class WheelItemController extends GetxController {
  // var items = <WheelItemModel>[].obs;
  var isLoading = true.obs;
  List<WheelItem>? WheelItems = [];
  final WheelItemService _service = WheelItemService();
  LoaderController loaderController = Get.put(LoaderController());
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

}
