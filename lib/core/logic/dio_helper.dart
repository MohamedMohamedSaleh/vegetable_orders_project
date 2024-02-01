import 'package:dio/dio.dart';

class DioHelper {
 final Dio _dio = Dio(BaseOptions(baseUrl: "https://thimar.amr.aait-d.com/api/"));

  Future<ResponseData> sendData({
    required String endPoint,
    Map<String, dynamic>? data,
  }) async {
    try {
   var response =   await _dio.post(
        endPoint,
        data: data
      );
      return ResponseData(message: response.data["message"], isSuccess: true, response: response);
    } on DioException catch (ex) {
      return ResponseData(
          message: ex.response!.data["message"], isSuccess: false , response: ex.response );
    }
  }


Future<ResponseData> getData({ 
    required String endPoint,
    Map<String, dynamic>? data,
  })async {
    try {
   var response =   await _dio.get(
        endPoint,
        queryParameters: data
      );
      return ResponseData(message: response.data["message"], isSuccess: true, response: response);
    } on DioException catch (ex) {
      return ResponseData(
          message: ex.response!.data["message"], isSuccess: false , response: ex.response );
    }
  }
}


class ResponseData {
  late final String message;
  late final bool isSuccess;
  late final Response? response;

  ResponseData({required this.message, required this.isSuccess, this.response});
}
