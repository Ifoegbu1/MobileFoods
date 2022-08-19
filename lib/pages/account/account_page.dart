import 'package:e_commerce/base/custom_loader.dart';
import 'package:e_commerce/controllers/auth_controller.dart';
import 'package:e_commerce/controllers/cart_controller.dart';
import 'package:e_commerce/controllers/user_controller.dart';
import 'package:e_commerce/routes/route_helper.dart';
import 'package:e_commerce/utils/colors.dart';
import 'package:e_commerce/utils/dimensions.dart';
import 'package:e_commerce/widgets/account_widget.dart';
import 'package:e_commerce/widgets/app_icon.dart';
import 'package:e_commerce/widgets/big_text.dart';
import 'package:e_commerce/widgets/static_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool _userLoggedIn = Get.find<AuthController>().userLoggedIn();
    if (_userLoggedIn) {
      Get.find<UserController>().getUserInfo();
    }
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.mainColor,
          title: Padding(
            padding: const EdgeInsets.only(right: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                StaticText(
                  text: "Profile",
                  size: Dimensions.height20 + 4,
                  color: Get.isDarkMode
                      ? Colors.black.withAlpha(190)
                      : Colors.white,
                ),
              ],
            ),
          ),
        ),
        body: GetBuilder<UserController>(
          builder: (controller) {
            return _userLoggedIn
                ? (controller.isLoading
                    ? Container(
                        margin: EdgeInsets.only(top: Dimensions.height20),
                        width: double.maxFinite,
                        child: Column(
                          children: [
                            //profile icon
                            AppIcon(
                              icon: Icons.person,
                              backgroundColor: AppColors.mainColor,
                              iconColor: Colors.white,
                              iconSize: Dimensions.iconSize20 * 3.75,
                              size: Dimensions.height20 * 7.5,
                            ),
                            SizedBox(height: Dimensions.height30),
                            Expanded(
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    //name
                                    AccountWidget(
                                      appIcon: AppIcon(
                                        icon: Icons.person,
                                        backgroundColor: AppColors.mainColor,
                                        iconColor: Colors.white,
                                        iconSize: Dimensions.iconSize24 + 1,
                                        size: Dimensions.height45 + 5,
                                      ),
                                      bigText: BigText(
                                          text: controller.userModel.name),
                                    ),
                                    SizedBox(height: Dimensions.height20),
                                    //phone
                                    AccountWidget(
                                      appIcon: AppIcon(
                                        icon: Icons.phone,
                                        backgroundColor: AppColors.yellowColor,
                                        iconColor: Colors.white,
                                        iconSize: Dimensions.iconSize24 + 1,
                                        size: Dimensions.height45 + 5,
                                      ),
                                      bigText: BigText(
                                          text: controller.userModel.phone),
                                    ),
                                    SizedBox(height: Dimensions.height20),
                                    //email
                                    AccountWidget(
                                      appIcon: AppIcon(
                                        icon: Icons.email,
                                        backgroundColor: AppColors.yellowColor,
                                        iconColor: Colors.white,
                                        iconSize: Dimensions.iconSize24 + 1,
                                        size: Dimensions.height45 + 5,
                                      ),
                                      bigText: BigText(
                                          text: controller.userModel.email),
                                    ),
                                    SizedBox(height: Dimensions.height20),
                                    //address
                                    AccountWidget(
                                      appIcon: AppIcon(
                                        icon: Icons.location_on,
                                        backgroundColor: AppColors.yellowColor,
                                        iconColor: Colors.white,
                                        iconSize: Dimensions.iconSize24 + 1,
                                        size: Dimensions.height45 + 5,
                                      ),
                                      bigText:
                                          BigText(text: "Choba Port Harcourt"),
                                    ),
                                    SizedBox(height: Dimensions.height20),
                                    //messages
                                    AccountWidget(
                                      appIcon: AppIcon(
                                        icon: Icons.message_rounded,
                                        backgroundColor: Colors.redAccent,
                                        iconColor: Colors.white,
                                        iconSize: Dimensions.iconSize24 + 1,
                                        size: Dimensions.height45 + 5,
                                      ),
                                      bigText: BigText(text: "Messages"),
                                    ),
                                    SizedBox(height: Dimensions.height20),
                                    //logout
                                    GestureDetector(
                                      onTap: () {
                                        if (Get.find<AuthController>()
                                            .userLoggedIn()) {
                                          Get.find<AuthController>()
                                              .clearSharedData();
                                          Get.find<CartController>().clear();
                                          Get.find<CartController>()
                                              .clearCartHistory();
                                          Get.offNamed(
                                              RouteHelper.getSignInPage());
                                        }
                                      },
                                      child: AccountWidget(
                                        appIcon: AppIcon(
                                          icon: Icons.logout,
                                          backgroundColor: Colors.redAccent,
                                          iconColor: Colors.white,
                                          iconSize: Dimensions.iconSize24 + 1,
                                          size: Dimensions.height45 + 5,
                                        ),
                                        bigText: BigText(text: "Logout"),
                                      ),
                                    ),
                                    SizedBox(height: Dimensions.height20),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    : CustomLoader())
                : Container(
                    child: Center(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: double.maxFinite,
                          height: Dimensions.height20 * 8,
                          margin: EdgeInsets.only(
                              left: Dimensions.width20,
                              right: Dimensions.width20),
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(Dimensions.radius20),
                              image: DecorationImage(
                                invertColors: false,
                                fit: BoxFit.cover,
                                image: AssetImage(
                                    "assets/image/signintocontinue.png"),
                              )),
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.toNamed(RouteHelper.getSignInPage());
                          },
                          child: Container(
                            width: double.maxFinite,
                            height: Dimensions.height20 * 5,
                            margin: EdgeInsets.only(
                                left: Dimensions.width20,
                                right: Dimensions.width20),
                            decoration: BoxDecoration(
                              color: AppColors.mainColor,
                              borderRadius:
                                  BorderRadius.circular(Dimensions.radius20),
                            ),
                            child: Center(
                                child: BigText(
                              text: "Sign In",
                              color: Colors.white,
                              size: Dimensions.font20,
                            )),
                          ),
                        ),
                      ],
                    )),
                  );
          },
        ));
  }
}
