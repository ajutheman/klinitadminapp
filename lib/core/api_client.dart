import 'package:dio/dio.dart';

import 'shared_pref.dart';

class ApiClient {
  static Dio dio = Dio(BaseOptions(
      baseUrl: "https://testcleaning.swayamvarawedding.in/public/api"));
  // Dio(BaseOptions(baseUrl: "https://kleanit.planetprouae.com/api"));

  static Future<Response> postForm(String path, Map<String, dynamic> data) {
    return dio.post(path, data: FormData.fromMap(data));
  }

  static Future<Response> get(String path) async {
    final token = await SharedPref.getToken();
    dio.options.headers['Authorization'] = 'Bearer $token';
    return dio.get(path);
  }
}
