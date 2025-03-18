import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class InternetController extends GetxController {
  var isConnected = true.obs;

  @override
  void onInit() {
    super.onInit();
    checkInternetOnStart();
    monitorConnection();
  }

  Future<void> checkInternetOnStart() async {
    isConnected.value = await _hasInternet();
    if (!isConnected.value) {
      showNoInternetMessage();
    }
  }

  void monitorConnection() {
    Connectivity().onConnectivityChanged.listen((List<ConnectivityResult> results) async {
      if (results.contains(ConnectivityResult.none)) {
        isConnected.value = false;
        showNoInternetMessage();
      } else {
        bool hasInternet = await _hasInternet();
        isConnected.value = hasInternet;
        if (!hasInternet) {
          showNoInternetMessage();
        }
      }
    });
  }

  Future<bool> _hasInternet() async {
    try {
      final response = await Dio().get('https://www.google.com', options: Options(
        receiveTimeout: Duration(seconds: 2),
        sendTimeout: Duration(seconds: 2),
      ));
      return response.statusCode == 200;
    } catch (_) {
      return false;
    }
  }

  void showNoInternetMessage() {
    Get.snackbar(
      'No Internet Connection'.tr,
      'Please check your internet and try again.'.tr,
      snackPosition: SnackPosition.TOP,
      duration: Duration(seconds: 10),
    );
  }
}
