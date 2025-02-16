import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:direct_target/Api/AppConfig.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../Controller/LoaderController.dart';
import '../Model/AllSettingModel.dart';


class SettingsServices {
  static SettingsServices? _instance;

  var dio = Dio();
  factory SettingsServices() => _instance ??= SettingsServices._();

  SettingsServices._();

  final LoaderController loaderController = Get.find<LoaderController>();

  GetStorage box = GetStorage();

  Future<AllSettingModel> getSettings() async {
    loaderController.loading(true);

    try {
      var res = await dio.get('$appConfig/settings');

      if (res.statusCode == 200) {
        return AllSettingModel.fromJson(jsonDecode(res.data));
      }
    } catch (e) {
      if (e is DioException) {
        print('Exception :${e.response}');
      } else {
        print('errorrrrrr');
      }
      loaderController.loading(false);
    }
    return AllSettingModel();
  }
  Future<AllSettingModel> getPrimaryColor() async {
    loaderController.loading(true);

    try {
      var res = await dio.get('$appConfig/settings/primary_color');

      if (res.statusCode == 200) {
        return AllSettingModel.fromJson(jsonDecode(res.data));
      }
    } catch (e) {
      if (e is DioException) {
        print('Exception :${e.response}');
      } else {
        print('errorrrrrr');
      }
      loaderController.loading(false);
    }
    return AllSettingModel();
  }
  Future<AllSetting?> getFirstAdsImage() async {
    try {
      final response = await dio.get('$appConfig/settings/first_ads_image');

      if (response.statusCode == 200) {
        // Parsing JSON and returning an AllSetting object
        return AllSetting.fromJson(response.data['data']);
      } else {
        return null;
      }
    } catch (e) {
      print('Error fetching data: $e');
      return null;
    }
  }
  Future<AllSetting?> getSecondAdsImage() async {
    try {
      final response = await dio.get('$appConfig/settings/second_ads_image');
      if (response.statusCode == 200) {
        return AllSetting.fromJson(response.data['data']);
      } else {
        return null;
      }
    } catch (e) {
      print('Error fetching data: $e');
      return null;
    }
  }
  Future<AllSetting?> getThirdAdsImage() async {
    try {
      final response = await dio.get('$appConfig/settings/third_ads_image');
      if (response.statusCode == 200) {
        return AllSetting.fromJson(response.data['data']);
      } else {
        return null;
      }
    } catch (e) {
      print('Error fetching data: $e');
      return null;
    }
  }
  Future<AllSetting?> getFourthAdsImage() async {
    try {
      final response = await dio.get('$appConfig/settings/fourth_ads_image');
      if (response.statusCode == 200) {
        return AllSetting.fromJson(response.data['data']);
      } else {
        return null;
      }
    } catch (e) {
      print('Error fetching data: $e');
      return null;
    }
  }
  Future<AllSetting?> getFirstWelcomeImage() async {
    try {
      final response = await dio.get('$appConfig/settings/first_welcome_image');
      if (response.statusCode == 200) {
        return AllSetting.fromJson(response.data['data']);
      } else {
        return null;
      }
    } catch (e) {
      print('Error fetching data: $e');
      return null;
    }
  }
  Future<AllSetting?> getSecondWelcomeImage() async {
    try {
      final response = await dio.get('$appConfig/settings/second_welcome_image');
      if (response.statusCode == 200) {
        return AllSetting.fromJson(response.data['data']);
      } else {
        return null;
      }
    } catch (e) {
      print('Error fetching data: $e');
      return null;
    }
  }
  Future<AllSetting?> getThirdWelcomeImage() async {
    loaderController.loading(true);
    try {
      final response = await dio.get('$appConfig/settings/third_welcome_image');
      if (response.statusCode == 200) {
        return AllSetting.fromJson(response.data['data']);
      } else {
        return null;
      }
    } catch (e) {
      print('Error fetching data: $e');
      return null;
    }

  }



