import 'package:day_night_switcher/day_night_switcher.dart';
import 'package:e_commerce/controllers/popular_product_controller.dart';
import 'package:e_commerce/controllers/recommeded_product_controller.dart';
import 'package:e_commerce/pages/home/food_page_body.dart';
import 'package:e_commerce/services/theme_services.dart';
import 'package:e_commerce/ui/theme.dart';
import 'package:e_commerce/utils/colors.dart';
import 'package:e_commerce/utils/dimensions.dart';
import 'package:e_commerce/widgets/big_text.dart';
import 'package:e_commerce/widgets/small_text.dart';
import 'package:e_commerce/widgets/static_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class MainFoodPage extends StatefulWidget {
  const MainFoodPage({Key? key}) : super(key: key);

  @override
  State<MainFoodPage> createState() => _MainFoodPageState();
}

class _MainFoodPageState extends State<MainFoodPage> {
  Future<void> _loadResources() async {
    await Get.find<PopularProductController>().getPopularProductList();
    await Get.find<RecommendedProductController>().getRecommendedProductList();
    // Get.find<CartController>();
  }

  bool isDarkModeEnabled = false;
  final data = GetStorage();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (data.read('mode') != null) {
      isDarkModeEnabled = data.read('mode');
    }
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
        color: Get.isDarkMode
            ? context.theme.backgroundColor
            : context.theme.primaryColorLight,
        child: Column(
          children: [
            // showing the header
            Container(
              // color: context.theme.primaryColorDark,
              child: Container(
                margin: EdgeInsets.only(
                    top: Dimensions.height45, bottom: Dimensions.height15),
                padding: EdgeInsets.only(
                  left: Dimensions.width20,
                  right: Dimensions.width20,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 25),
                          child: Row(
                            children: [
                              StaticText(
                                text: "Nigeria",
                                color: AppColors.mainColor,
                              ),
                              SizedBox(width: 30),

                              // GestureDetector(
                              //   onTap: () {
                              //     ThemeServices().switchTheme();
                              //     // notifyHelper.displayNotification(
                              //     //   title: "Theme Changed",
                              //     //   body: Get.isDarkMode
                              //     //       ? "Activated Light Theme"
                              //     //       : "Activated Dark Theme",
                              //     // );

                              //     // notifyHelper.scheduledNotification();
                              //   },
                              //   child: Icon(
                              //     Get.isDarkMode
                              //         ? Icons.wb_sunny_outlined
                              //         : Icons.nightlight_round,
                              //     size: 20,
                              //     color: Get.isDarkMode
                              //         ? Colors.white
                              //         : Colors.black,
                              //   ),
                              // ),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            SmallText(
                              text: "Port Harcourt",
                              color: Colors.black,
                            ),
                            Icon(Icons.arrow_drop_down_rounded)
                          ],
                        ),
                        Container(
                          height: Dimensions.height45,
                          width: Dimensions.height30 * 2,
                          child: DayNightSwitcher(
                              dayBackgroundColor: AppColors.mainColor,
                              isDarkModeEnabled: isDarkModeEnabled,
                              onStateChanged: onStateChanged),
                        ),
                      ],
                    ),
                    Center(
                      child: Padding(
                        padding:
                            EdgeInsets.only(bottom: Dimensions.height40 + 10),
                        child: Container(
                          width: Dimensions.height45,
                          height: Dimensions.height45,
                          child: Icon(
                            Icons.search,
                            color: Get.isDarkMode
                                ? context.theme.primaryColorDark
                                : Colors.white,
                            size: Dimensions.iconSize24,
                          ),
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(Dimensions.radius15),
                            color: AppColors.mainColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // showing the body
            Expanded(
              child: SingleChildScrollView(
                child: FoodPageBody(),
              ),
            ),
          ],
        ),
        onRefresh: _loadResources);
  }

  void onStateChanged(bool isDarkModeEnabled) {
    setState(() {
      this.isDarkModeEnabled = isDarkModeEnabled;
      if (isDarkModeEnabled) {
        ThemeServices().switchTheme();
        Get.snackbar("Theme", "Dark mode activated",
            icon: Icon(Icons.nightlight_outlined));

        data.write('mode', isDarkModeEnabled);
      } else {
        ThemeServices().switchTheme();
        Get.snackbar("Theme", "Light mode activated",
            colorText: Colors.black, icon: Icon(Icons.sunny));
        data.write('mode', isDarkModeEnabled);
      }
    });
  }
}
