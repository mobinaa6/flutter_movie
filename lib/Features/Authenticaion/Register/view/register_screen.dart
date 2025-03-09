// ignore_for_file: use_build_context_synchronously

import 'package:email_otp/email_otp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_movie/DI/get_it.dart';
import 'package:flutter_movie/Features/Authenticaion/bloc/auth_bloc.dart';
import 'package:flutter_movie/Features/Authenticaion/bloc/auth_event.dart';
import 'package:flutter_movie/Features/Authenticaion/bloc/auth_state.dart';
import 'package:flutter_movie/Features/Authenticaion/data/model/user.dart';
import 'package:flutter_movie/constants/custom_colors.dart';
import 'package:flutter_movie/gen/assets.gen.dart';
import 'package:flutter_movie/widget/button_main.dart';
import 'package:flutter_movie/widget/toast.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

EmailOTP myAuth = locator.get();

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordConfirmController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController emailOTPController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return SafeArea(
      child: Scaffold(
          backgroundColor: CustomColors.colorBackground,
          body: BlocListener<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is AuthRequestSuccessState) {
                return state.response
                    .fold((l) => showToast(l), (r) => showToast(r));
              }
            },
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Center(child: Assets.images.imgRegister.image()),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'ثبت نام',
                    style: themeData.textTheme.headlineMedium,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextFieldUserName(
                      themeData: themeData,
                      usernmaeController: usernameController),
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
                  TextFiledPasswordConfirm(
                    themeData: themeData,
                    passwordConfirmController: passwordConfirmController,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextfiledEmail(
                      emailController: emailController, themeData: themeData),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFiledEmailOTP(
                      emailOTPController: emailOTPController,
                      themeData: themeData,
                      emailController: emailController),
                  const SizedBox(
                    height: 50,
                  ),
                  ButtonMain(
                    textShow: 'ثبت نام',
                    onTap: () async {
                      if (usernameController.text.isNotEmpty &&
                          passwordController.text.isNotEmpty &&
                          passwordConfirmController.text.isNotEmpty &&
                          emailController.text.isNotEmpty) {
                        if (passwordController.text.length >= 8 &&
                            passwordConfirmController.text.length >= 8) {
                          if (passwordController.text.trim() ==
                              passwordConfirmController.text.trim()) {
                            var user = User(
                                usernameController.text.trim(),
                                passwordController.text.trim(),
                                passwordConfirmController.text.trim(),
                                emailController.text.trim());
                            if (await myAuth.verifyOTP(
                                    otp: emailOTPController.text) ==
                                true) {
                              context
                                  .read<AuthBloc>()
                                  .add(AuthRequestRegisterEvent(user));
                            } else {
                              showToast('کد وارد شده اشتباه است');
                            }
                          } else {
                            showToast('رمز های وارد شده مانند مشابه نیستند');
                          }
                        } else {
                          showToast('لطفا برای رمز 8 کاراکتر را وارد کنید');
                        }
                      } else {
                        showToast('لطفا همه مقادیر را پر کنید');
                      }
                    },
                  ),
                ],
              ),
            ),
          )),
    );
  }
}

class TextFiledEmailOTP extends StatelessWidget {
  const TextFiledEmailOTP({
    super.key,
    required this.emailOTPController,
    required this.themeData,
    required this.emailController,
  });

  final TextEditingController emailOTPController;
  final ThemeData themeData;
  final TextEditingController emailController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextField(
        keyboardType: TextInputType.number,
        controller: emailOTPController,
        style: themeData.textTheme.titleSmall!
            .apply(color: CustomColors.colorPrimary),
        maxLength: 5,
        decoration: InputDecoration(
          enabledBorder: themeData.inputDecorationTheme.enabledBorder,
          focusedBorder: themeData.inputDecorationTheme.focusedBorder,
          labelText: 'کد ',
          labelStyle: themeData.textTheme.titleSmall!
              .apply(color: CustomColors.colorPrimary),
          suffixIcon: TextButton(
              onPressed: () async {
                await myAuth.setConfig(
                    appEmail: "mobin.ahmadiaa6@gmail.com",
                    appName: "aio movie",
                    userEmail: emailController.text.trim(),
                    otpLength: 5,
                    otpType: OTPType.digitsOnly);
                if (await myAuth.sendOTP() == true) {
                  showToast('کد به ایمیل شما فرستاده شد');
                } else {
                  showToast('فرمت ایمیل وارد شده اشتباه است');
                }
              },
              child: Text(
                'ارسال کد',
                style: themeData.textTheme.titleSmall!
                    .apply(color: CustomColors.colorPrimary),
              )),
        ),
      ),
    );
  }
}

class TextfiledEmail extends StatelessWidget {
  const TextfiledEmail({
    super.key,
    required this.emailController,
    required this.themeData,
  });

