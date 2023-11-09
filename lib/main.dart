import 'dart:io';

import 'package:ecomtest2/constants/app_colors.dart';
import 'package:ecomtest2/common_controllers/base_controller.dart';
import 'package:ecomtest2/helpers/storage_helper.dart';
import 'package:ecomtest2/views/cart/cart_controller.dart';
import 'package:ecomtest2/views/cart/cart_product.dart';
import 'package:ecomtest2/views/cart/cart_view.dart';
import 'package:ecomtest2/views/customers/customer_model.dart';
import 'package:ecomtest2/views/customers/customers_view.dart';
import 'package:ecomtest2/views/home/home_view.dart';
import 'package:ecomtest2/views/product/product_model.dart';
import 'package:ecomtest2/views/product/product_view.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(CartProductAdapter());
  Hive.registerAdapter(CustomerAdapter());
  StorageHelper();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => BaseController(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ecom Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        fontFamily: 'Poppins',
      ),
      home: Selector<BaseController, int>(
        selector: (p0, p1) {
          return p1.selectedIndex;
        },
        builder: (context, value, child) {
          switch (value) {
            case 0:
              return const HomeView();
            case 1:
              return CustomersView();
            case 2:
              return const CartView();
            case 4:
              return CustomersView();
            case 5:
              return ProductView();
            default:
              return const HomeView();
          }
        },
      ),
      builder: (context, child) {
        return Scaffold(
          // resizeToAvoidBottomInset: false,
          body: child,
          bottomNavigationBar: BottomAppBar(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                BottomIcon(
                  icon: Icons.home,
                  text: 'Home',
                  onTap: () {
                    context.read<BaseController>().updateSelectedIndex(0);
                  },
                ),
                BottomIcon(
                  icon: Icons.add_box,
                  text: 'New Order',
                  onTap: () {
                    context.read<BaseController>().updateSelectedIndex(1);
                  },
                ),
                BottomIcon(
                  icon: Icons.shopping_bag,
                  text: 'Cart',
                  onTap: () {
                    context.read<BaseController>().updateSelectedIndex(2);
                  },
                ),
                BottomIcon(
                  icon: Icons.keyboard_return,
                  text: 'Return Order',
                  onTap: () {
                    context.read<BaseController>().updateSelectedIndex(3);
                  },
                ),
                BottomIcon(
                  icon: Icons.people_alt,
                  text: 'Customers',
                  onTap: () {
                    context.read<BaseController>().updateSelectedIndex(4);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class BottomIcon extends StatelessWidget {
  const BottomIcon({
    super.key,
    required this.icon,
    required this.text,
    required this.onTap,
  });

  final IconData icon;
  final String text;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: AppColors.primary,
          ),
          Text(
            text,
            style: TextStyle(
              color: AppColors.primary,
              fontSize: 11,
            ),
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
