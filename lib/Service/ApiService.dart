
import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:dio_cache_interceptor_hive_store/dio_cache_interceptor_hive_store.dart';


class MyDioService {
  final Dio dio;
  MyDioService(this.dio);
  void setupDio() {
    final cacheStore = HiveCacheStore('cacheBox');
    dio.interceptors.add(DioCacheInterceptor(
      options: CacheOptions(
        store: cacheStore,
        policy: CachePolicy.request,
        maxStale: Duration(hours: 1),
      ),
    ));
  }

  Future<Map<String, dynamic>> fetchData(String url) async {
    try {
      final response = await dio.get(url);

      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print('Error fetching data: $e');
      rethrow;
    }
  }
}

