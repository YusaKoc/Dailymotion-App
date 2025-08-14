import 'package:dailymotion_app/app/common/theme/app_styles/app_styles.dart';
import 'package:dailymotion_app/app/features/favorites_features/presentation/cubit/favorite_cubit.dart';
import 'package:dailymotion_app/app/features/favorites_features/presentation/cubit/favorite_state.dart';
import 'package:dailymotion_app/app/features/favorites_features/presentation/widgets/empty_view.dart';
import 'package:dailymotion_app/app/features/favorites_features/presentation/widgets/favorite_list_item.dart';
import 'package:dailymotion_app/app/common/constants/app_constants.dart';
import 'package:dailymotion_app/app/features/favorites_features/presentation/widgets/favorites_search_bar.dart';
import 'package:dailymotion_app/app/features/favorites_features/presentation/widgets/loading_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  @override
  void initState() {
    context.read<FavoriteCubit>().startListening();
    // context.read<FavoriteCubit>().loadFavoritesOnce();
    super.initState();
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
      body: Column(
        children: [
          FavoritesSearchBar(
            onChanged: (q) => context.read<FavoriteCubit>().updateSearch(q),
          ),
          Expanded(
            child: BlocBuilder<FavoriteCubit, FavoriteState>(
              builder: (context, state) {
                if (state is FavoriteLoading) {
                  return const FavoritesLoadingView();
                }

                if (state is FavoriteLoaded) {
                  if (state.favorites.isEmpty) {
                    return const FavoritesEmptyView();
                  }

                  return ListView.builder(
                    padding: AppPadding.vertical8,
                    itemCount: state.favorites.length,
                    itemBuilder: (context, index) =>
                        FavoriteListItem(video: state.favorites[index]),
                  );
                }

                if (state is FavoriteError) {
                  return const AppErrorHandling();
                }

                return const SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
    );
  }
}
