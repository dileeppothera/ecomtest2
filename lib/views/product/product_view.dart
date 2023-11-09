import 'package:ecomtest2/common_controllers/base_controller.dart';
import 'package:ecomtest2/constants/app_colors.dart';
import 'package:ecomtest2/constants/image_strings.dart';
import 'package:ecomtest2/helpers/api_basehelper.dart';
import 'package:ecomtest2/views/cart/cart_controller.dart';
import 'package:ecomtest2/views/product/product_controller.dart';
import 'package:ecomtest2/views/product/product_model.dart';
import 'package:ecomtest2/widgets/app_searchbar.dart';
import 'package:ecomtest2/widgets/common__appbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductView extends StatelessWidget {
  ProductView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ProductController>(
        create: (context) => ProductController(),
        builder: (context, snapshot) {
          return Scaffold(
            appBar: CommonAppbar(
              title: context.watch<BaseController>().selectedCustomer.id == null
                  ? 'Products'
                  : '',
              subTitle:
                  context.watch<BaseController>().selectedCustomer.id != null
                      ? context.watch<BaseController>().selectedCustomer.name
                      : '',
            ),
            body: SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    AppSearchbar(
                      showDropDown: true,
                      onQrTap: () {},
                      controller: context.read<ProductController>().controller
                        ..addListener(() {
                          if (context
                              .read<ProductController>()
                              .controller
                              .text
                              .isEmpty) {
                            context.read<ProductController>().getProducts();
                          }
                          if (context
                                  .read<ProductController>()
                                  .controller
                                  .text
                                  .length >
                              2) {
                            context.read<ProductController>().getProducts(
                                  keyword: context
                                      .read<ProductController>()
                                      .controller
                                      .text,
                                );
                          }
                        }),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Expanded(
                      child: Selector<ProductController, ProductsResponse?>(
                          selector: (p0, p1) => p1.productsResponse,
                          builder: (context, productResp, child) {
                            return productResp == null
                                ? const LoadingWidget()
                                : ChangeNotifierProvider<ProductsResponse>(
                                    create: (context) => productResp,
                                    builder: (context, snapshot) {
                                      return Consumer<ProductsResponse>(
                                          builder: (context, response, child) {
                                        return GridView.builder(
                                          itemCount: response.data!.length,
                                          gridDelegate:
                                              const SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 2,
                                            mainAxisSpacing: 10,
                                            crossAxisSpacing: 10,
                                            childAspectRatio: 1.3 / 1,
                                          ),
                                          itemBuilder: (context, index) {
                                            return ChangeNotifierProvider<
                                                    Product>(
                                                create: (context) =>
                                                    response.data![index],
                                                builder: (context, snapshot) {
                                                  return Container(
                                                    height: 100,
                                                    width: 150,
                                                    decoration: BoxDecoration(
                                                        color: AppColors
                                                            .backgroundColor,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                          15.0,
                                                        ),
                                                        boxShadow: [
                                                          BoxShadow(
                                                            blurRadius: 7,
                                                            spreadRadius: 0,
                                                            color: AppColors
                                                                .shadowColor,
                                                          ),
                                                        ]),
                                                    child: Column(
                                                      children: [
                                                        const SizedBox(
                                                          height: 10,
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Image.network(
                                                            ApiBaseHelper
                                                                    .baseUrl +
                                                                response
                                                                    .data![
                                                                        index]
                                                                    .image!,
                                                            height: 55,
                                                            width: 65,
                                                            errorBuilder:
                                                                (context, error,
                                                                    stackTrace) {
                                                              return Container(
                                                                  height: 55,
                                                                  width: 65,
                                                                  child:
                                                                      const Placeholder());
                                                            },
                                                          ),
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceAround,
                                                          children: [
                                                            Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceAround,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                SizedBox(
                                                                  width: 65,
                                                                  child:
                                                                      SingleChildScrollView(
                                                                    scrollDirection:
                                                                        Axis.horizontal,
                                                                    child: Text(
                                                                      response
                                                                          .data![
                                                                              index]
                                                                          .name!,
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                      style:
                                                                          const TextStyle(
                                                                        fontWeight:
                                                                            FontWeight.w600,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                const SizedBox(
                                                                  height: 5,
                                                                ),
                                                                Text(
                                                                  '\$${response.data![index].price}/-',
                                                                  style:
                                                                      const TextStyle(
                                                                    fontSize:
                                                                        13,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            Row(
                                                              children: [
                                                                Container(
                                                                  height: 25,
                                                                  color: AppColors
                                                                      .greyBold,
                                                                  width: 1,
                                                                ),
                                                                const SizedBox(
                                                                  width: 10,
                                                                ),
                                                                Container(
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: AppColors
                                                                        .primary,
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(
                                                                      10,
                                                                    ),
                                                                  ),
                                                                  height: 30,
                                                                  width: 80,
                                                                  child: Center(
                                                                    child: Selector<
                                                                            Product,
                                                                            int?>(
                                                                        selector:
                                                                            (p0, p1) => p1
                                                                                .count,
                                                                        builder: (context,
                                                                            count,
                                                                            child) {
                                                                          return count == null
                                                                              ? InkWell(
                                                                                  onTap: () {
                                                                                    response.data![index].addCount(context);
                                                                                  },
                                                                                  child: SizedBox(
                                                                                    height: 30,
                                                                                    width: 80,
                                                                                    child: Center(
                                                                                      child: Text(
                                                                                        'Add',
                                                                                        style: TextStyle(
                                                                                          color: AppColors.backgroundColor,
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                )
                                                                              : Row(
                                                                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                                                  children: [
                                                                                    InkWell(
                                                                                      onTap: () {
                                                                                        response.data![index].minusCount(context);
                                                                                      },
                                                                                      child: SizedBox(
                                                                                        width: 10,
                                                                                        height: 20,
                                                                                        child: Text(
                                                                                          '-',
                                                                                          style: TextStyle(
                                                                                            color: AppColors.backgroundColor,
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                    SizedBox(
                                                                                      height: 20,
                                                                                      child: Text(
                                                                                        count.toString(),
                                                                                        style: TextStyle(
                                                                                          color: AppColors.backgroundColor,
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                    InkWell(
                                                                                      onTap: () {
                                                                                        response.data![index].addCount(context);
                                                                                      },
                                                                                      child: SizedBox(
                                                                                        width: 10,
                                                                                        height: 20,
                                                                                        child: Text(
                                                                                          '+',
                                                                                          style: TextStyle(
                                                                                            color: AppColors.backgroundColor,
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  ],
                                                                                );
                                                                        }),
                                                                  ),
                                                                ),
                                                              ],
                                                            )
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  );
                                                });
                                          },
                                        );
                                      });
                                    });
                          }),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
        height: 50,
        width: 50,
        child: Column(
          children: [
            CircularProgressIndicator.adaptive(),
          ],
        ));
  }
}
