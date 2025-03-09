import 'package:expansion_widget/expansion_widget.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_movie/DI/get_it.dart';
import 'package:flutter_movie/Features/Home/data/model/movie.dart';
import 'package:flutter_movie/Features/MovieDetial/bloc/movie_detail_bloc.dart';
import 'package:flutter_movie/Features/MovieDetial/bloc/movie_detail_event.dart';
import 'package:flutter_movie/Features/MovieDetial/bloc/movie_detail_state.dart';
import 'package:flutter_movie/Features/MovieDetial/data/model/movie_detile.dart';
import 'package:flutter_movie/Features/MovieLink/view/movie_link_screen.dart';
import 'package:flutter_movie/Features/WatchMovie/view/watch_movie_screen.dart';
import 'package:flutter_movie/constants/custom_colors.dart';
import 'package:flutter_movie/gen/assets.gen.dart';
import 'package:flutter_movie/util/enum/link_enum.type.dart';
import 'package:flutter_movie/util/videoPlayerController/video_player_conteoller.dart';
import 'package:flutter_movie/widget/button_main.dart';
import 'package:flutter_movie/widget/cached_network_image.dart';
import 'package:flutter_movie/widget/show_eror_widget.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:like_button/like_button.dart';
import 'dart:math' as math;

import 'package:video_player/video_player.dart';

class MovieDetailScreen extends StatefulWidget {
  final Movie movie;

  const MovieDetailScreen({super.key, required this.movie});

  @override
  State<MovieDetailScreen> createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme _textTheme = Theme.of(context).textTheme;
    final MovieDetailBLoc bloc = locator.get();
    bloc.add(MovieDetailRequestDataEvent(widget.movie.id!));

    return SafeArea(
      child: BlocProvider.value(
        value: bloc,
        child: BlocBuilder<MovieDetailBLoc, MovieDetailState>(
          builder: (context, state) {
            if (state is MovieDetailLoadingState) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is MovieDetailRequestSuccessState) {
              return MovieDetailScreenContent(
                textTheme: _textTheme,
                state: state,
                movie: widget.movie,
              );
            }
            return Text('empty');
          },
        ),
      ),
    );
  }
}

class MovieDetailScreenContent extends StatefulWidget {
  const MovieDetailScreenContent(
      {super.key,
      required TextTheme textTheme,
      required this.state,
      required this.movie})
      : _textTheme = textTheme;

  final TextTheme _textTheme;
  final MovieDetailRequestSuccessState state;
  final Movie movie;

  @override
  State<MovieDetailScreenContent> createState() =>
      _MovieDetailScreenContentState();
}

