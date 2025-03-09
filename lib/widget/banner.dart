import 'package:flutter/material.dart';
import 'package:flutter_movie/Features/Home/data/model/movie.dart';
import 'package:flutter_movie/Features/MovieDetial/view/movie_detail_screen.dart';
import 'package:flutter_movie/widget/cached_network_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BannerMainWidget extends StatelessWidget {
  final List<Movie> _movieBannerList;
  const BannerMainWidget(
    this._movieBannerList, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final PageController _pageController =
        PageController(viewportFraction: 0.85, initialPage: 1);
    return SliverToBoxAdapter(
      child: SizedBox(
        height: 160.h,
        child: Padding(
          padding: const EdgeInsets.only(left: 18).w,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              PageView.builder(
                controller: _pageController,
                itemBuilder: (context, index) {
                  index = index % _movieBannerList.length;
                  return Padding(
                      padding: EdgeInsets.only(left: index > 0 ? 20 : 0),
                      child: GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) {
                                return MovieDetailScreen(
                                    movie: _movieBannerList[index]);
                              },
                            ));
                          },
                          child: CachedImage(
                              url: _movieBannerList[index].thumbnail!)));
                },
              ),
              Positioned(
                bottom: 20,
                child: SmoothPageIndicator(
                  controller: _pageController, // PageController
                  count: _movieBannerList.length,
                  effect: const ExpandingDotsEffect(
                    dotHeight: 12,
                  ), // your preferred effect
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
