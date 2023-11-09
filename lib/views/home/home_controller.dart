import 'package:ecomtest2/constants/image_strings.dart';
import 'package:flutter/material.dart';

class HomeController extends ChangeNotifier {
  final homedata = {
    0: [
      'Customers',
      ImageStrings.customerIcon,
      4,
    ],
    1: [
      'Products',
      ImageStrings.productIcon,
      5,
    ],
    2: [
      'New Order',
      ImageStrings.addProductIcon,
      1,
    ],
    3: [
      'Return Order',
      ImageStrings.returnProductIcon,
      0,
    ],
    4: [
      'Add Payment',
      ImageStrings.addPaymentIcon,
      0,
    ],
    5: [
      'Today\'s Order',
      ImageStrings.listCheckIcon,
      0,
    ],
    6: [
      'Today\'s Summary',
      ImageStrings.summaryIcon,
      0,
    ],
    7: [
      'Route',
      ImageStrings.routeIcon,
      0,
    ],
  };
}
