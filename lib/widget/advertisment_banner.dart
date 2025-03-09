import 'package:flutter/material.dart';
import 'package:flutter_movie/Features/Home/data/model/advertisment.dart';
import 'package:flutter_movie/widget/cached_network_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:url_launcher/url_launcher.dart';

class AdvertismentBanner extends StatelessWidget {
  final List<Advertisment> _advertismentList;
  const AdvertismentBanner(
      {super.key, required List<Advertisment> advertismentList})
      : _advertismentList = advertismentList;

  @override
  Widget build(BuildContext context) {
    final PageController _pageController =
        PageController(viewportFraction: 0.85.w);

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
                itemCount: _advertismentList.length,
                itemBuilder: (context, index) {
                  return Padding(
                      padding: EdgeInsets.only(left: index > 0 ? 20 : 0),
                      child: GestureDetector(
                        onTap: () async {
                          var urlSite = _advertismentList[index].urlSite!;
                          if (urlSite.isNotEmpty) {
                            launchUrl(Uri.parse(urlSite));
                          }
                        },
                        child: CachedImage(
                            url: _advertismentList[index].thumbnail ?? ''),
                      ));
                },
              ),
              Positioned(
                bottom: 10,
                child: SmoothPageIndicator(
                  controller: _pageController, // PageController
                  count: _advertismentList.length,
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
