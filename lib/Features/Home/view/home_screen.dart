import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_movie/DI/get_it.dart';
import 'package:flutter_movie/Features/Home/bloc/home_bloc.dart';
import 'package:flutter_movie/Features/Home/bloc/home_event.dart';
import 'package:flutter_movie/Features/Home/bloc/home_state.dart';
import 'package:flutter_movie/Features/Home/data/model/movie.dart';
import 'package:flutter_movie/Features/MovieDetial/view/movie_detail_screen.dart';
import 'package:flutter_movie/Features/MovieList/bloc/movie_list_bloc.dart';
import 'package:flutter_movie/Features/MovieList/bloc/movie_list_event.dart';
import 'package:flutter_movie/Features/MovieList/view/movie_list_screen.dart';
import 'package:flutter_movie/constants/custom_colors.dart';
import 'package:flutter_movie/gen/assets.gen.dart';
import 'package:flutter_movie/util/enum/category_enum.dart';
import 'package:flutter_movie/widget/advertisment_banner.dart';
import 'package:flutter_movie/widget/banner.dart';
import 'package:flutter_movie/widget/cached_network_image.dart';
import 'package:flutter_movie/widget/shimmer_loading.dart';
import 'package:flutter_movie/widget/show_eror_widget.dart';
import 'package:flutter_network_connectivity/flutter_network_connectivity.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FlutterNetworkConnectivity _flutterNetworkConnectivity =
      FlutterNetworkConnectivity(
    isContinousLookUp: true,
  );
  bool? _isInternetAvailableStreamStatus = false;

  @override
  void initState() {
    super.initState();
    context.read<HomeBloc>().add(HomeInitializeEvent());
    _flutterNetworkConnectivity.getInternetAvailabilityStream().listen((event) {
      _isInternetAvailableStreamStatus = event;
      context.read<HomeBloc>().add(HomeRefreshDataEvent(event));
    });
  }

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable, no_leading_underscores_for_local_identifiers
    final TextTheme _textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: SafeArea(child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state is HomeLoadingState) {
            return const ShimmerLoading();
          } else if (state is HomeRequestSuccessState) {
            return CustomScrollView(
              slivers: [
                SearchBox(textTheme: _textTheme),
                state.movieBannerList.fold((exception) {
                  return ShowErrorWidget(exception: exception);
                }, (movieBannerListBox) {
                  return ValueListenableBuilder(
                    valueListenable: movieBannerListBox.listenable(),
                    builder: (context, value, child) {
                      return BannerMainWidget(
                        value.values.toList(),
                      );
                    },
                  );
                }),
                TitleItemCardVertical(
                  textTheme: _textTheme,
                  titleCategory: 'اکشن',
                  categorytypeEnum: CategorytypeEnum.ACTION,
                ),
                state.actionGenreMovieList.fold((exception) {
                  return ShowErrorWidget(
                    exception: exception,
                  );
                }, (actionGenreMovieListBox) {
                  return ValueListenableBuilder(
                    valueListenable: actionGenreMovieListBox.listenable(),
                    builder: (context, value, child) {
                      return MovieCardVerticalList(
                        textTheme: _textTheme,
                        movieList: value.values.toList(),
                      );
                    },
                  );
                }),
                const ContainerBeetweenCardItem(),
                TitleItemCardVertical(
                  textTheme: _textTheme,
                  titleCategory: 'عاشقانه',
                  categorytypeEnum: CategorytypeEnum.ROMANCE,
                ),
                state.romanceGenreMovieList.fold((exception) {
                  return ShowErrorWidget(exception: exception);
                }, (romanceGenreMovieBox) {
                  return ValueListenableBuilder(
                    valueListenable: romanceGenreMovieBox.listenable(),
                    builder: (context, value, child) {
                      return MovieCardVerticalList(
                        textTheme: _textTheme,
                        movieList: value.values.toList(),
                      );
                    },
                  );
                }),
                state.advertismentList
                    .fold((exception) => ShowErrorWidget(exception: exception),
                        (advertismentList) {
                  return ValueListenableBuilder(
                    valueListenable: advertismentList.listenable(),
                    builder: (context, value, child) {
                      final advertismentBannerList = value.values.toList();
                      return AdvertismentBanner(
                          advertismentList: advertismentBannerList);
                    },
                  );
                }),
                const ContainerBeetweenCardItem(),
                TitleItemCardVertical(
                  textTheme: _textTheme,
                  titleCategory: 'کارتون',
                  categorytypeEnum: CategorytypeEnum.CARTOON,
                ),
                state.cartoonList
                    .fold((exception) => ShowErrorWidget(exception: exception),
                        (cartoonListBox) {
                  return ValueListenableBuilder(
                    valueListenable: cartoonListBox.listenable(),
                    builder: (context, value, child) {
                      return MovieListCardVerticalSmall(
                        movieList: value.values.toList(),
                      );
                    },
                  );
                }),
                const ContainerBeetweenCardItem(),
                TitleItemCardVertical(
                  textTheme: _textTheme,
                  titleCategory: 'انیمه',
                  categorytypeEnum: CategorytypeEnum.ANIME,
                ),
                state.animelIst
                    .fold((exception) => ShowErrorWidget(exception: exception),
                        (animeListBox) {
                  return ValueListenableBuilder(
                    valueListenable: animeListBox.listenable(),
                    builder: (context, value, child) {
                      return MovieListCardVerticalSmall(
                          movieList: value.values.toList());
                    },
                  );
                }),
                const ContainerBeetweenCardItem(),
                TitleItemCardVertical(
                  textTheme: _textTheme,
                  titleCategory: 'ترسناک',
                  categorytypeEnum: CategorytypeEnum.HORROR,
                ),
                state.horrorGenreMovieList
                    .fold((exception) => ShowErrorWidget(exception: exception),
                        (horrorGenreMovieListBox) {
                  return ValueListenableBuilder(
                    valueListenable: horrorGenreMovieListBox.listenable(),
                    builder: (context, value, child) {
                      return MovieCardVerticalList(
                        textTheme: _textTheme,
                        movieList: value.values.toList(),
                      );
                    },
                  );
                }),
                const ContainerBeetweenCardItem(),
                TitleItemCardVertical(
                  textTheme: _textTheme,
                  titleCategory: 'جنایی',
                  categorytypeEnum: CategorytypeEnum.CRIMINAL,
                ),
                state.criminalGenreMovieList
                    .fold((exception) => ShowErrorWidget(exception: exception),
                        (criminalGenreMovieListBox) {
                  return ValueListenableBuilder(
                    valueListenable: criminalGenreMovieListBox.listenable(),
                    builder: (context, value, child) {
                      return MovieCardVerticalList(
                          textTheme: _textTheme,
                          movieList: value.values.toList());
                    },
                  );
                }),
                IntroducingApplication(textTheme: _textTheme)
              ],
            );
          }
          return Text('empty');
        },
      )),
    );
  }

  SliverToBoxAdapter test() {
    return SliverToBoxAdapter(
        child: SizedBox(
      height: 200.0,
      child: Shimmer.fromColors(
        baseColor: Colors.white.withOpacity(0.55),
        highlightColor: Colors.white.withOpacity(0.7),
        child: SizedBox(
          height: 160.h,
          child: Padding(
            padding: const EdgeInsets.only(left: 18),
            child: PageView.builder(
              itemCount: 3,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(left: index > 0 ? 20 : 0),
                  child: Container(
                    color: Colors.blue,
                  ),
                );
              },
            ),
          ),
        ),
      ),
    ));
  }
}

