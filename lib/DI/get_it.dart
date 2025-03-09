import 'package:dio/dio.dart';
import 'package:email_otp/email_otp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_movie/Features/Authenticaion/data/datasource/authentication_datasource.dart';
import 'package:flutter_movie/Features/Authenticaion/data/repository/auth_repository.dart';
import 'package:flutter_movie/Features/Home/bloc/home_bloc.dart';
import 'package:flutter_movie/Features/Home/data/datasource/local/advertisment_local_datasource.dart';
import 'package:flutter_movie/Features/Home/data/datasource/local/movei_banner_local_datasource.dart';
import 'package:flutter_movie/Features/Home/data/datasource/local/movei_local_datasource.dart';
import 'package:flutter_movie/Features/Home/data/datasource/remot/advertisment_datasource.dart';
import 'package:flutter_movie/Features/Home/data/datasource/remot/movie_banner_datasource.dart';
import 'package:flutter_movie/Features/Home/data/datasource/remot/movie_datasource.dart';
import 'package:flutter_movie/Features/Home/data/model/advertisment.dart';
import 'package:flutter_movie/Features/Home/data/repository/advertisment_repository.dart';
import 'package:flutter_movie/Features/Home/data/repository/movie_banner_respository.dart';
import 'package:flutter_movie/Features/Home/data/repository/movie_repository.dart';
import 'package:flutter_movie/Features/MovieDetial/bloc/movie_detail_bloc.dart';
import 'package:flutter_movie/Features/MovieDetial/data/datasource/movie_detail_datasource.dart';
import 'package:flutter_movie/Features/MovieDetial/data/datasource/movie_link_datasource.dart';
import 'package:flutter_movie/Features/MovieDetial/data/repository/movie_detail_repository.dart';
import 'package:flutter_movie/Features/MovieDetial/data/repository/movie_link_repository.dart';
import 'package:flutter_movie/Features/MovieList/bloc/movie_list_bloc.dart';
import 'package:flutter_movie/Features/MovieList/data/datasource/movie_list_datasource.dart';
import 'package:flutter_movie/Features/MovieList/data/repository/movie_list_repository.dart';
import 'package:flutter_movie/Features/WatchMovie/bloc/watch_movie_bloc.dart';
import 'package:flutter_movie/Features/category/data/datasource/category_datasource.dart';
import 'package:flutter_movie/Features/category/data/repository/category_repository.dart';
import 'package:flutter_movie/constants/string_constants.dart';
import 'package:flutter_movie/util/network_util/dio_provider.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

var locator = GetIt.instance;

Future<void> getInit() async {
  locator.registerSingleton<GetIt>(locator);
  locator.registerSingleton<SharedPreferences>(
      await SharedPreferences.getInstance());

  locator.registerSingleton<Dio>(DioProvider.create());
  locator.registerSingleton<EmailOTP>(EmailOTP());
  initHive();
  initRemotDatasource();
  initLocalDataSource();
  initRepository();
  initBloc();
}

void initRemotDatasource() {
  locator.registerSingleton<ICategoryDataSource>(CategoryRemotDataSource());
  locator
      .registerSingleton<IMovieBannerDataSource>(MoviBannerRemoteDataSource());

  locator.registerSingleton<IMovieDataSource>(MovieRemotDataSource());
  locator
      .registerSingleton<IAdverismentDataSource>(AdvertismentRemotDataSource());

  locator.registerSingleton<IMovieListDataSource>(MovieListRemotDataSource());

  locator.registerSingleton<IAuthDatasource>(AuthRemmotDatasource());
  locator.registerSingleton<IMovieDetailDataSource>(MovieDetailDataSource());

  locator.registerSingleton<IMovieLinkDataSource>(MovieLinkRemotDataSource());
}

void initHive() {
  locator.registerSingleton<Box<Advertisment>>(
      Hive.box<Advertisment>(ADVERTISMENT_BOX));
}

void initLocalDataSource() {
  locator.registerSingleton<IAdvertismentLocalDataSource>(
      AdvertismentLocalDataSource());

  locator.registerSingleton<IMovieBannerLocalDataSource>(
      MovieBannerLocalDatasource());

  locator.registerSingleton<IMovieLocalDatasource>(MovieLocalDataSource());
}

void initRepository() {
  locator.registerSingleton<ICategoryRepository>(CategoryRepository());
  locator.registerSingleton<IMovieBannerRepository>(MovieBannerRepository());
  locator.registerSingleton<IMovieRepository>(MovieRepository());
  locator.registerSingleton<IAdverismentRepository>(AdvertismentRepository());
  locator.registerSingleton<IMovieListRepository>(MovieListRepository());
  locator.registerSingleton<iAuthRepository>(AuthRepository());
  locator.registerSingleton<IMovieDetailRepository>(MovieDetailRepository());
  locator.registerSingleton<IMovieLinkRepository>(MovieLinkRepository());
}

void initBloc() {
  locator.registerSingleton<HomeBloc>(
    HomeBloc(
      locator.get(),
      locator.get(),
      locator.get(),
    ),
  );

  locator.registerSingleton<MovieDetailBLoc>(
      MovieDetailBLoc(locator.get(), locator.get()));

  locator.registerSingleton<MovieListBLoc>(MovieListBLoc(locator.get()));

  locator.registerSingleton<WatchMovieBloc>(WatchMovieBloc(locator.get()));
}
