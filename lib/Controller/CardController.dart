import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart' as dio;
import 'package:direct_target/Model/CardModel.dart';
import 'package:direct_target/Model/PopularServiceModel.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:direct_target/Controller/MessageHandlerController.dart';
import '../Model/AllCardServicesModel.dart';
import '../Model/CardServicesModel.dart';
import '../Model/ProfileCardModel.dart';
import '../Model/RequestCardModel.dart';
import '../Routes/Routes.dart';
import '../Service/CardServices.dart';
import '../Service/ProfileCardServices.dart';
import 'LoaderController.dart';
import 'package:path/path.dart' as path;

class CardController extends GetxController {
  LoaderController loaderController = Get.put(LoaderController());
  MessagesHandlerController msgController =
  Get.put(MessagesHandlerController());
  var firstImageUrl = ''.obs;
  String? selectedCategory;


  GetStorage box = GetStorage();
  final CardServices _service;
  var isLoading = false.obs;
  List<CardData>? allCardList = [];
  List<AllCardServicesData>? servicesList = [];
  List<AllCardServicesData>? searchServicesList = [];
  List<PopularServiceData>? allServicesList = [];
  List<ProfileData>? allMyCardList = [];
  CardController(this._service);
  var searchTerm = "".obs;
  GetStorage storage = GetStorage();

  List<Services> selectedServices = [];
  void setSelectedCategory(String? categoryName, List<Services> services) {
    selectedCategory = categoryName;
    selectedServices = services;
    update();
  }
  @override
  void onInit() {
    super.onInit();
    getCards();
    getPopularService();
    getCardServices(1);
    fetchMyCards();
    searchServices("");
  }

  void updateSelectedCategory(String category) {
    selectedCategory = category;
    update();
  }
  Future<void> RequestCard(RequestCardData cardRequest) async {
    isLoading(true);
    loaderController.loading(true);
    bool isAdmin = storage.read('isAdmin') ?? false;
    int adminValue = isAdmin ? 1 : 0;
    print(adminValue);
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
        'is_admin': adminValue,
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

  Future<dynamic> getCards() async {
    loaderController.loading(true);
    update();
    try {
      var res = await CardServices().fetchCard();
      allCardList = res.CardsData!;
      print('Fetched Data Length: ${allCardList?.length}');
      print('Fetched Data: $allCardList');
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
  Future<dynamic> getPopularService() async {
    loaderController.loading(true);
    update();
    try {
      var res = await CardServices().fetchPopularService();
      allServicesList = res?.data;
      print('Fetched Dataaaaaaaaaa Length: ${allServicesList?.length}');
      print('Fetched Dataaaaaaaaa: $allServicesList');
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

  Future<dynamic> getCardServices(int cardId) async {
    loaderController.loading(true);
    update();
    try {
      var res = await CardServices().fetchListAllServices(cardId);
      servicesList = res?.data;
      print('Fetched Dataaaaaaaaaa Length: ${allServicesList?.length}');
      print('Fetched Dataaaaaaaaa: $allServicesList');
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

  Future<dynamic> fetchMyCards() async {
    loaderController.loading(true);
    update();
    try {
      var res = await ProfileService().fetchCards();
      allMyCardList = res?.data;
      print('Fetched Dataaaaaaaaaa Length: ${allMyCardList?.length}');
      print('Fetched Dataaaaaaaaa: $allMyCardList');
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
  Future<dynamic> searchServices(String term) async {
    if (term.isEmpty) return;
    isLoading.value = true;
    searchTerm.value = term;
    try {
      var fetchedServices = await CardServices().searchServices(term);
      print("Fetched : $fetchedServices");
      searchServicesList = fetchedServices?.data;
      print("Fetched : $searchServicesList");
    } catch (e) {
      Get.snackbar("Error", "Failed to fetch services");
    } finally {
      isLoading.value = false;
    }
  }

}



