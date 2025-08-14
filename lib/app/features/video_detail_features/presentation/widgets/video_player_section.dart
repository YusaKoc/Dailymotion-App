import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:webview_flutter/webview_flutter.dart';

class VideoPlayerSection extends StatelessWidget {
  final WebViewController controller;

  const VideoPlayerSection({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.sized.dynamicHeight(0.26),
      width: double.infinity,
      child: WebViewWidget(controller: controller),
    );
  }
}
