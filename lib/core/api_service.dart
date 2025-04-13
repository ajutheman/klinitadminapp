// import 'package:dio/dio.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// class ApiService {
//   final Dio dio = Dio();
//
//   ApiService() {
//     dio.options.baseUrl = 'https://kleanit.planetprouae.com';
//     dio.interceptors.add(InterceptorsWrapper(
//       onRequest: (options, handler) async {
//         final prefs = await SharedPreferences.getInstance();
//         final token = prefs.getString('admin_token');
//         if (token != null) {
//           options.headers['Authorization'] = 'Bearer $token';
//         }
//         return handler.next(options);
//       },
//     ));
//   }
//
//   Future<Response> postFormData(String path, Map<String, dynamic> data) {
//     final formData = FormData.fromMap(data);
//     return dio.post(path, data: formData);
//   }
//
//   Future<Response> get(String path) => dio.get(path);
// }

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  final Dio dio = Dio();

  ApiService() {
    // dio.options.baseUrl = 'https://kleanit.planetprouae.com';
    dio.options.baseUrl = 'https://testcleaning.swayamvarawedding.in/public';
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final prefs = await SharedPreferences.getInstance();
          final token = prefs.getString('admin_token');
          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }

          print(
              "➡️ REQUEST: [${options.method}] ${options.baseUrl}${options.path}");
          print("Headers: ${options.headers}");
          if (options.data != null) {
            print("Body: ${options.data}");
          }

          return handler.next(options);
        },
        onResponse: (response, handler) {
          print(
              "✅ RESPONSE: [${response.statusCode}] ${response.requestOptions.uri}");
          print("Response Data: ${response.data}");
          return handler.next(response);
        },
        onError: (DioException e, handler) {
          print("❌ ERROR: [${e.response?.statusCode}] ${e.requestOptions.uri}");
          if (e.response != null) {
            print("Error Response: ${e.response?.data}");
          }
          print("Error Message: ${e.message}");
          return handler.next(e);
        },
      ),
    );
  }

  Future<Response> get(String path) => dio.get(path);

  Future<Response> post(String path, Map<String, dynamic> data) =>
      dio.post(path, data: data);

  Future<Response> postFormData(String path, Map<String, dynamic> data) {
    final formData = FormData.fromMap(data);
    return dio.post(path, data: formData);
  }

  Future<Map<String, dynamic>> getJson(String path) async {
    final res = await get(path);
    return res.data;
  }

  // Future<Map<String, dynamic>> postJson(
  //     String path, Map<String, dynamic> data) async {
  //   final res = await post(path, data);
  //   return res.data;
  // }

  Future<Map<String, dynamic>> postJson(
    String path,
    Map<String, dynamic> data, {
    Map<String, dynamic>? headers,
  }) async {
    final res = await dio.post(
      path,
      data: data,
      options: Options(
        headers: headers,
      ),
    );
    return res.data;
  }

  Future<Map<String, dynamic>> postFormDataJson(
      String path, Map<String, dynamic> data) async {
    final res = await postFormData(path, data);
    return res.data;
  }
}
