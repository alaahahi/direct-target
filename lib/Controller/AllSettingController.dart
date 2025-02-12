import 'dart:developer';
import 'package:dio/dio.dart' as dio;
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:direct_target/Controller/MessageHandlerController.dart';
import '../Model/AllSettingModel.dart';
import '../Service/SettingsServices.dart';
import 'LoaderController.dart';

class AllSettingController extends GetxController {
  LoaderController loaderController = Get.put(LoaderController());
  MessagesHandlerController msgController =
  Get.put(MessagesHandlerController());
  var firstImageUrl = ''.obs;
  var secondImageUrl = ''.obs;
  var thirdImageUrl = ''.obs;
  var firstAdsImageUrl = ''.obs;
  var secondAdsImageUrl = ''.obs;
  var thirdAdsImageUrl = ''.obs;
  var fourthAdsImageUrl = ''.obs;
  var termsCondition =''.obs;
  var privacyPolicy =''.obs;

  GetStorage box = GetStorage();
  final SettingsServices _service;
  var isLoading = false.obs;
  var primaryColor = ''.obs;
  var firstWelcomeImage = ''.obs;
  AllSettingController(this._service);
  @override
  void onInit() {
    super.onInit();
    _getFirstWelcomeImage();
    _getSecondWelcomeImage();
    _getThirdWelcomeImage();
    _getFirstAdsImage();
    _getSecondAdsImage();
    _getThirdAdsImage();
    _getFourthAdsImage();
    _getTermsConditionsUrl();
    _getPrivacyPolicyUrl();
  }

  Future<dynamic> getAllSettings() async {
    loaderController.loading(true);

    var response = await SettingsServices().getSettings();
    String? description = response.data!.description;
    try {
      msgController.showSuccessMessage(response.status, description);
    } catch (e) {
      if (e is dio.DioException) {
        log(e.toString());
        msgController.showErrorMessage(response.status, description);
      } else {
        msgController.showErrorMessage(response.status, description);
      }
      loaderController.loading(false);
    }
  }
  Future<void> getPrimaryColor() async {
    isLoading(true);
    try {
      AllSettingModel? res = await SettingsServices().getPrimaryColor();
      if (res.status == "success" && res.data != null) {
        String primaryColor = res.data!.value ?? "#FFFFFF";
        log("Primary Color: $primaryColor");
      } else {
        log("Failed to retrieve primary color");
      }
    } catch (e) {
      print("Error fetching primary color: $e");
    } finally {
      isLoading(false);
    }
  }
  Future<void> _getFirstWelcomeImage() async {
    AllSetting? setting = await _service.getFirstWelcomeImage();
    if (setting != null) {
      firstImageUrl.value = setting.value ?? '';
    } else {
      firstImageUrl.value = '';
    }
  }
  Future<void> _getFirstAdsImage() async {

    AllSetting? setting = await _service.getFirstAdsImage();
    if (setting != null) {
      firstAdsImageUrl.value = setting.value ?? '';
    } else {
      firstAdsImageUrl.value = '';
    }
  }
  Future<void> _getSecondAdsImage() async {
    AllSetting? setting = await _service.getSecondAdsImage();
    if (setting != null) {
      secondAdsImageUrl.value = setting.value ?? '';
    } else {
      secondAdsImageUrl.value = '';
    }
  }
  Future<void> _getThirdAdsImage() async {
    AllSetting? setting = await _service.getThirdAdsImage();
    if (setting != null) {
      thirdAdsImageUrl.value = setting.value ?? '';
    } else {
      thirdAdsImageUrl.value = '';
    }
  }
  Future<void> _getFourthAdsImage() async {
    AllSetting? setting = await _service.getFourthAdsImage();
    if (setting != null) {
      fourthAdsImageUrl.value = setting.value ?? '';
    } else {
      fourthAdsImageUrl.value = '';
    }
  }
  Future<void> _getSecondWelcomeImage() async {
    AllSetting? setting = await _service.getSecondWelcomeImage();
    if (setting != null) {
      secondImageUrl.value = setting.value ?? '';
    } else {
      secondImageUrl.value = '';
    }
  }
  Future<void> _getThirdWelcomeImage() async {
    isLoading(true);
    try {
      AllSetting? setting = await _service.getThirdWelcomeImage();
      if (setting != null) {
        thirdImageUrl.value = setting.value ?? '';
      } else {
        thirdImageUrl.value = '';
      }
    } catch (e) {
      print("Error fetching primary color: $e");
    } finally {
      isLoading(false);
    }
  }
  Future<void> fetchWelcomeImages() async {
    isLoading(true);
    try {
      await Future.wait([
        _getFirstWelcomeImage(),
        _getSecondWelcomeImage(),
        _getThirdWelcomeImage(),
        _getFirstAdsImage(),
    _getSecondAdsImage(),
    _getThirdAdsImage(),
    _getFourthAdsImage(),
      ]);
    } catch (e) {
      print("Error fetching welcome images: $e");
    } finally {
      isLoading(false);
    }
  }

