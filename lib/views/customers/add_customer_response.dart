import 'dart:convert';

import 'package:ecomtest2/views/customers/customer_model.dart';

class AddCustomerResponse {
  final int? errorCode;
  final Customer? data;
  final String? message;

  AddCustomerResponse({
    this.errorCode,
    this.data,
    this.message,
  });

  factory AddCustomerResponse.fromRawJson(String str) =>
      AddCustomerResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AddCustomerResponse.fromJson(Map<String, dynamic> json) =>
      AddCustomerResponse(
        errorCode: json["error_code"],
        data: json["data"] == null ? null : Customer.fromJson(json["data"]),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "error_code": errorCode,
        "data": data?.toJson(),
        "message": message,
      };
}
