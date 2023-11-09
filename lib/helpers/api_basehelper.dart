import 'package:dio/dio.dart';

class ApiConstants {
  static const products = 'products';

  static const customers = 'customers';
  static const orders = 'orders';
}

class ApiBaseHelper {
  static const baseUrl = 'http://62.72.44.247';
  static const apiUrl = 'http://62.72.44.247/api/';
  Dio dio = Dio(BaseOptions(baseUrl: apiUrl, headers: {
    'Accept': 'application/json',
    'Content-Type': 'multipart/form-data',
  }));

  Future<Response> getApi(String path) async {
    print(apiUrl + path);
    final response = await dio.get(apiUrl + path);
    return response;
  }

  Future<Response> postApi(String path, FormData body) async {
    print(apiUrl + path);
    print(body.fields);

    final response = await dio.post(
      apiUrl + path,
      data: body,
    );
    return response;
  }
}