  Future<AllSettingModel> getThemeColor() async {
    loaderController.loading(true);

    try {
      var res = await dio.get('$appConfig/settings/theme_color');

      if (res.statusCode == 200) {
        return AllSettingModel.fromJson(jsonDecode(res.data));
      }
    } catch (e) {
      if (e is DioException) {
        print('Exception :${e.response}');
      } else {
        print('errorrrrrr');
      }
      loaderController.loading(false);
    }
    return AllSettingModel();
  }
  Future<AllSettingModel> getMaintenanceMode() async {
    loaderController.loading(true);

    try {
      var res = await dio.get('$appConfig/settings/maintenance_mode');

      if (res.statusCode == 200) {
        return AllSettingModel.fromJson(jsonDecode(res.data));
      }
    } catch (e) {
      if (e is DioException) {
        print('Exception :${e.response}');
      } else {
        print('errorrrrrr');
      }
      loaderController.loading(false);
    }
    return AllSettingModel();
  }
  Future<AllSetting?> getContactEmail() async {
    try {
      final response = await dio.get('$appConfig/settings/contact_email');
      if (response.statusCode == 200) {
        return AllSetting.fromJson(response.data['data']);
      } else {
        return null;
      }
    } catch (e) {
      print('Error fetching data: $e');
      return null;
    }

  }
  Future<AllSetting?> getContactPhone() async {
    try {
      final response = await dio.get('$appConfig/settings/contact_phone');
      if (response.statusCode == 200) {
        return AllSetting.fromJson(response.data['data']);
      } else {
        return null;
      }
    } catch (e) {
      print('Error fetching data: $e');
      return null;
    }


  }
  Future<AllSetting?> getSocialLinks() async {
    try {
      final response = await dio.get('$appConfig/settings/social_links');
      if (response.statusCode == 200) {
        return AllSetting.fromJson(response.data['data']);
      } else {
        return null;
      }
    } catch (e) {
      print('Error fetching data: $e');
      return null;
    }
  }
  Future<AllSettingModel> getDefaultLanguage() async {
    loaderController.loading(true);

    try {
      var res = await dio.get('$appConfig/settings/default_language');

      if (res.statusCode == 200) {
        return AllSettingModel.fromJson(jsonDecode(res.data));
      }
    } catch (e) {
      if (e is DioException) {
        print('Exception :${e.response}');
      } else {
        print('errorrrrrr');
      }
      loaderController.loading(false);
    }
    return AllSettingModel();
  }

  Future<AllSetting?> getAppVersion() async {
    loaderController.loading(true);
    try {
      final response = await dio.get('$appConfig/settings/app_version');
      if (response.statusCode == 200) {
        return AllSetting.fromJson(response.data['data']);
      } else {
        return null;
      }
    } catch (e) {
      print('Error fetching data: $e');
      return null;
    }

  }

