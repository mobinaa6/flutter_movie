import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_movie/DI/get_it.dart';
import 'package:flutter_movie/Features/MovieDetial/data/model/movie_link.dart';
import 'package:flutter_movie/Features/MovieLink/bloc/movie_link_bloc.dart';
import 'package:flutter_movie/Features/MovieLink/bloc/movie_link_event.dart';
import 'package:flutter_movie/Features/MovieLink/bloc/moviie_link_state.dart';
import 'package:flutter_movie/constants/custom_colors.dart';
import 'package:flutter_movie/util/enum/link_enum.type.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';
import 'package:flutter_movie/widget/show_eror_widget.dart';
import 'package:flutter_movie/widget/toast.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:clipboard/clipboard.dart';
import 'package:video_player/video_player.dart';

class LinkScreen extends StatefulWidget {
  final LinkTypeEnum linkTypeEnum;
  final String movieID;
  const LinkScreen({
    super.key,
    required this.linkTypeEnum,
    required this.movieID,
  });
  @override
  State<LinkScreen> createState() => _LinkScreenState();
}

class _LinkScreenState extends State<LinkScreen> {
  VideoPlayerController getVideoPlayerController(String url) {
    final videoPlayerController =
        VideoPlayerController.networkUrl(Uri.parse(url))..initialize();

    return videoPlayerController;
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: SafeArea(
          child: BlocProvider(
        create: (context) {
          var bloc = MovieLinkBloc(locator.get());
          bloc.add(MovieLinkRequestEvent(widget.movieID, widget.linkTypeEnum));
          return bloc;
        },
        child: BlocBuilder<MovieLinkBloc, MovieLinkState>(
          builder: (context, state) {
            if (state is MovieLinkLoadingState) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is MovieLinkRequestSuccessState) {
              return CustomScrollView(
                slivers: [
                  state.movieLinkList.fold(
                    (exception) => ShowErrorWidget(exception: exception),
                    (movieLinkList) {
                      movieLinkList.sort(
                        (a, b) => movieLinkList[0].part!,
                      );
                      return SliverList(
                          delegate:
                              SliverChildBuilderDelegate((context, index) {
                        return LinkItemWidget(movieLink: movieLinkList[index]);
                      }, childCount: movieLinkList.length));
                    },
                  ),
                ],
              );
            }
            return const Text('empty');
          },
        ),
      )),
    );
  }
}

class LinkItemWidget extends StatefulWidget {
  const LinkItemWidget({super.key, required this.movieLink});

  final MovieLink movieLink;

  @override
  State<LinkItemWidget> createState() => _LinkItemWidgetState();
}

class _LinkItemWidgetState extends State<LinkItemWidget> {
  double _progress = 0.0;
  bool isClickedDownload = false;
  bool isCompeleteDownload = false;
  bool isStartDownload = false;
  int downloadTaskId = 0;
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      height: 50,
      decoration: BoxDecoration(
        border: Border.all(
          width: 0.1,
          color: CustomColors.colorPrimary,
        ),
      ),
      child: Row(
        children: [
          const SizedBox(
            width: 5,
          ),
          Text(
            widget.movieLink.part.toString(),
            textDirection: TextDirection.ltr,
            style: textTheme.titleMedium,
          ),
          IconButton(
            onPressed: () {
              FlutterClipboard.copy(widget.movieLink.link!).then(
                (value) => showToast('کپی شد'),
              );
            },
            icon: const Icon(
              Icons.copy,
              color: CustomColors.colorPrimary,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Flexible(
            child: Text(
              widget.movieLink.link!,
              style: const TextStyle(
                color: Colors.white,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          IconButton(
            onPressed: () async {
              setState(() {
                isStartDownload = !isStartDownload;
              });
              if (isStartDownload) {
                await FileDownloader.downloadFile(
                    url: widget.movieLink.link!,
                    notificationType: NotificationType.all,
                    onDownloadRequestIdReceived: (downloadId) {
                      downloadTaskId = downloadId;
                    },
                    onProgress: (String? fileName, double progress) {
                      print(progress / 100);
                      setState(() {
                        _progress = progress / 100;
                      });
                    },
                    onDownloadCompleted: (String path) {
                      setState(() {
                        isCompeleteDownload = true;
                        isStartDownload = false;
                      });
                      showToast('فیلم شما دانلود شد');
                    },
                    onDownloadError: (String error) {});
              } else {
                await FileDownloader.cancelDownload(downloadTaskId);
                setState(() {
                  isStartDownload = false;
                });
              }
            },
            icon: Icon(
              isStartDownload ? Icons.pause : Icons.download,
              color: CustomColors.colorPrimary,
            ),
          ),
          Stack(
            children: [
              Visibility(
                visible: isStartDownload,
                child: CircularPercentIndicator(
                  radius: 20.0,
                  lineWidth: 3,
                  percent: _progress,
                  center: Text("${_progress * 100}",
                      style: Theme.of(context).textTheme.labelLarge),
                  progressColor: Colors.green,
                ),
              ),
              Visibility(
                visible: isCompeleteDownload,
                child: Icon(
                  Icons.done,
                  color: Colors.green,
                ),
              )
            ],
          ),
          SizedBox(
            width: 10,
          )
        ],
      ),
    );
  }
}
