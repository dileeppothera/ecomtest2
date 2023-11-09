import 'dart:convert';

import 'package:ecomtest2/views/customers/customer_model.dart';

class CustomersResponse {
  int? errorCode;
  List<Customer>? data;
  String? message;

  CustomersResponse({
    this.errorCode,
    this.data,
    this.message,
  });

  factory CustomersResponse.fromRawJson(String str) =>
      CustomersResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CustomersResponse.fromJson(Map<String, dynamic> json) =>
      CustomersResponse(
        errorCode: json["error_code"],
        data: json["data"] == null
            ? []
            : List<Customer>.from(
                json["data"]!.map((x) => Customer.fromJson(x))),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "error_code": errorCode,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "message": message,
      };
}
