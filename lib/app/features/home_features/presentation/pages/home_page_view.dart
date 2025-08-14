import 'dart:async';
import 'package:dailymotion_app/app/common/constants/enum/category_enum.dart';
import 'package:dailymotion_app/app/features/home_features/presentation/cubit/video_cubit.dart';
import 'package:dailymotion_app/app/features/home_features/presentation/widgets/tab_view.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:dailymotion_app/app/features/home_features/presentation/widgets/home_app_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  final categories = HomeCategory.values;

  late final TabController _tabController;
  final List<VideoCubit> _cubits = [];
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: categories.length, vsync: this);
    _tabController.addListener(_handleTabChange);

    for (final category in categories) {
      final cubit = GetIt.I<VideoCubit>();
      cubit.loadVideos(category.name);
      _cubits.add(cubit);
    }
  }

  void _handleTabChange() {
    final index = _tabController.index;
    final category = categories[index];
    _cubits[index].loadVideos(category.name);
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _tabController.removeListener(_handleTabChange);
    _tabController.dispose();
    for (final c in _cubits) {
      c.close();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeAppBar(
        controller: _tabController,
        categories: categories,
      ),
      body: HomeTabView(
        controller: _tabController,
        categories: categories,
        cubits: _cubits,
      ),
    );
  }
}
