import 'dart:io';

import 'package:ecomtest2/common_controllers/base_controller.dart';
import 'package:ecomtest2/helpers/api_provider.dart';
import 'package:ecomtest2/helpers/storage_helper.dart';
import 'package:ecomtest2/helpers/toast.dart';
import 'package:ecomtest2/views/cart/cart_product.dart';
import 'package:ecomtest2/views/product/product_model.dart';
import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

class CartController extends ChangeNotifier {
  var cart;
  bool orderLoading = false;
  ApiProvider repository = ApiProvider();
  List<CartProduct> cartProducts = [];
  CartController() {
    init();
  }

  init() async {
    cartProducts = await StorageHelper().readCart();
    notifyListeners();
  }

  checkOut(BuildContext context) async {
    if (context.read<BaseController>().selectedCustomer.id == null) {
      appToast(context, 'Select a customer');
      return;
    }
    if (cartProducts.isEmpty) {
      appToast(context, 'Select products');
      return;
    }

    orderLoading = true;
    notifyListeners();
    Either<Success, Failure> resp = await repository.checkOut(
      customerId:
          context.read<BaseController>().selectedCustomer.id!.toString(),
      cartProducts: cartProducts,
    );
    resp.fold((l) {
      appToast(context, l.message ?? 'Checked out successfully');
      cartProducts = [];
      var box = Hive.box('cart');
      box.clear();
    }, (r) {
      appToast(context, r.text ?? 'Some error occured..Please try again');
    });
  }

//   var box = await Hive.openBox('myBox');

// var person = Person()
}
