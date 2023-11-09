import 'dart:convert';

import 'package:ecomtest2/helpers/storage_helper.dart';
import 'package:ecomtest2/views/cart/cart_controller.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

class ProductsResponse extends ChangeNotifier {
  int? errorCode;

  List<Product>? data;

  String? message;

  ProductsResponse({
    this.errorCode,
    this.data,
    this.message,
  });

  factory ProductsResponse.fromRawJson(String str) =>
      ProductsResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ProductsResponse.fromJson(Map<String, dynamic> json) =>
      ProductsResponse(
        errorCode: json["error_code"],
        data: json["data"] == null
            ? []
            : List<Product>.from(json["data"]!.map((x) => Product.fromJson(x))),
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

class Product extends ChangeNotifier {
  int? id;
  String? name;
  String? image;
  int? price;
  int? count;
  DateTime? createdDate;
  String? createdTime;
  DateTime? modifiedDate;
  String? modifiedTime;
  bool? flag;

  Product({
    this.id,
    this.name,
    this.image,
    this.price,
    this.count,
    this.createdDate,
    this.createdTime,
    this.modifiedDate,
    this.modifiedTime,
    this.flag,
  });

  addCount(BuildContext? context) {
    if (count == null) {
      count = 1;
    } else {
      count = count! + 1;
    }

    StorageHelper().storeCartProduct(this);
    notifyListeners();
  }

  minusCount(BuildContext? context) {
    if (count == null) {
      count = 1;
      StorageHelper().storeCartProduct(this);
    } else {
      if (count != 1) {
        count = count! - 1;
        StorageHelper().storeCartProduct(this);
      } else {
        count = null;
      }
    }
    notifyListeners();
  }

  factory Product.fromRawJson(String str) => Product.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        name: json["name"],
        image: json["image"],
        price: json["price"],
        createdDate: json["created_date"] == null
            ? null
            : DateTime.parse(json["created_date"]),
        createdTime: json["created_time"],
        modifiedDate: json["modified_date"] == null
            ? null
            : DateTime.parse(json["modified_date"]),
        modifiedTime: json["modified_time"],
        flag: json["flag"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
        "price": price,
        "created_date":
            "${createdDate!.year.toString().padLeft(4, '0')}-${createdDate!.month.toString().padLeft(2, '0')}-${createdDate!.day.toString().padLeft(2, '0')}",
        "created_time": createdTime,
        "modified_date":
            "${modifiedDate!.year.toString().padLeft(4, '0')}-${modifiedDate!.month.toString().padLeft(2, '0')}-${modifiedDate!.day.toString().padLeft(2, '0')}",
        "modified_time": modifiedTime,
        "flag": flag,
      };

  void updateElement(Product element) {
    name = element.name;
    price = element.price;
    image = element.image;
    notifyListeners();
  }
}
