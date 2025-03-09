import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_movie/Features/WatchMovie/bloc/watch_movie_bloc.dart';
import 'package:flutter_movie/Features/WatchMovie/bloc/watch_movie_state.dart';
import 'package:flutter_movie/util/enum/link_enum.type.dart';
import 'package:flutter_movie/widget/toast.dart';
import 'package:video_player/video_player.dart';

import '../../../DI/get_it.dart';
import '../bloc/watch_movie_event.dart';

class WatchMovieScreen extends StatefulWidget {
  final LinkTypeEnum linkTypeEnum;
  final String movieID;

  const WatchMovieScreen(
      {super.key, required this.linkTypeEnum, required this.movieID});

  @override
  State<WatchMovieScreen> createState() => _WatchMovieScreenState();
}

class _WatchMovieScreenState extends State<WatchMovieScreen> {
  late FlickManager flickManager;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    WatchMovieBloc bloc = locator.get();
    bloc.add(
      WathcMovieRequestEvent(widget.linkTypeEnum, widget.movieID),
    );
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
        body: BlocProvider.value(
      value: bloc,
      child: BlocBuilder<WatchMovieBloc, WatchMovieState>(
        builder: (context, state) {
          if (state is WatchMovieLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is WatchMovieRquestSuccessState) {
            return state.movieLinks.fold((exception) => showToast(exception),
                (movieLinkList) {
              if (movieLinkList[0].part! > 1) {
                movieLinkList.sort((a, b) => movieLinkList[0].part!);
              }
              return ListView.builder(
                itemCount: movieLinkList.length,
                itemBuilder: (context, index) {
                  flickManager = FlickManager(
                    videoPlayerController: VideoPlayerController.networkUrl(
                      Uri.parse(movieLinkList[index].link!),
                    ),
                  );
                  return Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            movieLinkList[index].part.toString(),
                            style: textTheme.titleMedium,
                          ),
                          Text(
                            ':قسمت',
                            style: textTheme.titleMedium,
                          ),
                        ],
                      ),
                      Container(
                        child: FlickVideoPlayer(flickManager: flickManager),
                      )
                    ],
                  );
                },
              );
            });
          }
          return Text('empty');
        },
      ),
    ));
  }
}
