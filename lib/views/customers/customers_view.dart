import 'package:ecomtest2/common_controllers/base_controller.dart';
import 'package:ecomtest2/constants/app_colors.dart';
import 'package:ecomtest2/constants/image_strings.dart';
import 'package:ecomtest2/helpers/api_basehelper.dart';
import 'package:ecomtest2/views/customers/customer_controller.dart';
import 'package:ecomtest2/views/customers/customers_response.dart';
import 'package:ecomtest2/views/product/product_view.dart';
import 'package:ecomtest2/widgets/app_searchbar.dart';
import 'package:ecomtest2/widgets/common__appbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomersView extends StatelessWidget {
  CustomersView({super.key});
  final CustomerController customerController = CustomerController();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CustomerController>(
        create: (context) => customerController,
        builder: (context, child) {
          return Scaffold(
            // resizeToAvoidBottomInset: false,
            appBar: CommonAppbar(
              title: context.watch<BaseController>().selectedIndex == 1
                  ? 'New Order'
                  : 'Customers',
            ),
            body: SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    AppSearchbar(
                      showAddCustomer:
                          context.watch<BaseController>().selectedIndex == 1
                              ? false
                              : true,
                      showDropDown:
                          context.watch<BaseController>().selectedIndex == 1
                              ? false
                              : true,
                      onSuffixTap: () {
                        showModalBottomSheet(
                          isScrollControlled: true,
                          enableDrag: true,
                          context: context,
                          builder: (context) {
                            return ChangeNotifierProvider<CustomerController>(
                                create: (context) => CustomerController(),
                                builder: (context, child) {
                                  return Consumer<CustomerController>(
                                      builder: (context, controller, child) {
                                    return Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.68,
                                      width: MediaQuery.of(context).size.width,
                                      decoration: BoxDecoration(
                                        color: AppColors.backgroundColor,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                const Text(
                                                  'Add Customer',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                                InkWell(
                                                  onTap: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: CircleAvatar(
                                                    radius: 10,
                                                    child: Icon(
                                                      Icons.close,
                                                      size: 10,
                                                      color: AppColors.primary,
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 30,
                                            ),
                                            AppTextField(
                                              controller:
                                                  controller.nameController,
                                              hint: 'Customer Name',
                                            ),
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            AppTextField(
                                              controller:
                                                  controller.mobileController,
                                              hint: 'Mobile Number',
                                              inputType: TextInputType.phone,
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            AppTextField(
                                              controller:
                                                  controller.emailController,
                                              hint: 'Email',
                                              inputType:
                                                  TextInputType.emailAddress,
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    const Padding(
                                                      padding: EdgeInsets.only(
                                                          bottom: 10.0),
                                                      child: Text(
                                                        'Address',
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.4,
                                                      child: AppTextField(
                                                        controller: controller
                                                            .streetController1,
                                                        hint: 'Street',
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    const Padding(
                                                      padding: EdgeInsets.only(
                                                          bottom: 10.0),
                                                      child: Text(
                                                        '',
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.4,
                                                      child: AppTextField(
                                                        controller: controller
                                                            .streetController2,
                                                        hint: 'Street 2',
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.4,
                                                  child: AppTextField(
                                                    controller: controller
                                                        .cityController,
                                                    hint: 'City',
                                                  ),
                                                ),
                                                Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.4,
                                                  child: AppTextField(
                                                    controller: controller
                                                        .pincodeController,
                                                    hint: 'Pin Code',
                                                    inputType:
                                                        TextInputType.number,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.4,
                                                  child: AppTextField(
                                                    controller: controller
                                                        .countryController,
                                                    hint: 'Country',
                                                  ),
                                                ),
                                                Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.4,
                                                  child: AppTextField(
                                                    controller: controller
                                                        .stateController,
                                                    hint: 'State',
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 30,
                                            ),
                                            ElevatedButton(
                                              onPressed: () {
                                                controller.addCustomer(context);
                                              },
                                              style: ButtonStyle(
                                                backgroundColor:
                                                    MaterialStatePropertyAll(
                                                  AppColors.primary,
                                                ),
                                                fixedSize:
                                                    const MaterialStatePropertyAll(
                                                  Size(
                                                    100,
                                                    40,
                                                  ),
                                                ),
                                              ),
                                              child: Text(
                                                'Submit',
                                                style: TextStyle(
                                                  color:
                                                      AppColors.backgroundColor,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  });
                                });
                          },
                        );
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Selector<CustomerController, CustomersResponse?>(
                        selector: (p0, p1) => p1.customersResponse,
                        builder: (context, response, child) {
                          return response == null
                              ? const LoadingWidget()
                              : Expanded(
                                  child: ListView.builder(
                                    itemCount: response.data!.length,
                                    itemBuilder: (context, index) {
                                      return InkWell(
                                        onTap: () {
                                          var base =
                                              context.read<BaseController>();
                                          if (base.selectedIndex == 1) {
                                            base.selectedCustomer =
                                                response.data![index];
                                            base.updateSelectedIndex(5);
                                          }
                                        },
                                        child: Container(
                                          width: 150,
                                          margin: const EdgeInsets.all(5),
                                          decoration: BoxDecoration(
                                              color: AppColors.backgroundColor,
                                              borderRadius:
                                                  BorderRadius.circular(
                                                15.0,
                                              ),
                                              boxShadow: [
                                                BoxShadow(
                                                  blurRadius: 7,
                                                  spreadRadius: 0,
                                                  color: AppColors.shadowColor,
                                                ),
                                              ]),
                                          child: Row(
                                            children: [
                                              Container(
                                                height: 100,
                                                width: 100,
                                                margin:
                                                    const EdgeInsets.all(10),
                                                decoration: BoxDecoration(
                                                  color: response.data![index]
                                                              .profilePic ==
                                                          null
                                                      ? AppColors.greyBold
                                                      : null,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                    10,
                                                  ),
                                                ),
                                                child: response.data![index]
                                                            .profilePic ==
                                                        null
                                                    ? null
                                                    : ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        child: Image.network(
                                                          ApiBaseHelper
                                                                  .baseUrl +
                                                              response
                                                                  .data![index]
                                                                  .profilePic!,
                                                          fit: BoxFit.cover,
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
                                              ),
                                              const Padding(
                                                padding: EdgeInsets.only(
                                                  top: 15.0,
                                                  bottom: 15.0,
                                                ),
                                                child: VerticalDivider(),
                                              ),
                                              Container(
                                                height: 100,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    Text(
                                                      response
                                                          .data![index].name!,
                                                      style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                    ),
                                                    Row(
                                                      children: [
                                                        Text(
                                                          'ID : ',
                                                          style: TextStyle(
                                                            color: AppColors
                                                                .greyBold,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          ),
                                                        ),
                                                        Text(
                                                          response
                                                              .data![index].id!
                                                              .toString(),
                                                          style: TextStyle(
                                                            color: AppColors
                                                                .greyBold,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Container(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.35,
                                                      child: Text(
                                                        '${response.data![index].street!},${response.data![index].city!},${response.data![index].country!}',
                                                        style: TextStyle(
                                                          color: AppColors
                                                              .greyBold,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        ),
                                                      ),
                                                    ),
                                                    // const Row(
                                                    //   children: [
                                                    //     Text(
                                                    //       'Due Amount : ',
                                                    //       style: TextStyle(
                                                    //         fontWeight: FontWeight.w600,
                                                    //       ),
                                                    //     ),
                                                    //     Text(
                                                    //       '\$${response.data![index].}',
                                                    //       style: TextStyle(
                                                    //         fontWeight: FontWeight.w600,
                                                    //       ),
                                                    //     ),
                                                    //   ],
                                                    // ),
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                height: 100,
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        CircleAvatar(
                                                          radius: 10,
                                                          backgroundColor:
                                                              AppColors.primary,
                                                          child: Icon(
                                                            Icons.phone_rounded,
                                                            color: AppColors
                                                                .backgroundColor,
                                                            size: 12,
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          width: 10,
                                                        ),
                                                        CircleAvatar(
                                                          radius: 10,
                                                          backgroundColor:
                                                              AppColors.primary,
                                                          child: Icon(
                                                            Icons.chat_bubble,
                                                            color: AppColors
                                                                .backgroundColor,
                                                            size: 12,
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                );
                        }),
                  ],
                ),
              ),
            ),
          );
        });
  }
}

class AppTextField extends StatelessWidget {
  const AppTextField({
    super.key,
    this.controller,
    required this.hint,
    this.inputType,
  });
  final TextEditingController? controller;
  final String hint;
  final TextInputType? inputType;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              hint!,
              style: TextStyle(
                color: AppColors.grey,
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        // const SizedBox(
        //   height: 5,
        // ),
        SizedBox(
          height: 25,
          child: TextField(
            controller: controller,
            keyboardType: inputType,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(8),
              isDense: true,
              isCollapsed: true,
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                color: AppColors.grey,
              )),
            ),
            style: const TextStyle(
              fontSize: 10,
            ),
            cursorHeight: 14,
            textAlign: TextAlign.start,
          ),
        )
      ],
    );
  }
}
