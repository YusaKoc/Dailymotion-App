import 'dart:async';
import 'package:dailymotion_app/app/common/constants/app_constants.dart';
import 'package:dailymotion_app/app/common/theme/app_styles/app_styles.dart';

import 'package:dailymotion_app/app/features/home_features/presentation/cubit/video_cubit.dart';
import 'package:dailymotion_app/app/features/home_features/presentation/cubit/video_state.dart';

import 'package:dailymotion_app/app/features/search_features/presentation/widgets/empty_view.dart';
import 'package:dailymotion_app/app/features/search_features/presentation/widgets/search_bar_widget.dart';
import 'package:dailymotion_app/app/features/search_features/presentation/widgets/search_offline_banner.dart';
import 'package:dailymotion_app/app/features/search_features/presentation/widgets/search_results_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final VideoCubit _videoCubit = GetIt.I<VideoCubit>();
  final ScrollController _scrollController = ScrollController();

  String _latestQuery = '';
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      if (_latestQuery.isNotEmpty) {
        _videoCubit.loadMoreSearchResults(_latestQuery);
      }
    }
  }

  void _onSearchChanged(String query) {
    _latestQuery = query;
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 600), () {
      if (query.isNotEmpty) {
        _videoCubit.search(query);
      } else {
        _videoCubit.clear();
      }
    });
  }

  void _onClearPressed() {
    _latestQuery = '';
    _videoCubit.clear();
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _videoCubit,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            AppConstants.appName,
            style: AppTextStyles.heading1Bold(context),
          ),
        ),
        body: Column(
          children: [
            SearchBarField(
              onChanged: _onSearchChanged,
              onClearPressed: _onClearPressed,
            ),
            Expanded(
              child: BlocBuilder<VideoCubit, VideoState>(
                builder: (context, state) {
                  if (state.status == VideoStatus.loading &&
                      state.videos.isEmpty) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (state.status == VideoStatus.error &&
                      state.videos.isEmpty) {
                    return const AppErrorHandling();
                  }

                  if (state.videos.isEmpty) {
                    return SearchEmptyView(isOffline: state.isOffline);
                  }

                  return Column(
                    children: [
                      if (state.isOffline) const SearchOfflineBanner(),
                      Expanded(
                        child: SearchResultsList(
                          controller: _scrollController,
                          videos: state.videos,
                          isOffline: state.isOffline,
                          isLoadingMore: state.status == VideoStatus.loading,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
