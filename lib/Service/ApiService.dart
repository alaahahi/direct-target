
import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor_hive_store/dio_cache_interceptor_hive_store.dart';
import 'package:hive/hive.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';

import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:dio_cache_interceptor_hive_store/dio_cache_interceptor_hive_store.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class MyDioService {
  final Dio dio;
  MyDioService(this.dio);

  late Box cacheBox;

  Future<void> setupDio() async {
    final appDocumentsDirectory = await getApplicationDocumentsDirectory();
    final cachePath = '${appDocumentsDirectory.path}/cacheBox';  // الحصول على مسار صالح

    // تأكد من فتح صندوق Hive في المسار الجديد
    cacheBox = await Hive.openBox('cacheBox', path: cachePath);

    // تحقق من فتح الكاش بنجاح
    print("تم فتح صندوق الكاش بنجاح في المسار: $cachePath");

    final cacheStore = HiveCacheStore(cachePath); // استخدام المسار المناسب مع HiveCacheStore

    dio.interceptors.add(DioCacheInterceptor(
      options: CacheOptions(
        store: cacheStore,
        policy: CachePolicy.refreshForceCache,
        maxStale: const Duration(days: 7),
        priority: CachePriority.high,
      ),
    ));
  }


  Future<Map<String, dynamic>> fetchData(String url) async {
    try {
      bool hasInternet = await checkInternetConnection();

      if (!hasInternet) {
        var cachedData = await cacheBox.get('cachedData');
        if (cachedData != null) {
          print("تم تحميل البيانات من الكاش: $cachedData");
          return cachedData;
        }
        print("لا توجد بيانات في الكاش.");
      }

      final response = await dio.get(url,
        options: Options(
          extra: {
            'cachePolicy': hasInternet ? CachePolicy.refreshForceCache : CachePolicy.forceCache,
          },
        ),
      );

      if (response.statusCode == 200) {
        print("تم تحميل البيانات من الشبكة: ${response.data}");
        await storeDataToCache(response.data);
        return response.data;
      } else {
        throw Exception('فشل في تحميل البيانات');
      }
    } catch (e) {
      print('خطأ أثناء جلب البيانات: $e');
      rethrow;
    }
  }

  Future<Response> fetchDataResponse(
      String url, {
        Map<String, dynamic>? data,
        Map<String, dynamic>? headers,
      }) async {
    try {
      bool hasInternet = await checkInternetConnection();
      final response = await dio.get(
        url,
        data: data,
        options: Options(
          headers: headers ?? {},
          extra: {
            'cachePolicy': hasInternet ? CachePolicy.refreshForceCache : CachePolicy.forceCache,
          },
        ),
      );

      return response;
    } catch (e) {
      print('Error fetching data: $e');
      rethrow;
    }
  }
  Future<void> checkCache() async {
    var cachedData = await cacheBox.get('cachedData');
    if (cachedData != null) {
      print("البيانات المخزنة في الكاش: $cachedData");
    } else {
      print("لا توجد بيانات مخزنة في الكاش.");
    }
  }

  Future<void> storeDataToCache(Map<String, dynamic> data) async {
    try {

      await cacheBox.put('cachedData', data);
      print("تم تخزين البيانات بنجاح!");

      var storedData = await cacheBox.get('cachedData');
      print("البيانات المخزنة في الكاش: $storedData");
    } catch (e) {
      print("خطأ أثناء تخزين البيانات: $e");
    }
  }

  Future<bool> checkInternetConnection() async {
    try {
      final response = await Dio().get('https://www.google.com');
      return response.statusCode == 200;
    } catch (_) {
      return false;
    }
  }
}

