import 'dart:async';

import 'package:e_commerce/controllers/popular_product_controller.dart';
import 'package:e_commerce/controllers/recommeded_product_controller.dart';
import 'package:e_commerce/routes/route_helper.dart';
import 'package:e_commerce/utils/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;

  Future<void> _loadResources() async {
    await Get.find<PopularProductController>().getPopularProductList();
    await Get.find<RecommendedProductController>().getRecommendedProductList();
    // Get.find<CartController>();
  }

  @override
  void initState() {
    super.initState();
    _loadResources();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..forward();
    animation = CurvedAnimation(
      parent: controller,
      curve: Curves.linear,
    );
    Timer(
      const Duration(seconds: 3),
      () => Get.offNamed(RouteHelper.getInitial()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          Get.isDarkMode ? context.theme.primaryColorDark : Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ScaleTransition(
            scale: animation,
            child: Center(
              child: Image.asset(
                "assets/image/logo part 1.png",
                width: Dimensions.splashImg,
              ),
            ),
          ),
          Center(
            child: Image.asset(
              "assets/image/logo part 2.png",
              width: Dimensions.splashImg,
            ),
          ),
        ],
      ),
    );
  }
}
