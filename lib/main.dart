import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_movie/DI/get_it.dart';
import 'package:flutter_movie/Features/Home/bloc/home_bloc.dart';
import 'package:flutter_movie/Features/Home/data/model/advertisment.dart';
import 'package:flutter_movie/Features/Home/data/model/movie.dart';
import 'package:flutter_movie/Features/Home/view/home_screen.dart';
import 'package:flutter_movie/constants/custom_colors.dart';
import 'package:flutter_movie/constants/string_constants.dart';
import 'package:flutter_movie/gen/fonts.gen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await Hive.initFlutter();
  WidgetsFlutterBinding.ensureInitialized();
  Hive.registerAdapter(
      AdvertismentAdapter());
  await Hive.openBox<Advertisment>(
      ADVERTISMENT_BOX);
  Hive.registerAdapter<Movie>(
      MovieAdapter());
  await Hive.openBox<Movie>(
      MOVIE_BANNER_BOX);
  await Hive.openBox<Movie>(
      MOVIE_ACTION_GENRE_BOX);
  await Hive.openBox<Movie>(
      MOVIE_ROMANCE_GENRE_BOX);
  await Hive.openBox<Movie>(
      MOVIE_CRIMINAL_GENRE_BOX);
  await Hive.openBox<Movie>(
      MOVIE_HORROR_GENRE_BOX);
  await Hive.openBox<Movie>(MOVIE_ANIME_BOX);
  await Hive.openBox<Movie>(
      MOVIE_CARTOON_BOX);
  await getInit();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
        statusBarColor:
            CustomColors.colorBackground,
        statusBarIconBrightness:
            Brightness.light),
  );
  runApp(const Application());
}

class Application extends StatelessWidget {
  const Application({super.key});

  @override
  Widget build(BuildContext context) {
    final GetIt getIt = locator.get();
    return ScreenUtilInit(
      minTextAdapt: true,
      designSize:
          MediaQuery.of(context).size,
      splitScreenMode: true,
      builder: (_, child) {
        return MaterialApp(
          builder: (context, child) {
            getIt.registerSingleton<
                    ThemeData>(
                Theme.of(context));
            return SafeArea(child: child!);
          },
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            inputDecorationTheme:
                InputDecorationTheme(
              errorBorder:
                  OutlineInputBorder(
                borderSide: const BorderSide(
                  color: CustomColors
                      .colorTabIndicator,
                ),
                borderRadius:
                    BorderRadius.circular(
                        12),
              ),
              enabledBorder:
                  OutlineInputBorder(
                borderSide: const BorderSide(
                  color: CustomColors
                      .colorBlack,
                ),
                borderRadius:
                    BorderRadius.circular(
                        12),
              ),
              focusedBorder:
                  OutlineInputBorder(
                borderSide: const BorderSide(
                  color: CustomColors
                      .colorBlueLink,
                ),
                borderRadius:
                    BorderRadius.circular(
                        12),
              ),
            ),
            scaffoldBackgroundColor:
                CustomColors.colorBackground,
            primaryColor:
                CustomColors.colorPrimary,
            textTheme: TextTheme(
              headlineMedium: TextStyle(
                fontFamily: FontFamily.su,
                color: CustomColors
                    .colorPrimary,
                fontSize: 24.sp,
              ),
              labelLarge: const TextStyle(
                fontSize: 10,
                color: CustomColors
                    .colorPrimary,
              ),
              titleLarge: TextStyle(
                fontFamily: FontFamily.sr,
                color: Colors.white,
                fontSize: 20.sp,
              ),
              titleMedium: TextStyle(
                  color: CustomColors
                      .colorPrimary,
                  fontSize: 16.sp,
                  fontFamily: 'su'),
              titleSmall: TextStyle(
                fontSize: 14.sp,
                color: CustomColors
                    .colorYellowRating,
                fontFamily: 'sr',
              ),
            ),
          ),
          home: BlocProvider<HomeBloc>(
            create: (context) =>
                locator.get<HomeBloc>(),
            child: const HomeScreen(),
          ),
        );
      },
    );
  }
}
