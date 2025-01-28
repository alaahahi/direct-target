// ignore_for_file: file_names, avoid_print, avoid_returning_null_for_void

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../Controller/LoaderController.dart';
import 'AppConfig.dart';

class Api {
  final dio = createDio;
  final formDataDio = createformDataDio;

  Api._internal();

  static final _singleton = Api._internal();

  factory Api() => _singleton;

  static Dio get createDio {
    var dio = Dio(BaseOptions(
      baseUrl: appConfig,
      receiveTimeout: const Duration(seconds: 60),
      connectTimeout: const Duration(seconds: 25),
      sendTimeout: const Duration(seconds: 25),
    ));

    dio.interceptors.addAll({
      AppInterceptors(dio),
    });
    return dio;
  }

  static Dio get createformDataDio {
    var formDataDio = Dio(BaseOptions(
      baseUrl: appConfig,
      receiveTimeout: const Duration(seconds: 25),
      connectTimeout: const Duration(seconds: 25),
      sendTimeout: const Duration(seconds: 25),
    ));

    return formDataDio;
  }
}

class AppInterceptors extends Interceptor {
  final Dio? dio;

  GetStorage box = GetStorage();
  LoaderController loaderController = Get.put(LoaderController());

  AppInterceptors(this.dio);

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final token = box.read('token');
    if (kDebugMode) {
      print('token is $token');
    }
    options.headers = {
      "Content-Type": "application/json",
      "accept": "text/plain",
      "Authorization": token
    };

    return handler.next(options);
  }

  @override
  void onResponse(
    response,
    ResponseInterceptorHandler handler,
  ) {
    print(
      'RESPONSE[${response.statusCode}] => Data: ${response.data}',
    );
    return super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    print(
      'ERROR[${err.response!.statusCode}] => PATH: ${err.response!.data}',
    );

    if (err.response!.statusCode == 401) {
      // msgController.showDialoglert_401();
    } else if (err.response!.statusCode == 403) {
      // msgController.showDialoglert_401();
    } else if (err.response!.statusCode == 500) {
      // msgController.showErrorMessage('Server error'.tr);
    }

    handler.next(err);

    return null;
  }
}
