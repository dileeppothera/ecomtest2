import 'package:ecomtest2/constants/app_colors.dart';
import 'package:ecomtest2/constants/image_strings.dart';
import 'package:ecomtest2/helpers/storage_helper.dart';
import 'package:ecomtest2/views/cart/cart_controller.dart';
import 'package:ecomtest2/views/cart/cart_product.dart';
import 'package:ecomtest2/views/product/product_controller.dart';
import 'package:ecomtest2/views/product/product_model.dart';
import 'package:ecomtest2/widgets/app_searchbar.dart';
import 'package:ecomtest2/widgets/common__appbar.dart';
import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

class CartView extends StatelessWidget {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CommonAppbar(
        title: 'Cart',
      ),
      body: ChangeNotifierProvider<CartController>(
          create: (context) => CartController(),
          builder: (context, child) {
            return SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Selector<CartController, List<CartProduct>>(
                          selector: (p0, p1) => p1.cartProducts,
                          builder: (context, products, child) {
                            return ValueListenableBuilder(
                                valueListenable: Hive.box('cart').listenable(),
                                builder: (context, box, widget) {
                                  if (box.values.isNotEmpty) {
                                    if (box.values.first.isEmpty) {
                                    } else {
                                      products.clear();
                                      var a = box.values.first;
                                      for (var element in a) {
                                        products.add(element);
                                      }
                                      // box.values.first as List<CartProduct>;
                                    }
                                  }
                                  return box.values.isEmpty
                                      ? const SizedBox()
                                      : box.values.first.isEmpty
                                          ? const SizedBox()
                                          : ListView.separated(
                                              shrinkWrap: true,
                                              physics:
                                                  const ClampingScrollPhysics(),
                                              itemCount: products.length,
                                              itemBuilder: (context, index) {
                                                return Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          products[index]
                                                                  .name ??
                                                              '',
                                                          style:
                                                              const TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                        Text(
                                                          '\$${products[index].price} /-',
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            color: AppColors
                                                                .primary,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                          ),
                                                          height: 30,
                                                          width: 80,
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceAround,
                                                            children: [
                                                              InkWell(
                                                                onTap: () {
                                                                  StorageHelper()
                                                                      .storeCartProduct(
                                                                    Product(
                                                                      id: products[
                                                                              index]
                                                                          .id,
                                                                      name: products[
                                                                              index]
                                                                          .name,
                                                                      image: products[
                                                                              index]
                                                                          .image,
                                                                      price: products[
                                                                              index]
                                                                          .price,
                                                                      count:
                                                                          products[index].count! -
                                                                              1,
                                                                    ),
                                                                  );
                                                                },
                                                                child: SizedBox(
                                                                  width: 10,
                                                                  height: 20,
                                                                  child: Text(
                                                                    '-',
                                                                    style:
                                                                        TextStyle(
                                                                      color: AppColors
                                                                          .backgroundColor,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                height: 20,
                                                                child: Text(
                                                                  products[
                                                                          index]
                                                                      .count
                                                                      .toString(),
                                                                  style:
                                                                      TextStyle(
                                                                    color: AppColors
                                                                        .backgroundColor,
                                                                  ),
                                                                ),
                                                              ),
                                                              InkWell(
                                                                onTap: () {
                                                                  StorageHelper()
                                                                      .storeCartProduct(
                                                                    Product(
                                                                      id: products[
                                                                              index]
                                                                          .id,
                                                                      name: products[
                                                                              index]
                                                                          .name,
                                                                      image: products[
                                                                              index]
                                                                          .image,
                                                                      price: products[
                                                                              index]
                                                                          .price,
                                                                      count:
                                                                          products[index].count! +
                                                                              1,
                                                                    ),
                                                                  );
                                                                },
                                                                child: SizedBox(
                                                                  width: 10,
                                                                  height: 20,
                                                                  child: Text(
                                                                    '+',
                                                                    style:
                                                                        TextStyle(
                                                                      color: AppColors
                                                                          .backgroundColor,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          width: 10,
                                                        ),
                                                        InkWell(
                                                          onTap: () =>
                                                              StorageHelper()
                                                                  .deleteCartProduct(
                                                            products[index],
                                                          ),
                                                          child: Image.asset(
                                                            ImageStrings
                                                                .deleteIcon,
                                                            height: 20,
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          width: 10,
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                );
                                              },
                                              separatorBuilder:
                                                  (context, index) {
                                                return const Divider();
                                              },
                                            );
                                });
                          }),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: 180,
                        padding: const EdgeInsets.all(8),
                        width: MediaQuery.of(context).size.width * 0.8,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: AppColors.greyBold,
                          ),
                          borderRadius: BorderRadius.circular(
                            15,
                          ),
                        ),
                        child: ValueListenableBuilder(
                          valueListenable: Hive.box('cart').listenable(),
                          builder: (context, box, widget) {
                            List<CartProduct> products = [];
                            double sum = 0;
                            if (box.values.isNotEmpty) {
                              if (box.values.first.isEmpty) {
                              } else {
                                products.clear();
                                var a = box.values.first;
                                for (var element in a) {
                                  products.add(element);
                                  sum = sum +
                                      ((element.count) *
                                          (element.price as int));
                                }
                              }
                            }
                            return Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      'SubTotal',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Text(
                                      sum.toString(),
                                    ),
                                  ],
                                ),
                                const Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Tax',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Text(
                                      '0',
                                    ),
                                  ],
                                ),
                                const Divider(),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      'Total',
                                      style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Text(
                                      sum.toString(),
                                      style: const TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    ElevatedButton(
                                      onPressed: () {
                                        context
                                            .read<CartController>()
                                            .checkOut(context);
                                      },
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStatePropertyAll(
                                          AppColors.primary,
                                        ),
                                        fixedSize:
                                            const MaterialStatePropertyAll(
                                          Size(
                                            145,
                                            50,
                                          ),
                                        ),
                                      ),
                                      child: Text(
                                        'Order',
                                        style: TextStyle(
                                          color: AppColors.backgroundColor,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        context
                                            .read<CartController>()
                                            .checkOut(context);
                                      },
                                      style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStatePropertyAll(
                                            AppColors.primary,
                                          ),
                                          fixedSize:
                                              const MaterialStatePropertyAll(
                                            Size(
                                              145,
                                              50,
                                            ),
                                          )),
                                      child: Text(
                                        'Order & Deliver',
                                        style: TextStyle(
                                          color: AppColors.backgroundColor,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            );
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}
