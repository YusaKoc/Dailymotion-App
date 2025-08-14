import 'package:flutter/material.dart';

class ChannelLoadingView extends StatelessWidget {
  const ChannelLoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator());
  }
}
