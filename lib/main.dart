import 'package:e_commerce/controllers/cart_controller.dart';
import 'package:e_commerce/controllers/popular_product_controller.dart';
import 'package:e_commerce/controllers/recommeded_product_controller.dart';
import 'package:e_commerce/pages/auth/sign_in_page.dart';
import 'package:e_commerce/pages/auth/sign_up_page.dart';
import 'package:e_commerce/pages/splash/splash_page.dart';
import 'package:e_commerce/routes/route_helper.dart';
import 'package:e_commerce/services/theme_services.dart';
import 'package:e_commerce/ui/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'pages/home/main_food_page.dart';
import 'helper/dependencies.dart' as dep;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();

  await dep.int();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Get.find<CartController>().getCartData();
    return GetBuilder<PopularProductController>(
      builder: (_) {
        return GetBuilder<RecommendedProductController>(builder: (_) {
          return GetMaterialApp(
            // color: Get.isDarkMode ? context.theme.primaryColorLight : null,
            debugShowCheckedModeBanner: false,
            // // from DBest
            theme: Themes.light,
            darkTheme: Themes.dark,
            themeMode: ThemeServices().theme,

            //       //flutter plugin
            //        theme: ThemeData.light(),
            // darkTheme: ThemeData.dark().copyWith(
            //   appBarTheme: AppBarTheme(color: const Color(0xFF253341)),
            //   scaffoldBackgroundColor: const Color(0xFF15202B),
            // ),
            // themeMode: isDarkModeEnabled ? ThemeMode.dark : ThemeMode.light,
            title: 'Flutter Demo',
            // home: SignInPage(),
            // home: SplashScreen(),
            initialRoute: RouteHelper.getSplashPage(),
            getPages: RouteHelper.routes,
          );
        });
      },
    );
  }
}
