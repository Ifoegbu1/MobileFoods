import 'package:e_commerce/utils/dimensions.dart';
import 'package:flutter/material.dart';

class StaticText extends StatelessWidget {
 final Color? color;
  final String text;
 final double size;
  final TextOverflow overFlow;
  const StaticText({
    Key? key,
    this.color = const Color(0xFF332d2b),
    required this.text,
    this.size = 0,
    this.overFlow = TextOverflow.ellipsis,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: 1,
      overflow: overFlow,
      style: TextStyle(
        fontFamily: 'Roboto',
        color: color,
        fontWeight: FontWeight.w400,
        fontSize: size == 0 ? Dimensions.font20 : size,
      ),
    );
  }
}
