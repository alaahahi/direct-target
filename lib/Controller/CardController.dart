import 'dart:convert';

import 'package:dio/dio.dart' as dio;
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:direct_target/Controller/MessageHandlerController.dart';
import '../Model/RequestCardModel.dart';
import '../Routes/Routes.dart';
import '../Service/CardServices.dart';
import 'LoaderController.dart';
import 'package:path/path.dart' as path;

class CardController extends GetxController {
  LoaderController loaderController = Get.put(LoaderController());
  MessagesHandlerController msgController =
  Get.put(MessagesHandlerController());
  var firstImageUrl = ''.obs;

  GetStorage box = GetStorage();
  final CardServices _service;
  var isLoading = false.obs;

  CardController(this._service);

  @override
  void onInit() {
    super.onInit();
  }

  Future<void> RequestCard(RequestCardData cardRequest) async {
    isLoading(true);
    loaderController.loading(true);

    try {
      dio.MultipartFile? file;
      if (cardRequest.image != null) {
        file = await dio.MultipartFile.fromFile(
          cardRequest.image!,
          filename: path.basename(cardRequest.image!),
        );
      }
      var formData = dio.FormData.fromMap({
        'name': cardRequest.name,
        'phone': cardRequest.phone,
        'address': cardRequest.address,
        'card_number': cardRequest.cardNumber,
        'family_members_names': jsonEncode(cardRequest.familyMembersNames),

        'image': file,
      });
      final response = await _service.RequestCard(formData);

      if (response.message == "Request submitted successfully. Our team will contact you shortly.") {
        msgController.showSuccessMessage('Request submitted successfully.', cardRequest.name);
        Get.offAllNamed(AppRoutes.homescreen);
      } else {
        msgController.showErrorMessage('Failed to submit request', 'Please try again later');
      }
    } catch (e) {
      msgController.showErrorMessage('Error occurred', 'An error occurred while processing your request');
      print(e.toString());
    } finally {
      loaderController.loading(false);
      isLoading(false);
    }
  }

}