  Future<void> getThemeColor() async {
    isLoading(true);
    try {
      AllSettingModel? res = await SettingsServices().getThemeColor();
      if (res.status == "success" && res.data != null) {
        String firstWelcomeImage = res.data!.value ?? "alt First Welcome Image";
        log("Primary Color: $firstWelcomeImage");
      } else {
        log("Failed to retrieve primary color");
      }
    } catch (e) {
      print("Error fetching primary color: $e");
    } finally {
      isLoading(false);
    }
  }

  Future<void> getMaintenanceMode() async {
    isLoading(true);
    try {
      AllSettingModel? res = await SettingsServices().getMaintenanceMode();
      if (res.status == "success" && res.data != null) {
        String firstWelcomeImage = res.data!.value ?? "alt First Welcome Image";
        log("Primary Color: $firstWelcomeImage");
      } else {
        log("Failed to retrieve primary color");
      }
    } catch (e) {
      print("Error fetching primary color: $e");
    } finally {
      isLoading(false);
    }
  }
  Future<void> getContactEmail() async {
    isLoading(true);
    try {
      AllSettingModel? res = await SettingsServices().getContactEmail();
      if (res.status == "success" && res.data != null) {
        String firstWelcomeImage = res.data!.value ?? "alt First Welcome Image";
        log("Primary Color: $firstWelcomeImage");
      } else {
        log("Failed to retrieve primary color");
      }
    } catch (e) {
      print("Error fetching primary color: $e");
    } finally {
      isLoading(false);
    }
  }

  Future<void> getContactPhone() async {
    isLoading(true);
    try {
      AllSettingModel? res = await SettingsServices().getContactPhone();
      if (res.status == "success" && res.data != null) {
        String firstWelcomeImage = res.data!.value ?? "alt First Welcome Image";
        log("Primary Color: $firstWelcomeImage");
      } else {
        log("Failed to retrieve primary color");
      }
    } catch (e) {
      print("Error fetching primary color: $e");
    } finally {
      isLoading(false);
    }
  }

  Future<void> getSocialLinks() async {
    isLoading(true);
    try {
      AllSettingModel? res = await SettingsServices().getSocialLinks();
      if (res.status == "success" && res.data != null) {
        String firstWelcomeImage = res.data!.value ?? "alt First Welcome Image";
        log("Primary Color: $firstWelcomeImage");
      } else {
        log("Failed to retrieve primary color");
      }
    } catch (e) {
      print("Error fetching primary color: $e");
    } finally {
      isLoading(false);
    }
  }

  Future<void> getDefaultLanguage() async {
    isLoading(true);
    try {
      AllSettingModel? res = await SettingsServices().getDefaultLanguage();
      if (res.status == "success" && res.data != null) {
        String firstWelcomeImage = res.data!.value ?? "alt First Welcome Image";
        log("Primary Color: $firstWelcomeImage");
      } else {
        log("Failed to retrieve primary color");
      }
    } catch (e) {
      print("Error fetching primary color: $e");
    } finally {
      isLoading(false);
    }
  }


  Future<void> getAppVersion() async {
    isLoading(true);
    try {
      AllSettingModel? res = await SettingsServices().getAppVersion();
      if (res.status == "success" && res.data != null) {
        String firstWelcomeImage = res.data!.value ?? "alt First Welcome Image";
        log("Primary Color: $firstWelcomeImage");
      } else {
        log("Failed to retrieve primary color");
      }
    } catch (e) {
      print("Error fetching primary color: $e");
    } finally {
      isLoading(false);
    }
  }



  Future<void> getMaxUploadSize() async {
    isLoading(true);
    try {
      AllSettingModel? res = await SettingsServices().getMaxUploadSize();
      if (res.status == "success" && res.data != null) {
        String firstWelcomeImage = res.data!.value ?? "alt First Welcome Image";
        log("Primary Color: $firstWelcomeImage");
      } else {
        log("Failed to retrieve primary color");
      }
    } catch (e) {
      print("Error fetching primary color: $e");
    } finally {
      isLoading(false);
    }
  }


  Future<void> getNotificationEnabled() async {
    isLoading(true);
    try {
      AllSettingModel? res = await SettingsServices().getNotificationEnabled();
      if (res.status == "success" && res.data != null) {
        String firstWelcomeImage = res.data!.value ?? "alt First Welcome Image";
        log("Primary Color: $firstWelcomeImage");
      } else {
        log("Failed to retrieve primary color");
      }
    } catch (e) {
      print("Error fetching primary color: $e");
    } finally {
      isLoading(false);
    }
  }

