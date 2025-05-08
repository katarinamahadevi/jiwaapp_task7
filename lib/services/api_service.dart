// import 'package:dio/dio.dart';
// import 'package:jiwaapp_task7/constant/api_constant.dart';
// import 'package:jiwaapp_task7/services/storage_service.dart';

// class ApiService {
//   final Dio _dio = Dio();

//   ApiService() {
//     _dio.options.baseUrl = ApiConstants.baseUrl;
//     _dio.options.connectTimeout = Duration(seconds: 30);
//     _dio.options.receiveTimeout = Duration(seconds: 30);
    
//     // Add interceptor for auth token
//     _dio.interceptors.add(InterceptorsWrapper(
//       onRequest: (options, handler) {
//         final token = StorageService.getToken();
//         if (token != null) {
//           options.headers['Authorization'] = 'Bearer $token';
//         }
//         options.headers['Content-Type'] = 'application/json';
//         return handler.next(options);
//       },
//       onError: (DioException e, handler) {
//         if (e.response?.statusCode == 401) {
//           // Handle unauthorized error - could redirect to login
//           StorageService.removeToken();
//           StorageService.removeUser();
//         }
//         return handler.next(e);
//       }
//     ));
//   }

//   Future<Response> get(String path, {Map<String, dynamic>? queryParameters}) async {
//     try {
//       return await _dio.get(path, queryParameters: queryParameters);
//     } catch (e) {
//       rethrow;
//     }
//   }

//   Future<Response> post(String path, {dynamic data, Map<String, dynamic>? queryParameters}) async {
//     try {
//       return await _dio.post(path, data: data, queryParameters: queryParameters);
//     } catch (e) {
//       rethrow;
//     }
//   }

//   // Additional methods for other HTTP verbs can be added as needed
// }