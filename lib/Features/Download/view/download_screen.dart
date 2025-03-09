import 'package:flutter/material.dart';
import 'package:flutter_movie/constants/custom_colors.dart';
import 'package:flutter_movie/gen/assets.gen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DownloadScreen extends StatelessWidget {
  const DownloadScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextTheme _textTheme = Theme.of(context).textTheme;
    return Scaffold(
        backgroundColor: CustomColors.colorBackground,
        body: CustomScrollView(
          slivers: [
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 130,
                      color: Colors.transparent,
                      child: Row(
                        children: [
                          Assets.images.item20.image(
                            width: 60,
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          Column(
                            children: [
                              const SizedBox(
                                height: 20,
                              ),
                              Text(
                                'name movie',
                                style: _textTheme.titleMedium,
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              Row(
                                children: [
                                  Text(
                                    '6 /10',
                                    style: _textTheme.titleMedium,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Assets.images.icImbd.image(width: 33)
                                ],
                              )
                            ],
                          ),
                          const Spacer(),
                          const Padding(
                            padding: const EdgeInsets.only(right: 16),
                            child: Icon(
                              Icons.download,
                              color: CustomColors.colorOnPrimary,
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
                childCount: 20,
              ),
            )
          ],
        ));
  }
}
