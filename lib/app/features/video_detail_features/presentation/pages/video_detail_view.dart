import 'package:dailymotion_app/app/common/theme/app_styles/app_styles.dart';
import 'package:dailymotion_app/app/features/home_features/data/remote/entities/video_entity.dart';
import 'package:dailymotion_app/app/features/video_detail_features/presentation/cubit/channel_cubit.dart';
import 'package:dailymotion_app/app/features/video_detail_features/presentation/widgets/video_title.dart';
import 'package:dailymotion_app/app/features/video_detail_features/presentation/widgets/channel_info_builder.dart';
import 'package:dailymotion_app/app/common/constants/app_constants.dart';
import 'package:dailymotion_app/app/common/routing/route_observer.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import 'package:webview_flutter/webview_flutter.dart';

class VideoDetailPage extends StatefulWidget {
  final VideoEntity video;
  const VideoDetailPage({super.key, required this.video});

  @override
  State<VideoDetailPage> createState() => _VideoDetailPageState();
}

class _VideoDetailPageState extends State<VideoDetailPage>
    with WidgetsBindingObserver, RouteAware {
  late final WebViewController _controller;
  late final ChannelCubit _channelCubit;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(widget.video.url));

    _channelCubit = GetIt.I<ChannelCubit>()..fetchChannel(widget.video.owner);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    WidgetsBinding.instance.removeObserver(this);

    try {
      _controller.loadRequest(Uri.parse('about:blank'));
    } catch (_) {}
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.inactive ||
        state == AppLifecycleState.paused) {
      _pauseMedia();
    }
  }

  @override
  void didPushNext() {
    _pauseAndUnload();
  }

  @override
  void didPopNext() {
    _reloadVideo();
  }

  Future<void> _pauseMedia() async {
    try {
      await _controller.runJavaScript("document.querySelectorAll('video,audio')"
          ".forEach(e=>{try{e.pause();}catch(_){}});");
    } catch (_) {}
  }

  Future<void> _pauseAndUnload() async {
    await _pauseMedia();
    try {
      await _controller.loadRequest(Uri.parse('about:blank'));
    } catch (_) {}
  }

  Future<void> _reloadVideo() async {
    try {
      await _controller.loadRequest(Uri.parse(widget.video.url));
    } catch (_) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppConstants.appName,
          style: AppTextStyles.heading1Bold(context),
        ),
      ),
      body: BlocBuilder<ChannelCubit, ChannelState>(
        bloc: _channelCubit,
        builder: (context, state) {
          if (state is ChannelLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ChannelError) {
            return const AppErrorHandling();
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.26,
                width: double.infinity,
                child: WebViewWidget(controller: _controller),
              ),
              const SizedBox(height: 8),
              VideoTitleSection(title: widget.video.title, video: widget.video),
              const Divider(height: 0),
              Expanded(child: ChannelInfoBuilder(cubit: _channelCubit)),
            ],
          );
        },
      ),
    );
  }
}
