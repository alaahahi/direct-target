import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../Api/Api.dart';
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
      var res = await Api().dio.get('/settings');

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
      var res = await Api().dio.get('/settings/primary_color');

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

  Future<AllSetting?> getFirstWelcomeImage() async {
    try {
      final response = await dio.get('https://dowalyplus.aindubaico.com/api/v1/settings/first_welcome_image');

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
  Future<AllSetting?> getSecondWelcomeImage() async {
    try {
      final response = await dio.get('https://dowalyplus.aindubaico.com/api/v1/settings/second_welcome_image');

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
  Future<AllSetting?> getThirdWelcomeImage() async {
    loaderController.loading(true);
    try {
      final response = await dio.get('https://dowalyplus.aindubaico.com/api/v1/settings/third_welcome_image');

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



  Future<AllSettingModel> getThemeColor() async {
    loaderController.loading(true);

    try {
      var res = await Api().dio.get('/settings/theme_color');

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
      var res = await Api().dio.get('/settings/maintenance_mode');

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
  Future<AllSettingModel> getContactEmail() async {
    loaderController.loading(true);

    try {
      var res = await Api().dio.get('/settings/contact_email');

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
  Future<AllSettingModel> getContactPhone() async {
    loaderController.loading(true);

    try {
      var res = await Api().dio.get('/settings/contact_phone');

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
  Future<AllSettingModel> getSocialLinks() async {
    loaderController.loading(true);

    try {
      var res = await Api().dio.get('/settings/social_links');

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
  Future<AllSettingModel> getDefaultLanguage() async {
    loaderController.loading(true);

    try {
      var res = await Api().dio.get('/settings/default_language');

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
  Future<AllSettingModel> getAppVersion() async {
    loaderController.loading(true);

    try {
      var res = await Api().dio.get('/settings/app_version');

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
  Future<AllSettingModel> getMaxUploadSize() async {
    loaderController.loading(true);

    try {
      var res = await Api().dio.get('/settings/max_upload_size');

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
      var res = await Api().dio.get('/settings/notification_enabled');

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
  Future<AllSettingModel> getPrivacyPolicyUrl() async {
    loaderController.loading(true);

    try {
      var res = await Api().dio.get('/settings/privacy_policy_url');

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
  Future<AllSettingModel> getTermsConditionsUrl() async {
    loaderController.loading(true);

    try {
      var res = await Api().dio.get('/settings/terms_conditions_url');

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
  Future<AllSettingModel> getOtpExpiryTime() async {
    loaderController.loading(true);

    try {
      var res = await Api().dio.get('/settings/otp_expiry_time');

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
      var res = await Api().dio.get('/settings/secondary_contact_phone');

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
  Future<AllSettingModel> getAppName() async {
    loaderController.loading(true);

    try {
      var res = await Api().dio.get('/settings/app_name');

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
  Future<AllSettingModel> getEnableDarkMode() async {
    loaderController.loading(true);

    try {
      var res = await Api().dio.get('/settings/enable_dark_mode');

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
      var res = await Api().dio.get('/settings/welcome_message');

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
      var res = await Api().dio.get('/settings/max_login_attempts');

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
      var res = await Api().dio.get('/settings/First_contact_phone');

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
      var res = await Api().dio.get('/settings/api_url');

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
