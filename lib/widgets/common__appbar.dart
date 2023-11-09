import 'package:ecomtest2/common_controllers/base_controller.dart';
import 'package:ecomtest2/constants/image_strings.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CommonAppbar extends StatelessWidget implements PreferredSizeWidget {
  const CommonAppbar({
    super.key,
    required this.title,
    this.subTitle,
  });
  final String title;
  final String? subTitle;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: InkWell(
        onTap: () {
          if (Navigator.canPop(context)) {
            Navigator.pop(context);
          } else {
            context.read<BaseController>().updateSelectedIndex(0);
          }
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              ImageStrings.backIcon,
              height: 35,
            ),
          ],
        ),
      ),
      centerTitle: true,
      title: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (title != '')
            Text(
              title,
              style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w700,
              ),
            ),
          if (subTitle != null)
            if (subTitle != '')
              Text(
                subTitle!,
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                ),
              ),
        ],
      ),
      actions: [
        Image.asset(
          ImageStrings.menuIcon,
          height: 35,
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(55);
}
