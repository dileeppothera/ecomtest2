import 'package:ecomtest2/views/cart/cart_product.dart';
import 'package:ecomtest2/views/customers/customer_model.dart';
import 'package:ecomtest2/views/customers/customers_response.dart';
import 'package:ecomtest2/views/product/product_model.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class StorageHelper {
  //
  StorageHelper() {
    initStorage();
  }
  deleteCartProduct(CartProduct product) async {
    var persons = await Hive.openBox('cart');
    if (persons.isNotEmpty) {
      if (persons.values.isNotEmpty) {
        var flag = false;
        var a = (persons.values.first as List);
        for (var element in a) {
          if (element.id == product.id) {
            flag = true;
          }
        }
        if (flag) {
          a.remove(product);
          persons.add(a);
          print(persons.values.first);
        }
      }
    }
  }

  //
  storeCartProduct(Product product) async {
    var cartProduct = CartProduct()
      ..id = product.id
      ..name = product.name
      ..count = product.count
      ..image = product.image
      ..price = product.price;
    var cartList =
        Hive.isBoxOpen('cart') ? Hive.box('cart') : await Hive.openBox('cart');

    // persons.add(person); // Store this object for the first time

    // person.save(); // Update object

    // person.delete(); // Remove object from Hive
    List<CartProduct> currentProducts = [];

    if (cartList.isEmpty && cartProduct.count! > 0) {
      currentProducts.add(cartProduct);
    } else {
      var a = (cartList.values.first as List);
      // var b = a.first as CartProduct;
      bool existsInCart = false;
      for (var (element as CartProduct) in a) {
        if (element.id == cartProduct.id) {
          existsInCart = true;

          element.count = cartProduct.count;
        }
      }
      if (!existsInCart) {
        a.add(cartProduct);
      }
      var removable = CartProduct();
      for (var (element as CartProduct) in a) {
        print(('${element.name!}${element.count}'));
        if (element.count! <= 0) {
          removable = element;
        }
      }
      if (removable.id != null) {
        a.remove(removable);
      }
    }
    if (cartProduct.count == null) {
      currentProducts.remove(cartProduct);
    }
    if (cartProduct.count! <= 0) {
      currentProducts.remove(cartProduct);
    }

    cartList.add(currentProducts);
  }

  Future<List<CartProduct>> readCart() async {
    // var box = Hive.box('myBox');
    var persons = await Hive.openBox('cart');
    if (persons.isEmpty) {
      return [];
    }

    var a = (persons.values.elementAt(0) as List);
    print(persons.values.first);
    List<CartProduct> currentProducts = [];
    for (var element in a) {
      currentProducts.add((element as CartProduct));
    }
    return currentProducts;
  }

  void storeProductList(List<Product> productList) async {
    // var box = Hive.box('myBox');
    var tempCartProducts = [];
    for (var element in productList) {
      tempCartProducts.add(CartProduct()
        ..id = element.id
        ..name = element.name
        ..count = element.count
        ..image = element.image
        ..price = element.price);
    }
    var products = await Hive.openBox('products');
    if (products.isEmpty) {
      products.add(tempCartProducts);
    } else {
      products.clear();
      products.add(tempCartProducts);
    }
  }

  Future<List<Product>> readProducts() async {
    var products = await Hive.openBox('products');
    if (products.isEmpty) {
      return [];
    }

    var a = (products.values.first as List);

    List<CartProduct> currentProducts = [];
    for (var element in a) {
      currentProducts.add((element as CartProduct));
    }
    var tempProductList = <Product>[];
    currentProducts.forEach((element) {
      tempProductList.add(Product(
        id: element.id,
        name: element.name,
        count: element.count,
        image: element.image,
        price: element.price,
      ));
    });

    return tempProductList;
  }

  void storeCustomers(List<Customer> customerList) async {
    var customers = Hive.isBoxOpen('customers')
        ? Hive.box('customers')
        : await Hive.openBox('customers');
    customers.clear();
    customers.add(customerList);
  }

  Future<List<Customer>> readCustomers() async {
    var customers = Hive.isBoxOpen('customers')
        ? Hive.box('customers')
        : await Hive.openBox('customers');
    List<Customer> temp = [];
    List currentValues = customers.values.isEmpty
        ? []
        : customers.values.first == null
            ? []
            : customers.values.first!.isEmpty
                ? []
                : customers.values.first!;
    currentValues.forEach((element) {
      temp.add(element);
    });
    return temp;
  }

  void initStorage() async {
    await Hive.openBox('cart');
    await Hive.openBox('customers');
    // .then((value) => value.isEmpty ? value.add([]) : value);

    await Hive.openBox('products');
  }
}