  Future<AllSettingModel> getMaxUploadSize() async {
    loaderController.loading(true);

    try {
      var res = await dio.get('$appConfig/settings/max_upload_size');

      if (res.statusCode == 200) {
        return AllSettingModel.fromJson(jsonDecode(res.data));
      }
    } catch (e) {
      if (e is DioException) {
        print('Exception :${e.response}');
      } else {
        print('errorrrrrr');
      }
      loaderController.loading(false);
    }
    return AllSettingModel();
  }
  Future<AllSettingModel> getNotificationEnabled() async {
    loaderController.loading(true);

    try {
      var res = await dio.get('$appConfig/settings/notification_enabled');

      if (res.statusCode == 200) {
        return AllSettingModel.fromJson(jsonDecode(res.data));
      }
    } catch (e) {
      if (e is DioException) {
        print('Exception :${e.response}');
      } else {
        print('errorrrrrr');
      }
      loaderController.loading(false);
    }
    return AllSettingModel();
  }
  Future<AllSetting?> getPrivacyPolicyUrl() async {
    loaderController.loading(true);
    try {
      final response = await dio.get('$appConfig/settings/privacy_policy_url');

      if (response.statusCode == 200) {
        // Parsing JSON and returning an AllSetting object
        return AllSetting.fromJson(response.data['data']);
      } else {
        return null;
      }
    } catch (e) {
      print('Error fetching data: $e');
      return null;
    }
  }
  Future<AllSetting?> getTermsConditionsUrl() async {
    loaderController.loading(true);
    try {
      final response = await dio.get('$appConfig/settings/terms_conditions_url');

      if (response.statusCode == 200) {
        // Parsing JSON and returning an AllSetting object
        return AllSetting.fromJson(response.data['data']);
      } else {
        return null;
      }
    } catch (e) {
      print('Error fetching data: $e');
      return null;
    }
  }
  Future<AllSettingModel> getOtpExpiryTime() async {
    loaderController.loading(true);

    try {
      var res = await dio.get('$appConfig/settings/otp_expiry_time');

      if (res.statusCode == 200) {
        return AllSettingModel.fromJson(jsonDecode(res.data));
      }
    } catch (e) {
      if (e is DioException) {
        print('Exception :${e.response}');
      } else {
        print('errorrrrrr');
      }
      loaderController.loading(false);
    }
    return AllSettingModel();
  }
  Future<AllSettingModel> getSecondaryContactPhone() async {
    loaderController.loading(true);

    try {
      var res = await dio.get('$appConfig/settings/secondary_contact_phone');

      if (res.statusCode == 200) {
        return AllSettingModel.fromJson(jsonDecode(res.data));
      }
    } catch (e) {
      if (e is DioException) {
        print('Exception :${e.response}');
      } else {
        print('errorrrrrr');
      }
      loaderController.loading(false);
    }
    return AllSettingModel();
  }
  Future<AllSetting?> getAppName() async {
    loaderController.loading(true);
    try {
      final response = await dio.get('$appConfig/settings/app_name');
      if (response.statusCode == 200) {
        return AllSetting.fromJson(response.data['data']);
      } else {
        return null;
      }
    } catch (e) {
      print('Error fetching data: $e');
      return null;
    }

  }
  Future<AllSettingModel> getEnableDarkMode() async {
    loaderController.loading(true);

    try {
      var res = await dio.get('$appConfig/settings/enable_dark_mode');

      if (res.statusCode == 200) {
        return AllSettingModel.fromJson(jsonDecode(res.data));
      }
    } catch (e) {
      if (e is DioException) {
        print('Exception :${e.response}');
      } else {
        print('errorrrrrr');
      }
      loaderController.loading(false);
    }
    return AllSettingModel();
  }
  Future<AllSettingModel> getWelcomeMessage() async {
    loaderController.loading(true);

    try {
      var res = await dio.get('$appConfig/settings/welcome_message');

      if (res.statusCode == 200) {
        return AllSettingModel.fromJson(jsonDecode(res.data));
      }
    } catch (e) {
      if (e is DioException) {
        print('Exception :${e.response}');
      } else {
        print('errorrrrrr');
      }
      loaderController.loading(false);
    }
    return AllSettingModel();
  }
  Future<AllSettingModel> getMaxLoginAttempts() async {
    loaderController.loading(true);

    try {
      var res = await dio.get('$appConfig/settings/max_login_attempts');

      if (res.statusCode == 200) {
        return AllSettingModel.fromJson(jsonDecode(res.data));
      }
    } catch (e) {
      if (e is DioException) {
        print('Exception :${e.response}');
      } else {
        print('errorrrrrr');
      }
      loaderController.loading(false);
    }
    return AllSettingModel();
  }

  Future<AllSettingModel> getFirstContactPhone() async {
    loaderController.loading(true);

    try {
      var res = await dio.get('$appConfig/settings/First_contact_phone');

      if (res.statusCode == 200) {
        return AllSettingModel.fromJson(jsonDecode(res.data));
      }
    } catch (e) {
      if (e is DioException) {
        print('Exception :${e.response}');
      } else {
        print('errorrrrrr');
      }
      loaderController.loading(false);
    }
    return AllSettingModel();
  }
  Future<AllSettingModel> getApiUrl() async {
    loaderController.loading(true);

    try {
      var res = await dio.get('$appConfig/settings/api_url');

      if (res.statusCode == 200) {
        return AllSettingModel.fromJson(jsonDecode(res.data));
      }
    } catch (e) {
      if (e is DioException) {
        print('Exception :${e.response}');
      } else {
        print('errorrrrrr');
      }
      loaderController.loading(false);
    }
    return AllSettingModel();
  }



}
