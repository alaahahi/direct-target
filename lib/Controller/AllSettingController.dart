import 'dart:convert';
import 'dart:developer';
import 'dart:ui';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:direct_target/Controller/MessageHandlerController.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:new_version_plus/new_version_plus.dart';
import '../Model/AllSettingModel.dart';
import '../Service/ApiService.dart';
import '../Service/SettingsServices.dart';
import 'LoaderController.dart';
import 'ThemeController.dart';
class FlutterColor extends Color {
  static int _getColorFromHex(String flutterColor) {
    flutterColor = flutterColor.toUpperCase().replaceAll("#", "");
    if (flutterColor.length == 6) {
      flutterColor = "FF" + flutterColor;
    }
    return int.parse(flutterColor, radix: 16);
  }
  FlutterColor(final String flutterColor) : super(_getColorFromHex(flutterColor));
}

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
  var termsConditionEnglish =''.obs;
  var privacyPolicy =''.obs;
  var privacyPolicyEnglish =''.obs;
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
  var appShowPopupUpdate = false.obs;
  var appCardValue = 0.obs;
  var appPrimaryColor = Rx<Color>(Colors.transparent);
  var primaryyColor = Rx<Color>(Colors.blue);
  var PrimaryHexColor = ''.obs;

  AllSettingController(this._service);


  final MyDioService dioService = MyDioService(dio.Dio());

  @override
  void onInit() {
    super.onInit();
    loadData();
  }

  Future<void> loadData() async {
    try {
      await dioService.setupDio();
      await Future.wait([
        _getFirstWelcomeImage(),
        _getSecondWelcomeImage(),
        _getThirdWelcomeImage(),
        _getFirstAdsImage(),
        _getSecondAdsImage(),
        _getThirdAdsImage(),
        _getFourthAdsImage(),
        _getTermsConditionsUrl(),
        _getPrivacyPolicyUrl(),
        _getAppVersion(),
        getContactPhone(),
        getContactEmail(),
        getAppName(),
        getAppSetting(),
        _getPrivacyPolicyEnUrl(),
        _getTermsConditionsEnUrl(),
        getFirstContactPhone()
      ]);
    } catch (e) {
      print("Error loading data: $e");
    }
  }

  Future<dynamic> getAllSettings() async {
    loaderController.loading(true);
    update();
    var response = await SettingsServices().getSettings();
    String? description = response.data!.description;
    try {
     print(response.status);
    } catch (e) {
      if (e is dio.DioException) {
        log(e.toString());
        msgController.showErrorMessage(response.status, description);
      } else {
        msgController.showErrorMessage(response.status, description);
      }
      update();
      loaderController.loading(false);
    }
  }
  void checkVersion(BuildContext context) async {
    print('🔍 Start checking version...');
    final newVersion = NewVersionPlus(androidId: 'com.direct_target');

    final status = await newVersion.getVersionStatus();
    print('✅ Version status: $status');

    if (status != null) {
      print('📱 Local: ${status.localVersion}, Store: ${status.storeVersion}, Can update: ${status.canUpdate}');
      if (status.canUpdate) {
        print('🆕 Showing dialog...');
        newVersion.showUpdateDialog(
          context: context,
          versionStatus: status,
          dialogTitle: 'New Update Available'.tr,
          dialogText: '${'Version'.tr} ${status.storeVersion} ${'is available on the store, and you are using version'.tr} ${status.localVersion}. ${'Would you like to update now?'.tr}',
          updateButtonText: 'Update'.tr,
          dismissButtonText: 'Later'.tr,
          allowDismissal: true,
        );
      } else {
        print('✅ Already up-to-date');
      }
    } else {
      print('❌ Failed to get version status');
    }
  }

  Future<void> getAppSetting() async {
    loaderController.loading(true);
    update();
    AllSettingModel? setting = await _service.fetchAppSettings();
    appSetting.value = setting.data?.value ?? '';
    try {
      Map<String, dynamic> settingData = jsonDecode(appSetting.value);
      bool smsActivate = settingData["sms_activate"] == 1;
      bool whatsappActivate = settingData["whatsapp_activate"] == 1;
      bool showPopupUpdate = settingData["show_popup_update"] == 1;
      int cardValue = settingData["card"] ?? 0;
      appSmsActivate.value = smsActivate;
      appWhatsappActivate.value = whatsappActivate;
      appShowPopupUpdate.value = showPopupUpdate;
      appCardValue.value = cardValue;
      String hexColor = settingData['primary_color'];
      var PrimaryColor =HexColor(hexColor);
      PrimaryHexColor.value = hexColor;
      primaryyColor.value = PrimaryColor;
      print('✅ appShowPopupUpdate Updated: ${appShowPopupUpdate}');
    } catch (e) {
      print("❌ Error in decode: $e");
    }
  
    update();
    loaderController.loading(false);
  }
  Future<dynamic> _getFirstWelcomeImage() async {
    AllSetting? setting = await _service.getFirstWelcomeImage();
    if (setting != null) {
      firstImageUrl.value = setting.value ?? '';
    } else {
      firstImageUrl.value = '';
    }
  }
  Future<dynamic> _getFirstAdsImage() async {

    AllSetting? setting = await _service.getFirstAdsImage();
    if (setting != null) {
      firstAdsImageUrl.value = setting.value ?? '';
    } else {
      firstAdsImageUrl.value = '';
    }
  }
  Future<dynamic> _getSecondAdsImage() async {
    AllSetting? setting = await _service.getSecondAdsImage();
    if (setting != null) {
      secondAdsImageUrl.value = setting.value ?? '';
    } else {
      secondAdsImageUrl.value = '';
    }
  }
  Future<dynamic> _getThirdAdsImage() async {
    AllSetting? setting = await _service.getThirdAdsImage();
    if (setting != null) {
      thirdAdsImageUrl.value = setting.value ?? '';
    } else {
      thirdAdsImageUrl.value = '';
    }
  }
  Future<dynamic> _getFourthAdsImage() async {
    AllSetting? setting = await _service.getFourthAdsImage();
    if (setting != null) {
      fourthAdsImageUrl.value = setting.value ?? '';
    } else {
      fourthAdsImageUrl.value = '';
    }
  }
  Future<dynamic> _getSecondWelcomeImage() async {
    AllSetting? setting = await _service.getSecondWelcomeImage();
    if (setting != null) {
      secondImageUrl.value = setting.value ?? '';
    } else {
      secondImageUrl.value = '';
    }
  }
  Future<dynamic> _getThirdWelcomeImage() async {
    isLoading(true);
    update();
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
      update();
      isLoading(false);
    }
  }
  Future<dynamic> fetchWelcomeImages() async {
    isLoading(true);
    update();
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
      update();
      isLoading(false);
    }
  }
  Future<dynamic> getThemeColor() async {
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
  Future<dynamic> getMaintenanceMode() async {
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
  Future<dynamic> getContactEmail() async {
    AllSetting? setting = await _service.getContactEmail();
    if (setting != null) {
      secondImageUrl.value = setting.value ?? '';
    } else {
      secondImageUrl.value = '';
    }
  }
  Future<dynamic> getContactPhone() async {
    AllSetting? setting = await _service.getContactPhone();
    if (setting != null) {
      secondImageUrl.value = setting.value ?? '';
    } else {
      secondImageUrl.value = '';
    }
  }

  Future<dynamic> getDefaultLanguage() async {
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
  Future<dynamic> _getAppVersion() async {

    AllSetting? setting = await _service.getAppVersion();
    if (setting != null) {
      appVersion.value = setting.value ?? '';
    } else {
      appVersion.value = '';
    }
  }
  Future<dynamic> getMaxUploadSize() async {
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
  Future<dynamic> getNotificationEnabled() async {
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
  Future<dynamic> _getPrivacyPolicyUrl() async {

    AllSetting? setting = await _service.getPrivacyPolicyUrl();
    if (setting != null) {
      privacyPolicy.value = setting.value ?? '';
    } else {
      privacyPolicy.value = '';
    }
  }
  Future<dynamic> _getPrivacyPolicyEnUrl() async {

    AllSetting? setting = await _service.getPrivacyPolicyEnUrl();
    if (setting != null) {
      privacyPolicyEnglish.value = setting.value ?? '';
    } else {
      privacyPolicyEnglish.value = '';
    }
  }
  Future<dynamic> _getTermsConditionsUrl() async {
    AllSetting? setting = await _service.getTermsConditionsUrl();
    if (setting != null) {
      termsCondition.value = setting.value ?? '';
    } else {
      termsCondition.value = '';
    }
  }
  Future<dynamic> _getTermsConditionsEnUrl() async {
    AllSetting? setting = await _service.getTermsConditionsEnUrl();
    if (setting != null) {
      termsConditionEnglish.value = setting.value ?? '';
    } else {
      termsConditionEnglish.value = '';
    }
  }
  Future<dynamic> getOtpExpiryTime() async {
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

  Future<dynamic> getAppName() async {

    AllSetting? setting = await _service.getAppName();
    if (setting != null) {
      appName.value = setting.value ?? '';
    } else {
      appName.value = '';
    }
  }

  Future<dynamic> getEnableDarkMode() async {
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

  Future<dynamic> getWelcomeMessage() async {
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
  Future<dynamic> getMaxLoginAttempts() async {
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
  Future<dynamic> getFirstContactPhone() async {

    AllSetting? setting = await _service.getContactPhone();
    if (setting != null) {
      contactPhone.value = setting.value ?? '';
      print("ggggggggggggggggggggggggg ${contactPhone}");
    } else {
      contactPhone.value = '';
    }
  }

  Future<dynamic> getApiUrl() async {
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
