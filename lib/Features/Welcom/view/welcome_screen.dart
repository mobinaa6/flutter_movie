import 'package:flutter/material.dart';
import 'package:flutter_movie/DI/get_it.dart';
import 'package:flutter_movie/constants/custom_colors.dart';
import 'package:flutter_movie/gen/assets.gen.dart';
import 'package:flutter_movie/widget/button_main.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Scaffold(
        backgroundColor: CustomColors.colorBackground,
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 200,
              ),
              Center(child: Assets.images.imgWelcom.image()),
              const SizedBox(
                height: 20,
              ),
              Text(
                'Welcom',
                style: textTheme.headlineMedium,
              ),
              Text(
                'با ایو مووی انواع فیلم ها را ببینید و لذت ببرید',
                style: textTheme.titleMedium!.apply(
                  color: Colors.grey,
                ),
              ),
              const SizedBox(
                height: 150,
              ),
              ButtonMain(
                textShow: 'SIGN IN',
                onTap: () {},
              ),
              const SizedBox(
                height: 20,
              ),
              ButtonMain(
                textShow: 'SIGN UP',
                onTap: () {},
              ),
              Text(
                'بعدا ثبت نام میکنم',
                style: textTheme.titleMedium!.apply(
                  color: CustomColors.colorPrimary,
                  decoration: TextDecoration.underline,
                  decorationColor: CustomColors.colorOnPrimary,
                ),
              ),
            ],
          ),
        ));
  }
}
