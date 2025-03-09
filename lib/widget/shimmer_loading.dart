import 'package:flutter/material.dart';
import 'package:flutter_movie/constants/custom_colors.dart';
import 'package:flutter_movie/gen/assets.gen.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerLoading extends StatelessWidget {
  const ShimmerLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 18,
      ).h,
      child: Shimmer.fromColors(
          baseColor: Colors.white.withOpacity(0.55),
          highlightColor: Colors.white.withOpacity(0.7),
          child: CustomScrollView(
            slivers: [
              BannerMainWidgetShimmer(),
              TitleItemCardVerticalShimmer(
                titleCategory: 'Action',
              ),
              const MovieListCardVerticalShimmer(),
              const ContainerBeetweenCardItemShimmer(),
              TitleItemCardVerticalShimmer(
                titleCategory: 'Romance',
              ),
              const MovieListCardVerticalShimmer(),
              BannerMainWidgetShimmer(),
              ContainerBeetweenCardItemShimmer(),
              TitleItemCardVerticalShimmer(
                titleCategory: 'cartoon',
              ),
              const MovieListCardVerticalSmallShimmer(),
              const ContainerBeetweenCardItemShimmer(),
              TitleItemCardVerticalShimmer(
                titleCategory: 'anime',
              ),
              const MovieListCardVerticalSmallShimmer(),
              const ContainerBeetweenCardItemShimmer(),
              TitleItemCardVerticalShimmer(
                titleCategory: 'ترسناک',
              ),
              const MovieListCardVerticalShimmer(),
              const ContainerBeetweenCardItemShimmer(),
              TitleItemCardVerticalShimmer(
                titleCategory: 'جنایی',
              ),
              const MovieListCardVerticalShimmer(),
              IntroducingApplicationShimmer()
            ],
          )),
    );
  }
}

class BannerMainWidgetShimmer extends StatelessWidget {
  BannerMainWidgetShimmer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final PageController _pageController =
        PageController(viewportFraction: 0.8, initialPage: 1);
    return SliverToBoxAdapter(
      child: SizedBox(
        height: 160.h,
        child: Padding(
          padding: const EdgeInsets.only(left: 18),
          child: PageView.builder(
            controller: _pageController,
            itemCount: 3,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.only(left: index > 0 ? 20 : 0),
                child: Container(
                  color: Colors.red,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class IntroducingApplicationShimmer extends StatelessWidget {
  const IntroducingApplicationShimmer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        padding: EdgeInsets.only(bottom: 20).h,
        decoration: BoxDecoration(
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
              ),
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
                  ),
                ],
              ),
              SizedBox(
                height: 20.h,
              ),
              Text(
                'Contact support',
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
                  )),
              SizedBox(
                height: 10.h,
              ),
              Text(
                'In aio movie, see everything, including movies, serials, anime, and cartoons',
              )
            ],
          ),
        ),
      ),
    );
  }
}

class MovieListCardVerticalSmallShimmer extends StatelessWidget {
  const MovieListCardVerticalSmallShimmer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(top: 22),
        child: SizedBox(
          height: 160.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 10,
            itemBuilder: (context, index) {
              return ItemCardVerticalSmallShimmer(
                index: index,
              );
            },
          ),
        ),
      ),
    );
  }
}

class ItemCardVerticalSmallShimmer extends StatelessWidget {
  final int index;
  const ItemCardVerticalSmallShimmer({
    super.key,
    required this.index,
  });

  final double _initializingRating = 3;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
            ),
            SizedBox(
              height: 22.h,
            ),
            Text(
              'scree romance',
            ),
            Row(
              children: [
                RatingBar.builder(
                  itemSize: 13,
                  initialRating: _initializingRating,
                  unratedColor: Colors.white,
                  itemCount: 5,
                  itemPadding: EdgeInsets.symmetric(horizontal: 2),
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: CustomColors.colorYellowRating,
                  ),
                  onRatingUpdate: (rating) {},
                ),
                Text(
                  _initializingRating.round().toString(),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class TitleItemCardVerticalShimmer extends StatelessWidget {
  TitleItemCardVerticalShimmer({
    super.key,
    required String titleCategory,
  }) : titleCategory = titleCategory;

  final String titleCategory;

  @override
  Widget build(BuildContext context) {
    final TextTheme _themeData = Theme.of(context).textTheme;

    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(22, 22, 22, 0).w,
        child: Row(
          children: [
            Text(
              titleCategory,
              style: _themeData.titleLarge,
            ),
            const Spacer(),
            const Icon(
              Icons.west_outlined,
              color: Colors.white,
            )
          ],
        ),
      ),
    );
  }
}

class ContainerBeetweenCardItemShimmer extends StatelessWidget {
  const ContainerBeetweenCardItemShimmer({
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

class MovieListCardVerticalShimmer extends StatelessWidget {
  const MovieListCardVerticalShimmer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final TextTheme _themeData = Theme.of(context).textTheme;

    return SliverToBoxAdapter(
      child: SizedBox(
        height: 320.h,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 10,
          itemBuilder: (context, index) {
            return ItemCardVerticalShimmer(themeData: _themeData);
          },
        ),
      ),
    );
  }
}

class ItemCardVerticalShimmer extends StatelessWidget {
  ItemCardVerticalShimmer({
    super.key,
    required TextTheme themeData,
  }) : _themeData = themeData;

  final TextTheme _themeData;
  final double _initializingRating = 4;

  @override
  Widget build(BuildContext context) {
    return Padding(
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
          ),
          SizedBox(
            height: 18,
          ),
          Text(
            'shazam',
            style: _themeData.titleLarge,
          ),
          SizedBox(
            height: 5.h,
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              RatingBar.builder(
                itemSize: 20,
                initialRating: _initializingRating,
                unratedColor: Colors.white,
                itemCount: 5,
                itemPadding: EdgeInsets.symmetric(horizontal: 2),
                itemBuilder: (context, _) => Icon(
                  Icons.star,
                  color: CustomColors.colorYellowRating,
                ),
                onRatingUpdate: (rating) {},
              ),
              Text(
                _initializingRating.round().toString(),
                style: _themeData.titleLarge,
              ),
            ],
          )
        ],
      ),
    );
  }
}

class SearchBoxShimmer extends StatelessWidget {
  const SearchBoxShimmer({
    super.key,
    required TextTheme themeData,
  }) : _themeData = themeData;

  final TextTheme _themeData;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
            margin: const EdgeInsets.only(bottom: 14).h,
            width: 200.w,
            height: 22.h,
            decoration: BoxDecoration(
              color: CustomColors.colorBlack.withOpacity(0.5),
              borderRadius: BorderRadius.circular(18),
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
                  style: _themeData.titleSmall!.copyWith(color: Colors.white),
                ),
              ],
            )),
      ],
    );
  }
}
