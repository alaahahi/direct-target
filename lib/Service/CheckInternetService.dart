import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';

class CheckInternetService extends GetxService {
  final Connectivity _connectivity = Connectivity();

  Future<CheckInternetService> init() async {
    checkConnection();
    _connectivity.onConnectivityChanged.listen((status) {
      checkConnection();
    });
    return this;
  }

  void checkConnection() async {
    var result = await _connectivity.checkConnectivity();
    if (result == ConnectivityResult.none) {
      Get.snackbar(
        'No Internet Connection'.tr,
        'Please check your internet connection and try again.'.tr,
        snackPosition: SnackPosition.TOP,
        duration: Duration(seconds: 15),
      );
    }
  }
}
