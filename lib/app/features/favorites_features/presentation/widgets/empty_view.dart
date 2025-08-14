import 'package:flutter/material.dart';

class FavoritesEmptyView extends StatelessWidget {
  const FavoritesEmptyView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("Henüz bir video favorilemediniz."),
    );
  }
}