  Future<void> _getPrivacyPolicyUrl() async {

    AllSetting? setting = await _service.getPrivacyPolicyUrl();
    if (setting != null) {
      privacyPolicy.value = setting.value ?? '';
    } else {
      privacyPolicy.value = '';
    }
  }

  Future<void> _getTermsConditionsUrl() async {
print("ddddddddddddddddddddddddddd");
    AllSetting? setting = await _service.getTermsConditionsUrl();
    if (setting != null) {
      termsCondition.value = setting.value ?? '';
      print(termsCondition);
    } else {
      termsCondition.value = '';
    }
  }

  Future<void> getOtpExpiryTime() async {
    isLoading(true);
    try {
      AllSettingModel? res = await SettingsServices().getOtpExpiryTime();
      if (res.status == "success" && res.data != null) {
        String firstWelcomeImage = res.data!.value ?? "alt First Welcome Image";
        log("Primary Color: $firstWelcomeImage");
      } else {
        log("Failed to retrieve primary color");
      }
    } catch (e) {
      print("Error fetching primary color: $e");
    } finally {
      isLoading(false);
    }
  }

  Future<void> getSecondaryContactPhone() async {
    isLoading(true);
    try {
      AllSettingModel? res = await SettingsServices().getSecondaryContactPhone();
      if (res.status == "success" && res.data != null) {
        String firstWelcomeImage = res.data!.value ?? "alt First Welcome Image";
        log("Primary Color: $firstWelcomeImage");
      } else {
        log("Failed to retrieve primary color");
      }
    } catch (e) {
      print("Error fetching primary color: $e");
    } finally {
      isLoading(false);
    }
  }

  Future<void> getAppName() async {
    isLoading(true);
    try {
      AllSettingModel? res = await SettingsServices().getAppName();
      if (res.status == "success" && res.data != null) {
        String firstWelcomeImage = res.data!.value ?? "alt First Welcome Image";
        log("Primary Color: $firstWelcomeImage");
      } else {
        log("Failed to retrieve primary color");
      }
    } catch (e) {
      print("Error fetching primary color: $e");
    } finally {
      isLoading(false);
    }
  }

  Future<void> getEnableDarkMode() async {
    isLoading(true);
    try {
      AllSettingModel? res = await SettingsServices().getEnableDarkMode();
      if (res.status == "success" && res.data != null) {
        String firstWelcomeImage = res.data!.value ?? "alt First Welcome Image";
        log("Primary Color: $firstWelcomeImage");
      } else {
        log("Failed to retrieve primary color");
      }
    } catch (e) {
      print("Error fetching primary color: $e");
    } finally {
      isLoading(false);
    }
  }

  Future<void> getWelcomeMessage() async {
    isLoading(true);
    try {
      AllSettingModel? res = await SettingsServices().getWelcomeMessage();
      if (res.status == "success" && res.data != null) {
        String firstWelcomeImage = res.data!.value ?? "alt First Welcome Image";
        log("Primary Color: $firstWelcomeImage");
      } else {
        log("Failed to retrieve primary color");
      }
    } catch (e) {
      print("Error fetching primary color: $e");
    } finally {
      isLoading(false);
    }
  }
  Future<void> getMaxLoginAttempts() async {
    isLoading(true);
    try {
      AllSettingModel? res = await SettingsServices().getMaxLoginAttempts();
      if (res.status == "success" && res.data != null) {
        String firstWelcomeImage = res.data!.value ?? "alt First Welcome Image";
        log("Primary Color: $firstWelcomeImage");
      } else {
        log("Failed to retrieve primary color");
      }
    } catch (e) {
      print("Error fetching primary color: $e");
    } finally {
      isLoading(false);
    }
  }

  Future<void> getFirstContactPhone() async {
    isLoading(true);
    try {
      AllSettingModel? res = await SettingsServices().getFirstContactPhone();
      if (res.status == "success" && res.data != null) {
        String firstWelcomeImage = res.data!.value ?? "alt First Welcome Image";
        log("Primary Color: $firstWelcomeImage");
      } else {
        log("Failed to retrieve primary color");
      }
    } catch (e) {
      print("Error fetching primary color: $e");
    } finally {
      isLoading(false);
    }
  }
  Future<void> getApiUrl() async {
    isLoading(true);
    try {
      AllSettingModel? res = await SettingsServices().getApiUrl();
      if (res.status == "success" && res.data != null) {
        String firstWelcomeImage = res.data!.value ?? "alt First Welcome Image";
        log("Primary Color: $firstWelcomeImage");
      } else {
        log("Failed to retrieve primary color");
      }
    } catch (e) {
      print("Error fetching primary color: $e");
    } finally {
      isLoading(false);
    }
  }




}
