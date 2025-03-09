import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_movie/DI/get_it.dart';
import 'package:flutter_movie/Features/MovieList/bloc/movie_list_bloc.dart';
import 'package:flutter_movie/Features/MovieList/bloc/movie_list_event.dart';
import 'package:flutter_movie/Features/MovieList/view/movie_list_screen.dart';
import 'package:flutter_movie/Features/category/bloc/category_bloc.dart';
import 'package:flutter_movie/Features/category/bloc/category_event.dart';
import 'package:flutter_movie/Features/category/bloc/category_state.dart';
import 'package:flutter_movie/Features/category/data/model/category.dart';
import 'package:flutter_movie/constants/custom_colors.dart';
import 'package:flutter_movie/util/enum/category_enum.dart';
import 'package:flutter_movie/util/extetion_function/context_extention.dart';
import 'package:flutter_movie/widget/cached_network_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<CategoryBloc>(context).add(CategoryInitializeEvent());
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme _textTheme = getThemeText();
    return Scaffold(
        backgroundColor: CustomColors.colorBackground,
        body: SafeArea(
          child: DefaultTabController(
            length: 3,
            child: NestedScrollView(
                headerSliverBuilder: (context, innerBoxIsScrolled) {
                  return [
                    TabbarWidget(textTheme: _textTheme),
                  ];
                },
                body: TabBarView(
                  children: [
                    BlocBuilder<CategoryBloc, CategoryState>(
                      builder: (context, state) {
                        if (state is CategoryLoadingState) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                        if (state is CategoryRequstSuccessState) {
                          return state.categoryTimeList.fold((exception) {
                            return Center(
                              child: Text(
                                exception,
                                style: _textTheme.headlineMedium,
                              ),
                            );
                          }, (categoryTimeList) {
                            return CustomScrollView(
                              slivers: [
                                CategoryContent(
                                    categoryTimeList, CategorytypeEnum.TIME,
                                    textTheme: _textTheme),
                              ],
                            );
                          });
                        }
                        return Text('empty');
                      },
                    ),
                    BlocBuilder<CategoryBloc, CategoryState>(
                      builder: (context, state) {
                        if (state is CategoryRequstSuccessState) {
                          return state.categoryCountryList.fold((exception) {
                            return Center(
                              child: Text(
                                exception,
                                style: _textTheme.headlineMedium,
                              ),
                            );
                          }, (categoryListCountry) {
                            return CustomScrollView(
                              slivers: [
                                CategoryContent(
                                  categoryListCountry,
                                  CategorytypeEnum.Country,
                                  textTheme: _textTheme,
                                )
                              ],
                            );
                          });
                        }
                        return Text('empty');
                      },
                    ),
                    BlocBuilder<CategoryBloc, CategoryState>(
                      builder: (context, state) {
                        if (state is CategoryRequstSuccessState) {
                          return state.categoryGenreList.fold((exception) {
                            return Center(
                              child: Text(
                                exception,
                                style: _textTheme.headlineMedium,
                              ),
                            );
                          }, (categoryListGenre) {
                            return CustomScrollView(
                              slivers: [
                                CategoryContent(
                                    categoryListGenre, CategorytypeEnum.Genre,
                                    textTheme: _textTheme)
                              ],
                            );
                          });
                        }
                        return Text('empty');
                      },
                    ),
                  ],
                )),
          ),
        ));
  }
}

class CategoryContent extends StatelessWidget {
  final List<Category> _categoryList;
  final CategorytypeEnum _categorytypeEnum;
  const CategoryContent(
    this._categoryList,
    this._categorytypeEnum, {
    required TextTheme textTheme,
    super.key,
  }) : _textTheme = textTheme;
  final TextTheme _textTheme;

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      sliver: SliverGrid(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    MovieListBLoc bloc = locator.get();
                    bloc.add(
                      MovieListRequestFromCategoryEvent(
                        _categoryList[index].id!,
                        _categorytypeEnum,
                      ),
                    );
                    return BlocProvider<MovieListBLoc>.value(
                      value: bloc,
                      child: const MovieListScreen(),
                    );
                  },
                ));
              },
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  SizedBox(
                      height: 200.h,
                      child: CachedImage(url: _categoryList[index].thumbnail!)),
                  Positioned(
                      bottom: 10,
                      child: Container(
                        color: CustomColors.colorPrimary,
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Text(_categoryList[index].title!,
                              style: _textTheme.headlineMedium!),
                        ),
                      ))
                ],
              ),
            );
          },
          childCount: _categoryList.length,
        ),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 20,
          crossAxisSpacing: 20,
        ),
      ),
    );
  }
}

class TabbarWidget extends StatelessWidget {
  const TabbarWidget({
    super.key,
    required TextTheme textTheme,
  }) : _textTheme = textTheme;

  final TextTheme _textTheme;

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      pinned: true,
      floating: true,
      delegate: TabbarViewDelegate(
        TabBar(
          indicatorColor: CustomColors.colorTabIndicator,
          indicatorWeight: 2,
          tabs: [
            Tab(
              child: Text(
                'Time',
                style: _textTheme.titleSmall!
                    .apply(color: CustomColors.colorOnPrimary),
              ),
            ),
            Tab(
              child: Text(
                'country',
                style: _textTheme.titleSmall!
                    .apply(color: CustomColors.colorOnPrimary),
              ),
            ),
            Tab(
              child: Text(
                'Genre',
                style: _textTheme.titleSmall!
                    .apply(color: CustomColors.colorOnPrimary),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TabbarViewDelegate extends SliverPersistentHeaderDelegate {
  final TabBar _tabBar;
  TabbarViewDelegate(this._tabBar);
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: CustomColors.colorBackground,
      child: _tabBar,
    );
  }

  @override
  // TODO: implement maxExtent
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  // TODO: implement minExtent
  double get minExtent => _tabBar.preferredSize.height;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      false;
}
