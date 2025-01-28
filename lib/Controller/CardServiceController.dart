import 'package:get/get.dart';

import 'package:direct_target/Model/CardServicesModel.dart';

import '../Service/CardServices.dart';



class CardServiceController extends GetxController {
  final CardServices apiService = CardServices();
  var cardServices = <CardService>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchCardServices(1);
  }

  void fetchCardServices(int cardId) async {
    isLoading(true);
    try {
      final services = await apiService.fetchActiveCardServices(cardId);
      cardServices.assignAll(services);
    } catch (e) {
      print("Error: $e");
      Get.snackbar("Error", "Failed to load card services",
          snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading(false);
    }
  }
}


