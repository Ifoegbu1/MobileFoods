import 'package:get/get.dart';

class Dimensions {
  static double screenHeight = Get.context!.height;
  static double screenWidth = Get.context!.width;

  static double pageView = screenHeight / 2.64;
  static double pageViewContainer = screenHeight / 3.84;
  static double pageViewTextContainer = screenHeight / 7.03;

//dynamic height; padding and margin
  static double height1_2 = screenHeight / 703.33;
  static double height10 = screenHeight / 84.4;
  static double height15 = screenHeight / 56.27;
  static double height20 = screenHeight / 42.2;
  static double height30 = screenHeight / 28.13;
  static double height40 = screenHeight / 21.1;
  static double height45 = screenHeight / 18.76;

//dynamic width; padding and margin
  static double width10 = screenHeight / 84.4;
  static double width15 = screenHeight / 56.27;
  static double width20 = screenHeight / 42.2;
  static double width30 = screenHeight / 28.13;

//dynamic width; SizedBox and Container
  static double mainwidth5 = screenWidth / 82.2;
  static double mainwidth10 = screenWidth / 41.1;
  static double mainwidth40 = screenWidth / 10.28;
  static double mainwidth411 = screenWidth / 1.00;

//font size
  static double font12 = screenHeight / 70.33;
  static double font16 = screenHeight / 52.75;
  static double font20 = screenHeight / 42.2;
  static double font26 = screenHeight / 32.46;

  //radius
  static double radius15 = screenHeight / 56.27;
  static double radius20 = screenHeight / 42.2;
  static double radius30 = screenHeight / 28.13;

  //icon size
  static double iconSize15 = screenHeight / 56.27;
  static double iconSize16 = screenHeight / 52.75;
  static double iconSize24 = screenHeight / 35.17;

  //list view size
  static double listViewImgSize120 = screenWidth / 3.25;
  static double listViewTextContSize100 = screenWidth / 3.90;

  //popular food
  static double popularFoodImgSize350 = screenHeight / 2.41;

  //bottom height
  static double bottomHeightBar = screenHeight / 7.03;
}
