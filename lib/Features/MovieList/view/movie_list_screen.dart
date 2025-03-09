import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_movie/DI/get_it.dart';
import 'package:flutter_movie/Features/MovieList/bloc/movie_list_bloc.dart';
import 'package:flutter_movie/Features/MovieList/bloc/movie_list_state.dart';
import 'package:flutter_movie/Features/MovieList/data/model/item_card_movie.dart';
import 'package:flutter_movie/constants/custom_colors.dart';
import 'package:flutter_movie/widget/appbar_main.dart';
import 'package:flutter_movie/widget/cached_network_image.dart';
import 'package:flutter_movie/widget/show_eror_widget.dart';

class MovieListScreen extends StatefulWidget {
  const MovieListScreen({super.key});

  @override
  State<MovieListScreen> createState() => _MovieListScreenState();
}

class _MovieListScreenState extends State<MovieListScreen> {
  @override
  Widget build(BuildContext context) {
    final TextTheme _textTheme = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: CustomColors.colorBackground,
      body: SafeArea(
        child: BlocBuilder<MovieListBLoc, MovieListState>(
          builder: (context, state) {
            if (state is MovieListLoadingStat) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is MovieListRequestSuccessState) {
              return CustomScrollView(
                slivers: [
                  state.itemCatdMovieGenre.fold((exception) {
                    return ShowErrorWidget(exception: exception);
                  }, (itemCardMovieGenreList) {
                    return SliverList(
                      delegate: SliverChildBuilderDelegate(
                        childCount: itemCardMovieGenreList.length,
                        (context, index) => ItemCardMovie(
                          itemCardMovieGenreList[index],
                          textTheme: _textTheme,
                        ),
                      ),
                    );
                  })
                ],
              );
            }
            return Text('empty');
          },
        ),
      ),
    );
  }
}

class ItemCardMovie extends StatelessWidget {
  final ItemCard _itemCard;
  const ItemCardMovie(
    this._itemCard, {
    super.key,
    required TextTheme textTheme,
  }) : _textTheme = textTheme;

  final TextTheme _textTheme;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {},
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(
              color: CustomColors.colorPrimary.withOpacity(0.6),
            ),
            borderRadius: BorderRadius.circular(10)),
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 18),
        padding: const EdgeInsets.symmetric(horizontal: 10),
        height: 200,
        width: MediaQuery.of(context).size.width / 2.3,
        child: Stack(
          children: [
            SizedBox(
              width: 150,
              child: CachedImage(
                url: _itemCard.movie.thumbnail!,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
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
                              '${_itemCard.movie.MovieName}',
                              style: _textTheme.titleMedium,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Text(':نام', style: _textTheme.titleLarge),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text('${_itemCard.movie.score}',
                          style: _textTheme.titleLarge!),
                      SizedBox(
                        width: 20,
                      ),
                      Text(':امتیاز', style: _textTheme.titleLarge!),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    _itemCard.categoryList == null ? '' : ':ژانر',
                    style: _textTheme.titleLarge!,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 40,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 150),
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: _itemCard.categoryList?.length ?? 0,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: const EdgeInsets.only(left: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: CustomColors.colorPrimary,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            child: Center(
                              child: Text(
                                _itemCard.categoryList?[index].title ?? '',
                                style: _textTheme.titleMedium!,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