class IntroducingApplication extends StatelessWidget {
  const IntroducingApplication({
    super.key,
    required TextTheme textTheme,
  }) : _textTheme = textTheme;

  final TextTheme _textTheme;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        padding: const EdgeInsets.only(bottom: 20).h,
        decoration: const BoxDecoration(
          color: Colors.black26,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(18),
            topLeft: Radius.circular(18),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Text(
                  'Experience the best moments with aio movie thank you for watching',
                  style: _textTheme.titleLarge!),
              SizedBox(
                height: 7.h,
              ),
              Row(
                children: [
                  Assets.images.icInstagram.image(),
                  SizedBox(
                    width: 6.w,
                  ),
                  Text(
                    'http://instagram/user:username=m_ahm1384/',
                    style: _textTheme.titleSmall!
                        .copyWith(color: CustomColors.colorBlueLink),
                  ),
                ],
              ),
              SizedBox(
                height: 20.h,
              ),
              Row(
                children: [
                  Assets.images.icTelegram.image(),
                  SizedBox(
                    width: 6.w,
                  ),
                  Text(
                    'http://tellgram/user:username=m_ahm1384/',
                    style: _textTheme.titleSmall!
                        .copyWith(color: CustomColors.colorBlueLink),
                  ),
                ],
              ),
              SizedBox(
                height: 20.h,
              ),
              Text(
                'Contact support',
                style: _textTheme.titleSmall!.copyWith(color: Colors.white),
              ),
              SizedBox(
                height: 6.h,
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: CustomColors.colorOnPrimary,
                      minimumSize: Size.fromHeight(40)),
                  onPressed: () {},
                  child: Text(
                    'call',
                    style: _textTheme.titleLarge!.copyWith(color: Colors.black),
                  )),
              SizedBox(
                height: 10.h,
              ),
              Text(
                'In aio movie, see everything, including movies, serials, anime, and cartoons',
                style: _textTheme.titleSmall!.copyWith(color: Colors.white),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class MovieListCardVerticalSmall extends StatelessWidget {
  final List<Movie> _movieList;
  const MovieListCardVerticalSmall({super.key, required List<Movie> movieList})
      : _movieList = movieList;

  @override
  Widget build(BuildContext context) {
    final TextTheme _themeData = Theme.of(context).textTheme;

    return SliverToBoxAdapter(
      child: GestureDetector(
        child: Padding(
          padding: const EdgeInsets.only(top: 22),
          child: SizedBox(
            height: 160.h,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _movieList.length > 5 ? 5 : _movieList.length,
              itemBuilder: (context, index) {
                return ItemCardVerticalSmall(
                  index: index,
                  themeData: _themeData,
                  movie: _movieList[index],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class ItemCardVerticalSmall extends StatelessWidget {
  final Movie _movie;
  final int index;
  const ItemCardVerticalSmall(
      {super.key,
      required this.index,
      required TextTheme themeData,
      required Movie movie})
      : _themeData = themeData,
        _movie = movie;

  final TextTheme _themeData;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MovieDetailScreen(movie: _movie),
            ));
      },
      child: SizedBox(
        height: 100,
        child: Padding(
          padding: EdgeInsets.only(left: index == 0 ? 22 : 0, right: 30).w,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 84.w,
                height: 104.h,
                color: Colors.blue,
                child: CachedImage(url: _movie.thumbnail ?? ''),
              ),
              SizedBox(
                height: 22.h,
              ),
              Text(
                _movie.MovieName.toString(),
                style: _themeData.titleSmall!.copyWith(color: Colors.white),
              ),
              Row(
                children: [
                  RatingBar.builder(
                    itemSize: 13,
                    ignoreGestures: true,
                    initialRating: _movie.score!.toDouble(),
                    unratedColor: Colors.white,
                    itemCount: 5,
                    itemPadding: const EdgeInsets.symmetric(horizontal: 2),
                    itemBuilder: (context, _) => const Icon(
                      Icons.star,
                      color: CustomColors.colorYellowRating,
                    ),
                    onRatingUpdate: (rating) {},
                  ),
                  Text(
                    _movie.score.toString(),
                    style: _themeData.titleSmall,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class TitleItemCardVertical extends StatelessWidget {
  const TitleItemCardVertical({
    super.key,
    required String titleCategory,
    required TextTheme textTheme,
    required this.categorytypeEnum,
  })  : titleCategory = titleCategory,
        _textTheme = textTheme;

  final String titleCategory;
  final TextTheme _textTheme;
  final CategorytypeEnum categorytypeEnum;
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(22, 22, 22, 0).w,
        child: Row(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    final MovieListBLoc bloc = locator.get();
                    bloc.add(MovieListRequestFromHomeState(categorytypeEnum));
                    return BlocProvider<MovieListBLoc>.value(
                      value: bloc,
                      child: const MovieListScreen(),
                    );
                  },
                ));
              },
              child: Row(
                children: [
                  const Icon(
                    Icons.west_outlined,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 5.w,
                  ),
                  Text(
                    'همه',
                    style: _textTheme.titleMedium,
                  ),
                ],
              ),
            ),
            const Spacer(),
            Text(
              titleCategory,
              style: _textTheme.titleLarge,
            ),
          ],
        ),
      ),
    );
  }
}

class ContainerBeetweenCardItem extends StatelessWidget {
  const ContainerBeetweenCardItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        margin: const EdgeInsets.only(top: 12).h,
        height: 8,
        color: CustomColors.colorBlack,
      ),
    );
  }
}

