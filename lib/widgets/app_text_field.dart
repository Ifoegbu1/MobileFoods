import 'package:e_commerce/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce/utils/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppTextField extends StatelessWidget {
  final TextEditingController textController;
  final String hintText;
  final IconData icon;
  final Color color;
  bool obscureText;
  final TextInputType keyboardType;
  AppTextField({
    Key? key,
    required this.textController,
    required this.hintText,
    required this.icon,
    required this.color,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: Dimensions.height20,
        right: Dimensions.height20,
      ),
      decoration: BoxDecoration(
        color: Get.isDarkMode ? context.theme.primaryColorDark : Colors.white,
        borderRadius: BorderRadius.circular(Dimensions.radius15),
        boxShadow: [
          BoxShadow(
            blurRadius: Dimensions.radius20 - 17,
            spreadRadius: Dimensions.radius15 - 14,
            offset: Offset(1, 1),
            color: Get.isDarkMode ? Colors.black : Colors.grey.withOpacity(0.2),
          ),
        ],
      ),
      child: TextField(
        keyboardType: keyboardType,
        controller: textController,
        obscureText: obscureText,
        decoration: InputDecoration(
          //hintText
          hintText: hintText,
          //prefixIcon
          prefixIcon: Icon(
            icon,
            color: color,
          ),
          //focusedBorder
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(Dimensions.radius15),
            borderSide: BorderSide(
              width: Dimensions.width10 / 10,
              color: Get.isDarkMode
                  ? AppColors.yellowColor
                  : AppColors.yellowColor,
            ),
          ),
          //enabledBorder
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(Dimensions.radius15),
            borderSide: BorderSide(
              width: Dimensions.width10 / 10,
              color: Get.isDarkMode
                  ? context.theme.primaryColorDark
                  : Colors.white,
            ),
          ),
          //border
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(Dimensions.radius15),
          ),
        ),
      ),
    );
  }
}
