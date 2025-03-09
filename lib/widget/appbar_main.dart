import 'package:flutter/material.dart';
import 'package:flutter_movie/constants/custom_colors.dart';

class AppbarMain extends StatelessWidget {
  final TextTheme textTheme;
  final String title;

  const AppbarMain(this.textTheme, this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 100,
      floating: true,
      surfaceTintColor: CustomColors.colorBackground,
      backgroundColor: CustomColors.colorBackground,
      centerTitle: true,
      title: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        decoration: BoxDecoration(
          color: CustomColors.colorBackground,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: CustomColors.colorPrimary,
            width: 1,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'عاشفانه',
              style: textTheme.headlineMedium,
            ),
          ),
        ),
      ),
    );
  }
}
