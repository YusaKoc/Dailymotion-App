import 'package:dailymotion_app/app/common/constants/enum/category_enum.dart';
import 'package:flutter/material.dart';
import 'package:dailymotion_app/app/features/home_features/presentation/cubit/video_cubit.dart';
import 'package:dailymotion_app/app/features/home_features/presentation/widgets/video_list_view.dart';

class HomeTabView extends StatelessWidget {
  final TabController controller;
  final List<HomeCategory> categories;
  final List<VideoCubit> cubits;

  const HomeTabView({
    super.key,
    required this.controller,
    required this.categories,
    required this.cubits,
  });

  @override
  Widget build(BuildContext context) {
    return TabBarView(
      controller: controller,
      children: List.generate(
        categories.length,
        (index) => VideoListView(
          videoCubit: cubits[index],
          selectedCategory: categories[index].name,
        ),
      ),
    );
  }
}
