import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_movie/DI/get_it.dart';
import 'package:flutter_movie/Features/Authenticaion/bloc/auth_bloc.dart';
import 'package:flutter_movie/Features/Authenticaion/bloc/auth_event.dart';
import 'package:flutter_movie/Features/Authenticaion/bloc/auth_state.dart';
import 'package:flutter_movie/constants/custom_colors.dart';
import 'package:flutter_movie/gen/assets.gen.dart';
import 'package:flutter_movie/widget/button_main.dart';
import 'package:flutter_movie/widget/toast.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    TextEditingController usernameController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    return SafeArea(
      child: Scaffold(
          backgroundColor: CustomColors.colorBackground,
          body: BlocConsumer<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is AuthRequestSuccessState) {
                return state.response
                    .fold((l) => showToast(l), (r) => showToast(r));
              }
            },
            builder: (context, state) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    Center(child: Assets.images.imgLogin.image()),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      'ورود',
                      style: themeData.textTheme.headlineMedium,
                    ),
                    const SizedBox(
                      height: 100,
                    ),
                    TextFieldUserName(
                      themeData: themeData,
                      usernameController: usernameController,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFiledPassword(
                      themeData: themeData,
                      passwordController: passwordController,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      'رمزتان را فراموش کرده اید؟',
                      style: themeData.textTheme.titleSmall!.apply(
                        color: CustomColors.colorPrimary.withOpacity(.5),
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    if (state is AuthInitState) ...{
                      ButtonMain(
                        textShow: 'ورود',
                        onTap: () async {
                          if (usernameController.text.isNotEmpty &&
                              passwordController.text.isNotEmpty) {
                            if (passwordController.text.length >= 8) {
                              context.read<AuthBloc>().add(
                                  AuthRequestLoginEvent(
                                      usernameController.text.trim(),
                                      passwordController.text.trim()));
                            } else {
                              showToast('تعداد کاراکتر های وارد شده کم است');
                            }
                          } else {
                            showToast('لطفا همه مقادبر را پر کنید');
                          }
                        },
                      )
                    },
                    if (state is AuthLoadingState ||
                        state is AuthRequestSuccessState) ...{
                      ButtonMain(
                        textShow: '...در حال ورود',
                        onTap: () async {},
                      )
                    }
                  ],
                ),
              );
            },
          )),
    );
  }
}

class TextFiledPassword extends StatelessWidget {
  const TextFiledPassword({
    super.key,
    required this.themeData,
    required this.passwordController,
  });

  final ThemeData themeData;
  final TextEditingController passwordController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextField(
        controller: passwordController,
        style: themeData.textTheme.titleSmall!
            .apply(color: CustomColors.colorOnPrimary),
        decoration: InputDecoration(
          prefixIcon: const Icon(
            Icons.lock,
            color: CustomColors.colorPrimary,
            size: 20,
          ),
          labelText: 'password ',
          labelStyle: const TextStyle(color: CustomColors.colorOnPrimary),
          enabledBorder: themeData.inputDecorationTheme.enabledBorder,
          focusedBorder: themeData.inputDecorationTheme.focusedBorder,
        ),
      ),
    );
  }
}

class TextFieldUserName extends StatelessWidget {
  const TextFieldUserName(
      {super.key, required this.themeData, required this.usernameController});

  final ThemeData themeData;

  final TextEditingController usernameController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextField(
        controller: usernameController,
        keyboardType: TextInputType.name,
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp("[a-zA-Z]"))
        ],
        style: themeData.textTheme.titleSmall!
            .apply(color: CustomColors.colorOnPrimary),
        decoration: InputDecoration(
          prefixIcon: Assets.images.icUsrename.image(
            color: CustomColors.colorOnPrimary,
          ),
          labelText: 'username',
          labelStyle: TextStyle(color: CustomColors.colorOnPrimary),
          enabledBorder: themeData.inputDecorationTheme.enabledBorder,
          focusedBorder: themeData.inputDecorationTheme.focusedBorder,
        ),
      ),
    );
  }
}
