import 'package:ecomtest2/common_controllers/base_controller.dart';
import 'package:ecomtest2/constants/app_colors.dart';
import 'package:ecomtest2/constants/image_strings.dart';
import 'package:ecomtest2/views/home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeController>(
        create: (context) => HomeController(),
        builder: (context, snapshot) {
          return Scaffold(
            backgroundColor: AppColors.backgroundColor,
            appBar: AppBar(
              backgroundColor: AppColors.backgroundColor,
              leading: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 20,
                  ),
                ],
              ),
              actions: [
                Image.asset(
                  ImageStrings.menuIcon,
                  height: 40,
                )
              ],
            ),
            body: SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: GridView.builder(
                  itemCount: HomeController().homedata.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 20,
                    crossAxisSpacing: 20,
                    childAspectRatio: 1.47 / 1,
                  ),
                  itemBuilder: (context, index) {
                    return HomeTile(
                      text: HomeController()
                          .homedata
                          .entries
                          .elementAt(index)
                          .value[0]
                          .toString(),
                      icon: HomeController()
                          .homedata
                          .entries
                          .elementAt(index)
                          .value[1]
                          .toString(),
                      index: int.parse(HomeController()
                          .homedata
                          .entries
                          .elementAt(index)
                          .value[2]
                          .toString()),
                    );
                  },
                ),
              ),
            ),
          );
        });
  }
}

class HomeTile extends StatelessWidget {
  const HomeTile({
    super.key,
    required this.icon,
    required this.text,
    required this.index,
  });
  final String text, icon;
  final int index;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.read<BaseController>().updateSelectedIndex(index);
      },
      child: Container(
        height: 100,
        width: 150,
        decoration: BoxDecoration(
            color: AppColors.backgroundColor,
            borderRadius: BorderRadius.circular(
              15.0,
            ),
            boxShadow: [
              BoxShadow(
                blurRadius: 7,
                spreadRadius: 0,
                color: AppColors.shadowColor,
              ),
            ]),
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                icon,
                height: 35,
                width: 35,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              text,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