class _MovieDetailScreenContentState extends State<MovieDetailScreenContent> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Opacity(
          opacity: .4,
          child: FittedBox(
              fit: BoxFit.cover,
              child: SizedBox(
                  height: 1000,
                  child: CachedImage(url: widget.movie.thumbnail ?? ''))),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: Padding(
            padding: const EdgeInsets.all(12),
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Row(
                    children: [
                      Text(
                        'Aio',
                        style: widget._textTheme.titleLarge!,
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      Assets.images.icVideoCamera
                          .image(width: 32, color: CustomColors.colorOnPrimary),
                    ],
                  ),
                ),
                widget.state.movieDetailData.fold(
                    (exception) => ShowErrorWidget(exception: exception),
                    (movieDetail) => SliverToBoxAdapter(
                          child: DetailContent(
                            isLinkLowIsEmpty: widget.state.isLinkLowEmpty,
                            isLinkHdIsEmpty: widget.state.isLinkHdEmpty,
                            isLinkFullHdIsEmpty: widget.state.isLinkFullHdEmpty,
                            textTheme: widget._textTheme,
                            movieDetail: movieDetail,
                            movie: widget.movie,
                          ),
                        )),
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: CustomColors.colorPrimary.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: CustomColors.colorPrimary,
                            )),
                        margin: const EdgeInsets.only(top: 20),
                        child: ExpansionWidget(
                          initiallyExpanded: true,
                          titleBuilder: (double animationValue, _,
                              bool isExpaned, toogleFunction) {
                            return InkWell(
                                onTap: () => toogleFunction(animated: true),
                                child: Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Expanded(
                                          child: Text(
                                        'link download',
                                        style: widget._textTheme.titleLarge,
                                      )),
                                      Transform.rotate(
                                        angle: math.pi * animationValue / 2,
                                        alignment: Alignment.center,
                                        child: const Icon(Icons.arrow_right,
                                            size: 40),
                                      )
                                    ],
                                  ),
                                ));
                          },
                          content: Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(20),
                              child: Column(
                                children: [
                                  if (!widget.state.isLinkLowEmpty) ...{
                                    ButtonMain(
                                      textShow: '480',
                                      onTap: () {
                                        Navigator.push(context,
                                            MaterialPageRoute(
                                          builder: (context) {
                                            return LinkScreen(
                                              linkTypeEnum: LinkTypeEnum.LOW,
                                              movieID: widget.movie.id!,
                                            );
                                          },
                                        ));
                                      },
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    )
                                  },
                                  if (!widget.state.isLinkHdEmpty) ...{
                                    ButtonMain(
                                      textShow: '720',
                                      onTap: () {
                                        Navigator.push(context,
                                            MaterialPageRoute(
                                          builder: (context) {
                                            return LinkScreen(
                                              linkTypeEnum: LinkTypeEnum.HD,
                                              movieID: widget.movie.id!,
                                            );
                                          },
                                        ));
                                      },
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    )
                                  },
                                  if (!widget.state.isLinkFullHdEmpty) ...{
                                    ButtonMain(
                                      textShow: '1080',
                                      onTap: () {
                                        Navigator.push(context,
                                            MaterialPageRoute(
                                          builder: (context) {
                                            return LinkScreen(
                                              linkTypeEnum: LinkTypeEnum.FULLHD,
                                              movieID: widget.movie.id!,
                                            );
                                          },
                                        ));
                                      },
                                    )
                                  }
                                ],
                              )),
                        ),
                      ),
                    ],
                  ),
                ),
                SliverToBoxAdapter(
                  child: Container(
                    margin: const EdgeInsets.only(top: 20),
                    height: 60,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: CustomColors.colorPrimary,
                        )),
                    child: Center(
                      child: Text(
                        'مشاهده نظرات',
                        style: widget._textTheme.titleLarge,
                      ),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Text(
                      'موارد مشابه',
                      textAlign: TextAlign.end,
                      style: widget._textTheme.titleLarge,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class DetailContent extends StatefulWidget {
  bool isLinkLowIsEmpty;

  bool isLinkHdIsEmpty;

  bool isLinkFullHdIsEmpty;

  DetailContent(
      {super.key,
      required TextTheme textTheme,
      required this.movieDetail,
      required this.movie,
      required this.isLinkLowIsEmpty,
      required this.isLinkHdIsEmpty,
      required this.isLinkFullHdIsEmpty})
      : _textTheme = textTheme;

  final TextTheme _textTheme;
  final MovieDetail movieDetail;
  final Movie movie;

  @override
  State<DetailContent> createState() => _DetailContentState();
}

class _DetailContentState extends State<DetailContent> {
  bool _isLiked = false;
  late FlickManager flickManager;
  @override
  void initState() {
    if (widget.movieDetail.trailerLink != '') {
      flickManager = FlickManager(
        autoPlay: false,
        videoPlayerController: VideoPlayerController.networkUrl(
          Uri.parse(widget.movieDetail.trailerLink ?? ''),
        ),
      );
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        SizedBox(
          height: 30.h,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text('${widget.movieDetail.scoreImbd}',
                    style: widget._textTheme.titleMedium!.apply(
                      color: CustomColors.colorPrimary,
                    )),
                SizedBox(
                  width: 4.w,
                ),
                Text('/10',
                    style: widget._textTheme.titleMedium!.apply(
                      color: CustomColors.colorPrimary,
                    )),
                SizedBox(
                  width: 20.w,
                ),
                SizedBox(
                  width: 100,
                  child: LikeButton(
                    onTap: (isLiked) async {
                      if (!isLiked) {
                        widget.movieDetail.numberLike++;
                        _isLiked = true;
                      } else {
                        widget.movieDetail.numberLike--;
                        _isLiked = false;
                      }
                      context
                          .read<MovieDetailBLoc>()
                          .add(MovieDetailChangeLikeEvent(
                            widget.movieDetail.id,
                            widget.movieDetail.numberLike,
                          ));
                      return _isLiked;
                    },
                    likeCount: widget.movieDetail.numberLike,
                    bubblesColor: const BubblesColor(
                      dotPrimaryColor: Color(0xff33b5e5),
                      dotSecondaryColor: Color(0xff0099cc),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10.h,
            ),
            Row(
              children: [
                Assets.images.icImbd.image(width: 44.w),
                SizedBox(
                  width: 50.w,
                ),
                SizedBox(
                  height: 40,
                  width: 200,
                  child: ButtonMain(
                    textShow: 'تماشای انلاین',
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            backgroundColor: CustomColors.colorBackground,
                            content: SizedBox(
                              height: 200,
                              child: Column(
                                children: [
                                  if (!widget.isLinkLowIsEmpty) ...{
                                    ButtonMain(
                                      textShow: '480',
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) {
                                              return WatchMovieScreen(
                                                linkTypeEnum: LinkTypeEnum.LOW,
                                                movieID: widget.movie.id!,
                                              );
                                            },
                                          ),
                                        );
                                      },
                                    )
                                  },
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  if (!widget.isLinkHdIsEmpty) ...{
                                    ButtonMain(
                                      textShow: '720',
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) {
                                              return WatchMovieScreen(
                                                linkTypeEnum: LinkTypeEnum.HD,
                                                movieID: widget.movie.id!,
                                              );
                                            },
                                          ),
                                        );
                                      },
                                    )
                                  },
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  if (!widget.isLinkFullHdIsEmpty) ...{
                                    ButtonMain(
                                      textShow: '1080',
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) {
                                              return WatchMovieScreen(
                                                linkTypeEnum:
                                                    LinkTypeEnum.FULLHD,
                                                movieID: widget.movie.id!,
                                              );
                                            },
                                          ),
                                        );
                                      },
                                    )
                                  }
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                )
              ],
            )
          ],
        ),
        SizedBox(
          height: 20.h,
        ),
        Text(
          ' ${widget.movie.MovieName} ',
          style: widget._textTheme.headlineMedium,
        ),
        SizedBox(
          height: 14.h,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                'زمان:${widget.movieDetail.time} دقیقه',
                style: widget._textTheme.titleSmall!
                    .apply(color: CustomColors.colorOnPrimary),
              ),
              SizedBox(
                width: 8.w,
              ),
              Assets.images.icTime
                  .image(width: 24.w, color: CustomColors.colorPrimary),
              SizedBox(
                width: 8.w,
              ),
              const Spacer(),
              Directionality(
                textDirection: TextDirection.rtl,
                child: Text(
                  '${widget.movieDetail.countryName} :کشور',
                  style: widget._textTheme.titleSmall!
                      .apply(color: CustomColors.colorOnPrimary),
                ),
              ),
              SizedBox(
                width: 8.w,
              ),
              Assets.images.icGenre
                  .image(width: 24.w, color: CustomColors.colorPrimary),
            ],
          ),
        ),
        SizedBox(
          height: 10.h,
        ),
        ItemGenre(textTheme: widget._textTheme),
        SizedBox(
          height: 10.h,
        ),
        ItemDirector(
            textTheme: widget._textTheme,
            director: widget.movieDetail.director!),
        SizedBox(
          height: 10.h,
        ),
        ItemWriter(
            textTheme: widget._textTheme, writer: widget.movieDetail.writer!),
        Text(
          '${widget.movieDetail.description}',
          textAlign: TextAlign.end,
          style: widget._textTheme.titleMedium,
        ),
        RatingBarWidget(
            textTheme: widget._textTheme,
            score: widget.movie.score!.toDouble()),
        if (widget.movieDetail.trailerLink != '') ...{
          Text(
            ':تریلر',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            child: FlickVideoPlayer(
              flickManager: flickManager,
            ),
          )
        }
      ],
    );
  }
}

