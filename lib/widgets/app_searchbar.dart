import 'package:ecomtest2/constants/app_colors.dart';
import 'package:ecomtest2/constants/image_strings.dart';
import 'package:flutter/material.dart';

class AppSearchbar extends StatelessWidget {
  AppSearchbar({
    super.key,
    this.onSuffixTap,
    this.onQrTap,
    this.showAddCustomer = false,
    this.controller,
    this.showDropDown = false,
  });
  final Function()? onSuffixTap, onQrTap;
  final bool showAddCustomer, showDropDown;
  final TextEditingController? controller;

  final FocusNode focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 38,
      child: RawKeyboardListener(
        autofocus: true,
        focusNode: focusNode,
        onKey: (RawKeyEvent event) {
          if (event.runtimeType.toString() == 'RawKeyDownEvent') {
            String key = event.logicalKey.keyLabel;
            if (key != null) {
              controller!.text += key;
            }
          }
        },
        child: SearchBar(
          controller: controller,
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              ImageStrings.searchIcon,
              height: 20,
              color: AppColors.grey,
            ),
          ),
          hintText: 'Search',
          hintStyle: MaterialStatePropertyAll(TextStyle(
            color: AppColors.grey,
            fontWeight: FontWeight.w600,
          )),
          backgroundColor: MaterialStatePropertyAll(
            AppColors.backgroundColor,
          ),
          elevation: const MaterialStatePropertyAll(0),
          side: MaterialStatePropertyAll(
            BorderSide(
              color: AppColors.greyBold,
            ),
          ),
          trailing: [
            InkWell(
              onTap: onQrTap,
              child: Image.asset(
                ImageStrings.qrIcon,
                height: 20,
                color: AppColors.grey,
              ),
            ),
            if (showAddCustomer || showDropDown)
              Container(
                color: AppColors.greyBold,
                margin: const EdgeInsets.all(10),
                height: 25,
                width: 1,
              ),
            (showAddCustomer)
                ? InkWell(
                    onTap: onSuffixTap,
                    child: CircleAvatar(
                      backgroundColor: AppColors.primary,
                      radius: 12,
                      child: Icon(
                        Icons.add,
                        size: 12,
                        color: AppColors.backgroundColor,
                      ),
                    ),
                  )
                : (showDropDown)
                    ? DropdownButton(
                        items: [
                          DropdownMenuItem(
                            child: Text(
                              'Fruits',
                              style: TextStyle(
                                color: AppColors.greyBold,
                              ),
                            ),
                          )
                        ],
                        icon: const Icon(
                          Icons.arrow_drop_down_sharp,
                        ),
                        onChanged: (value) {},
                        underline: const SizedBox(),
                      )
                    : const SizedBox()
          ],
        ),
      ),
    );
  }
}
