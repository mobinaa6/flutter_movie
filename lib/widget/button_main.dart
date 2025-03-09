import 'package:flutter/material.dart';
import 'package:flutter_movie/constants/custom_colors.dart';

class ButtonMain extends StatelessWidget {
  ButtonMain({
    super.key,
    required this.textShow,
    required this.onTap,
  });

  String textShow;
  VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 60,
        width: double.infinity,
        margin: EdgeInsets.symmetric(horizontal: 40),
        decoration: BoxDecoration(
          border: Border.all(
            color: CustomColors.colorPrimary,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Text(
            '$textShow',
            style: textTheme.titleMedium,
          ),
        ),
      ),
    );
  }
}