class ItemGenre extends StatelessWidget {
  const ItemGenre({
    super.key,
    required TextTheme textTheme,
  }) : _textTheme = textTheme;

  final TextTheme _textTheme;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            'ژانر:اکشن , جناییس',
            style: _textTheme.titleSmall!
                .apply(color: CustomColors.colorOnPrimary),
          ),
          SizedBox(
            width: 8.w,
          ),
          Assets.images.icFolder
              .image(width: 24.w, color: CustomColors.colorPrimary)
        ],
      ),
    );
  }
}

class ItemDirector extends StatelessWidget {
  const ItemDirector(
      {super.key, required TextTheme textTheme, required this.director})
      : _textTheme = textTheme;

  final TextTheme _textTheme;
  final String director;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            '${director} :کارگردان',
            style: _textTheme.titleSmall!
                .apply(color: CustomColors.colorOnPrimary),
          ),
          SizedBox(
            width: 8.w,
          ),
          Assets.images.icUser
              .image(width: 24.w, color: CustomColors.colorPrimary)
        ],
      ),
    );
  }
}

class ItemWriter extends StatelessWidget {
  const ItemWriter({
    super.key,
    required TextTheme textTheme,
    required this.writer,
  }) : _textTheme = textTheme;

  final TextTheme _textTheme;
  final String writer;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            '$writer :نویسنده',
            style: _textTheme.titleSmall!
                .apply(color: CustomColors.colorOnPrimary),
          ),
          SizedBox(
            width: 8.w,
          ),
          Assets.images.icWriter
              .image(width: 24.w, color: CustomColors.colorPrimary)
        ],
      ),
    );
  }
}

class RatingBarWidget extends StatelessWidget {
  const RatingBarWidget(
      {super.key, required TextTheme textTheme, required this.score})
      : _textTheme = textTheme;

  final TextTheme _textTheme;
  final double score;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Row(
        children: [
          RatingBar.builder(
            initialRating: score,
            unratedColor: Colors.white,
            ignoreGestures: true,
            itemCount: 5,
            itemPadding: const EdgeInsets.symmetric(horizontal: 2),
            itemBuilder: (context, _) => const Icon(
              Icons.star,
              color: Colors.amber,
            ),
            onRatingUpdate: (rating) {},
          ),
          Spacer(),
          Text(
            'امتیاز منتقدین',
            style: _textTheme.titleMedium,
          )
        ],
      ),
    );
  }
}