  final TextEditingController? emailController;
  final ThemeData themeData;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextField(
        controller: emailController,
        onChanged: (value) {},
        keyboardType: TextInputType.emailAddress,
        style: themeData.textTheme.titleSmall!
            .apply(color: CustomColors.colorOnPrimary),
        decoration: InputDecoration(
          prefixIcon: const Icon(
            Icons.email,
            color: CustomColors.colorPrimary,
            size: 20,
          ),
          labelText: 'Email',
          labelStyle: const TextStyle(
            color: CustomColors.colorOnPrimary,
          ),
          enabledBorder: themeData.inputDecorationTheme.enabledBorder,
          focusedBorder: themeData.inputDecorationTheme.focusedBorder,
        ),
      ),
    );
  }
}

class TextFiledPassword extends StatefulWidget {
  const TextFiledPassword({
    super.key,
    required this.themeData,
    this.passwordController,
  });

  final ThemeData themeData;
  final TextEditingController? passwordController;

  @override
  State<TextFiledPassword> createState() => _TextFiledPasswordState();
}

class _TextFiledPasswordState extends State<TextFiledPassword> {
  bool isType = false;
  bool isShowNumber = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextField(
        controller: widget.passwordController,
        textInputAction: TextInputAction.next,
        style: widget.themeData.textTheme.titleSmall!
            .apply(color: CustomColors.colorOnPrimary),
        obscuringCharacter: '*',
        obscureText: isShowNumber,
        decoration: InputDecoration(
          errorBorder: widget.themeData.inputDecorationTheme.errorBorder,
          error: isType
              ? widget.passwordController!.text.length < 8
                  ? Text(
                      'حداقل 8 کاراکتر را وارد کنید',
                      style: widget.themeData.textTheme.titleSmall!.apply(
                        color: CustomColors.colorTabIndicator,
                      ),
                    )
                  : null
              : null,
          suffixIcon: isShowNumber
              ? GestureDetector(
                  onTap: () {
                    setState(() {
                      isShowNumber = !isShowNumber;
                    });
                  },
                  child: Assets.images.iconShowNumber
                      .image(color: CustomColors.colorPrimary),
                )
              : GestureDetector(
                  onTap: () {
                    setState(() {
                      isShowNumber = !isShowNumber;
                    });
                  },
                  child: Assets.images.iconHideNumber
                      .image(color: CustomColors.colorPrimary),
                ),
          prefixIcon: const Icon(
            Icons.lock,
            color: CustomColors.colorPrimary,
            size: 20,
          ),
          labelText: 'password ',
          labelStyle: const TextStyle(color: CustomColors.colorOnPrimary),
          enabledBorder: widget.themeData.inputDecorationTheme.enabledBorder,
          focusedBorder: widget.themeData.inputDecorationTheme.focusedBorder,
        ),
        onChanged: (value) {
          setState(() {
            isType = true;
          });
        },
      ),
    );
  }
}

class TextFiledPasswordConfirm extends StatefulWidget {
  const TextFiledPasswordConfirm(
      {super.key, required this.themeData, this.passwordConfirmController});

  final ThemeData themeData;
  final TextEditingController? passwordConfirmController;

  @override
  State<TextFiledPasswordConfirm> createState() =>
      _TextFiledPasswordConfirmState();
}

class _TextFiledPasswordConfirmState extends State<TextFiledPasswordConfirm> {
  bool isShowNumber = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextField(
        controller: widget.passwordConfirmController,
        textInputAction: TextInputAction.next,
        obscureText: isShowNumber,
        obscuringCharacter: '*',
        style: widget.themeData.textTheme.titleSmall!
            .apply(color: CustomColors.colorOnPrimary),
        decoration: InputDecoration(
          suffixIcon: isShowNumber
              ? GestureDetector(
                  onTap: () {
                    setState(() {
                      isShowNumber = !isShowNumber;
                    });
                  },
                  child: Assets.images.iconShowNumber
                      .image(color: CustomColors.colorPrimary),
                )
              : GestureDetector(
                  onTap: () {
                    setState(() {
                      isShowNumber = !isShowNumber;
                    });
                  },
                  child: Assets.images.iconHideNumber.image(
                    color: CustomColors.colorPrimary,
                  ),
                ),
          prefixIcon: const Icon(
            Icons.lock,
            color: CustomColors.colorPrimary,
            size: 20,
          ),
          labelText: 'password confirm ',
          labelStyle: const TextStyle(color: CustomColors.colorOnPrimary),
          enabledBorder: widget.themeData.inputDecorationTheme.enabledBorder,
          focusedBorder: widget.themeData.inputDecorationTheme.focusedBorder,
        ),
      ),
    );
  }
}

class TextFieldUserName extends StatelessWidget {
  TextFieldUserName({
    super.key,
    required this.themeData,
    this.usernmaeController,
  });

  final ThemeData themeData;
  final TextEditingController? usernmaeController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextField(
        controller: usernmaeController,
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.name,
        style: themeData.textTheme.titleSmall!
            .apply(color: CustomColors.colorOnPrimary),
        decoration: InputDecoration(
          prefixIcon: Assets.images.icUsrename.image(
            color: CustomColors.colorOnPrimary,
          ),
          labelText: 'username',
          labelStyle: const TextStyle(color: CustomColors.colorOnPrimary),
          enabledBorder: themeData.inputDecorationTheme.enabledBorder,
          focusedBorder: themeData.inputDecorationTheme.focusedBorder,
        ),
      ),
    );
  }
}
