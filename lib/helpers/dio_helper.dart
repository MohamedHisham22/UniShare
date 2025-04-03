import 'package:dio/dio.dart';
import 'package:unishare/constants.dart';

class DioHelper {
  static late Dio _dio;

  DioHelper._();

  static init() {
    _dio = Dio(
      BaseOptions(baseUrl: kUrl, receiveTimeout: const Duration(seconds: 60)),
    );
  }

  //-------------------Get-----------------------//

  static Future<Response> getData({
    required String path,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? body,
  }) async {
    final response = await _dio.get(
      path,
      queryParameters: queryParameters,
      data: body,
    );
    return response;
  }

  //-------------------post-----------------------//

  static Future<Response> postData({
    required String path,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? body,
  }) async {
    final response = await _dio.post(
      path,
      queryParameters: queryParameters,
      data: body,
    );
    return response;
  }

  //-------------------postForm-----------------------//

  static Future<Response> postFormData({
    required String path,
    required dynamic body,
  }) async {
    return await _dio.post(
      path,
      data: body,
      options: Options(headers: {"Content-Type": "multipart/form-data"}),
    );
  }

  //-------------------Delete-----------------------//

  static Future<Response> deleteData({
    required String path,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? body,
  }) async {
    final response = await _dio.delete(
      path,
      queryParameters: queryParameters,
      data: body,
    );
    return response;
  }

  //-------------------Patch-----------------------//

  static Future<Response> patchData({
    required String path,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? body,
  }) async {
    final response = await _dio.patch(
      path,
      queryParameters: queryParameters,
      data: body,
    );
    return response;
  }

  //-------------------Put-----------------------//

  static Future<Response> putData({
    required String path,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? body,
  }) async {
    final response = await _dio.put(
      path,
      queryParameters: queryParameters,
      data: body,
    );
    return response;
  }

  //-------------------PutForm-----------------------//

  static Future<Response> putFormData({
    required String path,
    required dynamic body,
  }) async {
    return await _dio.put(
      path,
      data: body,
      options: Options(headers: {"Content-Type": "multipart/form-data"}),
    );
  }
}
