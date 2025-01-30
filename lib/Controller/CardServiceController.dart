import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../Model/CardServicesModel.dart';
import '../Service/CardServices.dart';
import 'LoaderController.dart';
import 'MessageHandlerController.dart';
import 'dart:developer';
import 'package:dio/dio.dart' as dio;


class CardServiceController extends GetxController {
  LoaderController loaderController = Get.put(LoaderController());
  MessagesHandlerController msgController =
  Get.put(MessagesHandlerController());
  GetStorage box = GetStorage();

  List<CardService>? allServiceList = [];
  @override
  void onInit() {
    super.onInit();
    fetchCardServices(1);
  }



  Future<dynamic> fetchCardServices(int cardId) async {
    loaderController.loading(true);
    try {
      var res = await CardServices().fetchListAllServices(cardId);

      allServiceList = res.CardServiceData!;
      print(allServiceList?.length);
    } catch (e) {
      if (e is dio.DioException) {
        log(e.toString());
      } else {
        print('errorrrrrr is $e');
      }
    }
    update();
    loaderController.loading(false);
  }

}