class MovieCardVerticalList extends StatelessWidget {
  final List<Movie> _movieList;
  const MovieCardVerticalList(
      {super.key, required List<Movie> movieList, required TextTheme textTheme})
      : _movieList = movieList,
        _textTheme = textTheme;
  final TextTheme _textTheme;
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: 320.h,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: _movieList.length > 5 ? 5 : _movieList.length,
          itemBuilder: (context, index) {
            return ItemCardVertical(
              textTheme: _textTheme,
              movie: _movieList[index],
            );
          },
        ),
      ),
    );
  }
}

class ItemCardVertical extends StatelessWidget {
  final Movie _movie;
  const ItemCardVertical(
      {super.key, required TextTheme textTheme, required Movie movie})
      : _textTheme = textTheme,
        _movie = movie;

  final TextTheme _textTheme;
  final double _initializingRating = 4;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MovieDetailScreen(
                movie: _movie,
              ),
            ));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 22).w,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 15).h,
              width: 155.w,
              height: 232.h,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(4),
              ),
              child: CachedImage(url: _movie.thumbnail!),
            ),
            SizedBox(
              height: 18.h,
            ),
            Text(
              _movie.MovieName.toString(),
              style: _textTheme.titleLarge,
            ),
            SizedBox(
              height: 5.h,
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                RatingBar.builder(
                  itemSize: 20.w,
                  allowHalfRating: true,
                  ignoreGestures: true,
                  initialRating: _movie.score!.toDouble(),
                  unratedColor: Colors.white,
                  itemCount: 5,
                  itemPadding: const EdgeInsets.symmetric(horizontal: 2),
                  itemBuilder: (context, _) => const Icon(
                    Icons.star,
                    color: CustomColors.colorYellowRating,
                  ),
                  onRatingUpdate: (rating) {},
                ),
                Text(
                  _movie.score.toString(),
                  style: _textTheme.titleLarge,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class SearchBox extends StatelessWidget {
  const SearchBox({
    super.key,
    required TextTheme textTheme,
  }) : _textTheme = textTheme;

  final TextTheme _textTheme;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Container(
            margin: const EdgeInsets.only(
              bottom: 20,
            ).h,
            height: 30.h,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: CustomColors.colorBlack.withOpacity(0.5),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Assets.images.icSearch.image(width: 11.w),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  'search....',
                  style: _textTheme.titleSmall!.copyWith(color: Colors.white),
                ),
              ],
            )),
      ),
    );
  }
}
