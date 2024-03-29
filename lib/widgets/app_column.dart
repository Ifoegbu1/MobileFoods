import 'package:e_commerce/utils/colors.dart';
import 'package:e_commerce/utils/dimensions.dart';
import 'package:e_commerce/widgets/big_text.dart';
import 'package:e_commerce/widgets/icon_and_text_widget.dart';
import 'package:e_commerce/widgets/small_text.dart';
import 'package:flutter/material.dart';

class AppColumn extends StatelessWidget {
  final String text;
  const AppColumn({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BigText(
          text: text,
          size: Dimensions.font26,
        ),
        SizedBox(height: Dimensions.height10),
        //comments section
        Row(
          children: [
            Wrap(
              children: List.generate(
                5,
                (index) {
                  return Icon(
                    Icons.star,
                    color: AppColors.mainColor,
                    size: Dimensions.iconSize15,
                  );
                },
              ),
            ),
            SizedBox(width: Dimensions.mainwidth10),
            const SmallText(text: "4.5"),
            SizedBox(width: Dimensions.mainwidth10),
            const SmallText(text: "1287"),
            SizedBox(width: Dimensions.mainwidth10),
            const SmallText(text: "comments"),
          ],
        ),
        SizedBox(height: Dimensions.height20),
        //time and distance
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children:  const[
            IconAndTextWidget(
              icon: Icons.circle_sharp,
              text: "Normal",
              iconColor: AppColors.iconColor1,
            ),
            IconAndTextWidget(
              icon: Icons.location_on,
              text: "1.7km",
              iconColor: AppColors.mainColor,
            ),
            IconAndTextWidget(
              icon: Icons.access_time_rounded,
              text: "32min",
              iconColor: AppColors.iconColor2,
            ),
          ],
        ),
      ],
    );
  }
}
