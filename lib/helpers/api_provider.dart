import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:ecomtest2/helpers/api_basehelper.dart';
import 'package:ecomtest2/views/cart/cart_product.dart';
import 'package:ecomtest2/views/customers/add_customer_response.dart';
import 'package:ecomtest2/views/customers/customers_response.dart';
import 'package:ecomtest2/views/product/product_model.dart';
import 'package:fpdart/fpdart.dart';

class ApiProvider {
  final ApiBaseHelper _api = ApiBaseHelper();
  Future<Either<ProductsResponse, Failure>> getProducts(
      {String? search}) async {
    try {
      final response = await _api.getApi(
        '${ApiConstants.products}?search_query=${search ?? ""}',
      );
      print(response);
      if (response.data['data'] != null) {
        return Either.left(ProductsResponse.fromJson(response.data));
      } else {
        return Either.right(Failure.fromJson(response.data));
      }
    } catch (e) {
      print(e.toString());
      return Either.right(
        Failure(
          code: '404',
          text: e.toString(),
        ),
      );
    }
  }

  Future<Either<Success, Failure>> checkOut({
    String? customerId,
    List<CartProduct>? cartProducts,
  }) async {
    var products = <Map>[];
    var sum = 0.0;
    for (var element in cartProducts!) {
      sum = sum + (element.count! * element.price!);
      products.add(
        element.toJson(),
      );
    }
    try {
      var formData = FormData.fromMap(
        {
          "customer_id": customerId,
          "total_price": sum.toString(),
          "products": jsonEncode(products),
        },
        ListFormat.multiCompatible,
      );
      final response = await _api.postApi(
        ApiConstants.orders + '/',
        formData,
      );
      print(response);
      if (response.data['data'] != null) {
        return Either.left(Success.fromJson(response.data));
      } else {
        return Either.right(Failure.fromJson(response.data));
      }
    } catch (e) {
      print(e.toString());
      return Either.right(
        Failure(
          code: '404',
          text: e.toString(),
        ),
      );
    }
  }

  Future<Either<CustomersResponse, Failure>> getCustomers() async {
    try {
      final response = await _api.getApi(
        ApiConstants.customers,
      );
      print(response);
      if (response.data['data'] != null) {
        return Either.left(CustomersResponse.fromJson(response.data));
      } else {
        return Either.right(Failure.fromJson(response.data));
      }
    } catch (e) {
      print(e.toString());
      return Either.right(
        Failure(
          code: '404',
          text: e.toString(),
        ),
      );
    }
  }

  Future<Either<AddCustomerResponse, Failure>> addCustomer({
    required String name,
    String? photo,
    required String mobile,
    required String mail,
    required String street1,
    required String street2,
    required String city,
    required String pincode,
    required String country,
    required String state,
  }) async {
    try {
      var formData = FormData.fromMap({
        "name": name,
        "profile_pic": photo ?? '',
        "mobile_number": mobile,
        "email": mail,
        "street": street1,
        "street_two": street2,
        "city": city,
        "pincode": pincode,
        "country": country,
        "state": state,
      });
      final response = await _api.postApi(
        ApiConstants.customers + '/',
        formData,
      );
      print(response);
      if (response.data['data'] != null) {
        return Either.left(AddCustomerResponse.fromJson(response.data));
      } else {
        return Either.right(Failure.fromJson(response.data));
      }
    } catch (e) {
      print(e.toString());
      return Either.right(
        Failure(
          code: '404',
          text: e.toString(),
        ),
      );
    }
  }
}

class Failure {
  String? code;
  String? text;
  Failure({this.code, this.text});
  Failure.fromJson(Map<String, dynamic> json) {
    code = json['success'] == 0 ? '200' : json['success'].toString();
    text = json['message'];
  }
}

class Success {
  int? success;
  String? message;

  Success({
    this.success,
    this.message,
  });
  Success.fromJson(Map<String, dynamic> json) {
    success = json['error_code'];
    message = json['message'];
  }
}
