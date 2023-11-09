import 'package:ecomtest2/helpers/api_provider.dart';
import 'package:ecomtest2/helpers/storage_helper.dart';
import 'package:ecomtest2/views/cart/cart_product.dart';
import 'package:ecomtest2/views/product/product_model.dart';
import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';

class ProductController extends ChangeNotifier {
  bool productLoading = false;
  ProductsResponse? productsResponse;
  ApiProvider repository = ApiProvider();
  TextEditingController controller = TextEditingController();

  ProductController() {
    init();
    getProducts();
  }
  init() async {
    var cartProducts = await StorageHelper().readCart();
    // productsResponse = ProductsResponse(
    //     data: await StorageHelper().readProducts()
    //       ..forEach((element) {
    //         for (var cartProduct in cartProducts) {
    //           if (cartProduct.id == element.id) {
    //             element.count = cartProduct.count ?? 0;
    //           }
    //         }
    //       }));

    // productsResponse!.data!.forEach((element) {
    //   cartProducts.forEach((cartProduct) {
    //     if (cartProduct.id == element.id) {
    //       element.count = cartProduct.count ?? 0;
    //     }
    //   });
    // });
    notifyListeners();
  }

  void getProducts({String? keyword}) async {
    productLoading = true;
    notifyListeners();
    Either<ProductsResponse, Failure> resp = await repository.getProducts(
      search: keyword,
    );
    resp.fold((l) async {
      // productsResponse!.data!.clear();
      // notifyListeners();
      // if (productsResponse != null) {
      //   for (var element in l.data!) {
      //     if (productsResponse!.data!.contains(element)) {
      //       productsResponse!.data!
      //           .elementAt(productsResponse!.data!.indexOf(element))
      //           .updateElement(element);
      //     } else {
      //       productsResponse!.data!.add(element);
      //     }
      //   }
      // } else {
      // productsResponse = l;
      // }
      // if (productsResponse!.data!.isEmpty) {
      //   print('empty');
      // }
      // notifyListeners();
      // productsResponse = l;
      // if (productsResponse != null) {
      //   for (var lData in l.data!) {
      //     var flag = false;
      //     for (var pData in productsResponse!.data!) {
      //       if (pData.id == lData.id) {
      //         // pData
      //         //   ..count = lData.count
      //         //   ..price = lData.price
      //         //   ..image = lData.image;

      //         flag = true;
      //       }
      //     }
      //     if (!flag) {
      //       productsResponse!.data!.add(lData);
      //     }
      //   }
      // } else {
      productsResponse = l;
      // }
      // var products = await StorageHelper().readProducts();
      // for (var element in productsResponse!.data!) {
      //   var flag = false;
      //   for (var product in products) {
      //     if (product.id == element.id) {
      //       flag = true;
      //     }
      //   }
      //   if (!flag) {}
      // }
      var cartProducts = await StorageHelper().readCart();
      for (var element in productsResponse!.data!) {
        for (var cartProduct in cartProducts) {
          if (cartProduct.id == element.id) {
            element.count = cartProduct.count ?? 0;
          }
        }
      }

      StorageHelper().storeProductList(productsResponse!.data ?? []);
      productLoading = false;
      notifyListeners();
    }, (r) {
      productLoading = false;
      notifyListeners();
    });
  }
}
