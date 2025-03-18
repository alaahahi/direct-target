import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart' as dio;
import 'package:direct_target/Model/CardModel.dart';
import 'package:direct_target/Model/PopularServiceModel.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:direct_target/Controller/MessageHandlerController.dart';
import '../Model/AllCardServicesModel.dart';
import '../Model/ProfileCardModel.dart';
import '../Model/RequestCardModel.dart';
import '../Routes/Routes.dart';
import '../Service/CardServices.dart';
import '../Service/ProfileCardServices.dart';
import '../Service/SettingsServices.dart';
import 'AllSettingController.dart';
import 'LoaderController.dart';
import 'package:path/path.dart' as path;
import '../Model/ServiceModel.dart';
class CardController extends GetxController {
  LoaderController loaderController = Get.put(LoaderController());
  MessagesHandlerController msgController =
  Get.put(MessagesHandlerController());
  var firstImageUrl = ''.obs;
  String? selectedCategory;

  final AllSettingController _appController = Get.put(AllSettingController(SettingsServices()));
  GetStorage box = GetStorage();
  final CardServices _service;
  var isLoading = false.obs;
  List<CardData>? allCardList = [];
  List<AllCardServicesData>? categoryList = [];
  List<AllCardServicesData>? searchServicesList = [];
  List<PopularServiceData>? allServicesList = [];
  List<ProfileData>? allMyCardList = [];
  CardController(this._service);
  var searchTerm = "".obs;
  GetStorage storage = GetStorage();
  var services = <Service>[].obs;
  List<Services> selectedServices = [];



  @override
  void onInit() {
    super.onInit();

    loadData();
    fetchMyCards();
  }
  Future<void> loadData() async {
    try {
      await Future.wait([
        getCards(),
        getPopularService(),
        fetchMyCards(),
        getCardServices(_appController.appCardValue.value),
      ]);
    } catch (e) {
      print("Error loading data: $e");
    }
  }
  void updateSelectedCategory(String category) {
    selectedCategory = category;
    update();
  }
  Future<void> RequestCard(RequestCardData cardRequest) async {

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
        'phone_number': cardRequest.phone,
        'address': cardRequest.address,
        'card_number': cardRequest.cardNumber,
        'family_members_names': jsonEncode(cardRequest.familyMembersNames),
        'image': file,
        'is_admin': adminValue,
        'card_id':_appController.appCardValue.value
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


  void setSelectedCategory(String categoryName, List<Services> services) {
    selectedCategory = categoryName;
    selectedServices = services;
    update();
  }
  List<int> expandedCategories = [];
  List<int> expandedSubcategories = [];

  void toggleCategory(int categoryId) {
    if (expandedCategories.contains(categoryId)) {
      expandedCategories.remove(categoryId);
    } else {
      expandedCategories.add(categoryId);
    }
    update();
  }

  Future<dynamic> getCardServices(int cardId) async {
    loaderController.loading(true);
    update();
    try {
      var res = await CardServices().fetchListAllServices(cardId);
      categoryList = res?.data;
      print('Fetched Data Length: ${categoryList?.length}');
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
      print('Fetched MyCards Dataaaaaaaaaa Length: ${allMyCardList?.length}');
      print('Fetched MyCards Dataaaaaaaaa: $allMyCardList');
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

  void searchServices(String searchTerm) async {
    isLoading.value = true;
    try {
      var fetchedServices = await CardServices().fetchSearchServices(searchTerm);
      services.value = fetchedServices;
    } catch (e) {
      Get.snackbar("Error".tr, "Failed to fetch services".tr,
          duration: Duration(seconds: 5));
    } finally {
      isLoading.value = false;
    }
  }

}



