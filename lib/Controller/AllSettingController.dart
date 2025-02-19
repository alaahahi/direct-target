import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart' as dio;
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:direct_target/Controller/MessageHandlerController.dart';
import '../Model/AllSettingModel.dart';
import '../Service/SettingsServices.dart';
import 'LoaderController.dart';
import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart' as dio;
import 'package:direct_target/Model/CardModel.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:direct_target/Controller/MessageHandlerController.dart';
import '../Model/CardServicesModel.dart';
import '../Model/RequestCardModel.dart';
import '../Routes/Routes.dart';
import '../Service/CardServices.dart';
import 'LoaderController.dart';
import 'package:path/path.dart' as path;
import 'package:dio/dio.dart' as dio;
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../Api/AppConfig.dart';
import '../Controller/LoaderController.dart';
import '../Model/CardModel.dart';
import '../Model/RequestCardModel.dart';
import '../Model/CardServicesModel.dart';
import '../Controller/TokenController.dart';
import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../Model/AppointmentModel.dart';
import '../Routes/Routes.dart';
import '../Service/AppointmentService.dart';
import 'LoaderController.dart';
import 'MessageHandlerController.dart';
import 'ProfileCardController.dart';
import 'package:http/http.dart' as http;
import 'dart:developer';

import 'package:dio/dio.dart' as dio;

import 'TokenController.dart';





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
  var appVersion =''.obs;
  var contactEmail =''.obs;
  var contactPhone =''.obs;
  var socialLinks =''.obs;
  var appName =''.obs;
  var appSetting = ''.obs;
  GetStorage box = GetStorage();
  final SettingsServices _service;
  var isLoading = false.obs;
  var primaryColor = ''.obs;
  var firstWelcomeImage = ''.obs;
  var appSmsActivate = false.obs;
  var appWhatsappActivate = false.obs;

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
    _getAppVersion();
    getContactPhone();
    getContactEmail();
    getSocialLinks();
    getAppName();
    getAppSetting();
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


  Future<dynamic> getAppSetting() async {
    loaderController.loading(true);

    AllSettingModel? setting = await _service.fetchAppSettings();
    if (setting != null) {
      appSetting.value = setting.data?.value ?? '';

      try {

        Map<String, dynamic> settingData = jsonDecode(appSetting.value);

        bool smsActivate = settingData["sms_activate"] == 1;
        bool whatsappActivate = settingData["whatsapp_activate"] == 1;

        appSmsActivate.value = smsActivate;
        appWhatsappActivate.value = whatsappActivate;

        print("📌 SMS Activate: $appSmsActivate");
        print("📌 WhatsApp Activate: $appWhatsappActivate");
      } catch (e) {
        print("error in decode $e");
      }
    } else {
      appSetting.value = '';
    }

    loaderController.loading(false);
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
    AllSetting? setting = await _service.getContactEmail();
    if (setting != null) {
      secondImageUrl.value = setting.value ?? '';
    } else {
      secondImageUrl.value = '';
    }
  }
  Future<void> getContactPhone() async {
    AllSetting? setting = await _service.getContactPhone();
    if (setting != null) {
      secondImageUrl.value = setting.value ?? '';
    } else {
      secondImageUrl.value = '';
    }
  }



  Future<void> getSocialLinks() async {
      AllSetting? setting = await _service.getSocialLinks();
    if (setting != null) {
      secondImageUrl.value = setting.value ?? '';
    } else {
      secondImageUrl.value = '';
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
  Future<void> _getAppVersion() async {

    AllSetting? setting = await _service.getAppVersion();
    if (setting != null) {
      appVersion.value = setting.value ?? '';
    } else {
      appVersion.value = '';
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
    AllSetting? setting = await _service.getTermsConditionsUrl();
    if (setting != null) {
      termsCondition.value = setting.value ?? '';
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

    AllSetting? setting = await _service.getAppName();
    if (setting != null) {
      appName.value = setting.value ?? '';
    } else {
      appName.value = '';
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
        String contactPhone = res.data!.value ?? "alt First Welcome Image";
        log("Primary Color: $contactPhone");
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
