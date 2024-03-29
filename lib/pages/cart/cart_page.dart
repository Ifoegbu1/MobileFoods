import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce/base/no_data_page.dart';
import 'package:e_commerce/controllers/auth_controller.dart';
import 'package:e_commerce/controllers/cart_controller.dart';
import 'package:e_commerce/controllers/popular_product_controller.dart';
import 'package:e_commerce/controllers/recommeded_product_controller.dart';
import 'package:e_commerce/routes/route_helper.dart';
import 'package:e_commerce/utils/app_constants.dart';
import 'package:e_commerce/utils/colors.dart';
import 'package:e_commerce/utils/dimensions.dart';
import 'package:e_commerce/widgets/app_icon.dart';
import 'package:e_commerce/widgets/big_text.dart';
import 'package:e_commerce/widgets/small_text.dart';
import 'package:e_commerce/widgets/static_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  final bool isClicked = true;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (isClicked) {
          Transition.fadeIn;
          Get.forceAppUpdate();
          Get.back();
        }
        return false;
      },
      child: Scaffold(
        body: Stack(
          children: [
            //topBar icons
            Positioned(
              left: Dimensions.width20,
              right: Dimensions.width20,
              top: Dimensions.height20 * 3,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      Transition.fadeIn;
                      Get.forceAppUpdate();
                      Get.back();
                    },
                    child: AppIcon(
                      icon: Icons.arrow_back_ios,
                      iconColor: Colors.white,
                      backgroundColor: AppColors.mainColor,
                      iconSize: Dimensions.iconSize24,
                    ),
                  ),
                  SizedBox(width: Dimensions.width20 * 5),
                  InkWell(
                    onTap: () {
                      Get.toNamed(RouteHelper.getInitial());
                    },
                    child: AppIcon(
                      icon: Icons.home_outlined,
                      iconColor: Colors.white,
                      backgroundColor: AppColors.mainColor,
                      iconSize: Dimensions.iconSize24,
                    ),
                  ),
                  AppIcon(
                    icon: Icons.shopping_cart,
                    iconColor: Colors.white,
                    backgroundColor: AppColors.mainColor,
                    iconSize: Dimensions.iconSize24,
                  ),
                ],
              ),
            ),

            //body
            GetBuilder<CartController>(builder: (_cartController) {
              return _cartController.getItems.isNotEmpty
                  ? Positioned(
                      top: Dimensions.height20 * 5,
                      left: Dimensions.width20,
                      right: Dimensions.width20,
                      bottom: 0,
                      child: Container(
                        margin: EdgeInsets.only(top: Dimensions.height15),
                        // color: Colors.red,
                        child: MediaQuery.removePadding(
                            context: context,
                            removeTop: true,
                            child: GetBuilder<CartController>(
                              builder: (cartController) {
                                var _cartList = cartController.getItems;
                                return ListView.builder(
                                  itemCount: _cartList.length,
                                  itemBuilder: (_, index) {
                                    return SizedBox(
                                      height: Dimensions.height20 * 5,
                                      width: double.maxFinite,
                                      child: Row(
                                        children: [
                                          //image container
                                          InkWell(
                                            onTap: () {
                                              var popularIndex = Get.find<
                                                      PopularProductController>()
                                                  .popularProductList
                                                  .indexOf(_cartList[index]
                                                      .product!);
                                              if (popularIndex >= 0) {
                                                Get.toNamed(
                                                    RouteHelper.getPopularFood(
                                                        popularIndex,
                                                        "cartPage"));
                                              } else {
                                                var recommendedIndex = Get.find<
                                                        RecommendedProductController>()
                                                    .recommendedProductList
                                                    .indexOf(_cartList[index]
                                                        .product!);
                                                if (recommendedIndex < 0) {
                                                  Get.snackbar(
                                                    "Cart History Products",
                                                    "Product review is not available for cart history products",
                                                    backgroundColor:
                                                        AppColors.mainColor,
                                                    colorText: Colors.white,
                                                  );
                                                } else {
                                                  Get.toNamed(RouteHelper
                                                      .getRecommendedFood(
                                                          recommendedIndex,
                                                          "cartPage"));
                                                }
                                              }
                                            },
                                            child: Container(
                                              width: Dimensions.height20 * 5,
                                              height: Dimensions.height20 * 5,
                                              margin: EdgeInsets.only(
                                                  bottom: Dimensions.height10),
                                              decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                    fit: BoxFit.cover,
                                                    image:
                                                        CachedNetworkImageProvider(
                                                            AppConstants
                                                                    .CLOUD_URL +
                                                                _cartList[index]
                                                                    .img!),
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          Dimensions.radius20),
                                                  color: Colors.white),
                                            ),
                                          ),
                                          SizedBox(width: Dimensions.width10),
                                          //text and price container
                                          Expanded(
                                            child: SizedBox(
                                              height: Dimensions.height20 * 5,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  BigText(
                                                    text:
                                                        _cartList[index].name!,
                                                    color: Colors.black54,
                                                  ),
                                                  const SmallText(
                                                      text: "Spicy"),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      StaticText(
                                                        text: _cartList[index]
                                                            .price
                                                            .toString(),
                                                        color: Colors.redAccent,
                                                      ),
                                                      Container(
                                                        padding:
                                                            EdgeInsets.only(
                                                          top: Dimensions
                                                              .height10,
                                                          bottom: Dimensions
                                                              .height10,
                                                          left: Dimensions
                                                              .width10,
                                                          right: Dimensions
                                                              .width10,
                                                        ),
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                  Dimensions
                                                                      .radius20),
                                                          color: Get.isDarkMode
                                                              ? Colors.black12
                                                              : Colors.white,
                                                        ),
                                                        child: Row(
                                                          children: [
                                                            InkWell(
                                                              onTap: () {
                                                                cartController.addItem(
                                                                    _cartList[
                                                                            index]
                                                                        .product!,
                                                                    -1);
                                                              },
                                                              child: const Icon(
                                                                Icons.remove,
                                                                color: AppColors
                                                                    .signColor,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                                width: Dimensions
                                                                        .width10 /
                                                                    2),
                                                            BigText(
                                                                text: _cartList[
                                                                        index]
                                                                    .quantity
                                                                    .toString()), //popularProductControl.inCartItems.toString() ),
                                                            SizedBox(
                                                                width: Dimensions
                                                                        .width10 /
                                                                    2),
                                                            InkWell(
                                                              onTap: () {
                                                                cartController.addItem(
                                                                    _cartList[
                                                                            index]
                                                                        .product!,
                                                                    1);
                                                              },
                                                              child: const Icon(
                                                                Icons.add,
                                                                color: AppColors
                                                                    .signColor,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                );
                              },
                            )),
                      ),
                    )
                  : const NoDataPage(
                      text: "Your cart is empty!",
                    );
            })
          ],
        ),
        bottomNavigationBar: GetBuilder<CartController>(
          builder: (cartController) {
            return Container(
              height: Dimensions.bottomHeightBar,
              padding: EdgeInsets.only(
                  top: Dimensions.height30,
                  bottom: Dimensions.height30,
                  left: Dimensions.width20,
                  right: Dimensions.width20),
              decoration: BoxDecoration(
                color: Get.isDarkMode
                    ? Colors.black26
                    : AppColors.buttonBackgroundColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(Dimensions.radius20 * 2),
                  topRight: Radius.circular(Dimensions.radius20 * 2),
                ),
              ),
              child: cartController.getItems.isNotEmpty
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // +/- container
                        Container(
                          padding: EdgeInsets.only(
                            top: Dimensions.height20,
                            bottom: Dimensions.height20,
                            left: Dimensions.width20,
                            right: Dimensions.width20,
                          ),
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(Dimensions.radius20),
                              color: Get.isDarkMode
                                  ? Colors.black12
                                  : Colors.white),
                          child: Row(
                            children: [
                              SizedBox(width: Dimensions.width10 / 2),
                              BigText(
                                  text: "₦" +
                                      cartController.totalAmount.toString()),
                              SizedBox(width: Dimensions.width10 / 2),
                            ],
                          ),
                        ),

                        //check-out container
                        InkWell(
                          onTap: () {
                            if (Get.find<AuthController>().userLoggedIn()) {
                              cartController.addToHistory();
                            } else {
                              Get.toNamed(RouteHelper.getSignInPage());
                            }
                          },
                          child: Container(
                            padding: EdgeInsets.only(
                              top: Dimensions.height20,
                              bottom: Dimensions.height20,
                              left: Dimensions.width20,
                              right: Dimensions.width20,
                            ),
                            child: const BigText(
                              text: "Check out",
                              color: Colors.white,
                            ),
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(Dimensions.radius20),
                              color: AppColors.mainColor,
                            ),
                          ),
                        ),
                      ],
                    )
                  : Container(),
            );
          },
        ),
      ),
    );
  }
}
