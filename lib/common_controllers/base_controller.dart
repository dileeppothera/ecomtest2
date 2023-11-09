import 'package:ecomtest2/views/customers/customer_model.dart';
import 'package:ecomtest2/views/customers/customers_response.dart';
import 'package:flutter/material.dart';

class BaseController extends ChangeNotifier {
  int selectedIndex = 0;
  updateSelectedIndex(int selected) {
    selectedIndex = selected;
    notifyListeners();
  }

  Customer selectedCustomer = Customer();
}
