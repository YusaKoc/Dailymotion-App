import 'package:dailymotion_app/app/features/favorites_features/data/entities/favorites_entity.dart';
import 'package:dailymotion_app/app/features/favorites_features/presentation/cubit/favorite_cubit.dart';
import 'package:dailymotion_app/app/features/favorites_features/presentation/cubit/favorite_state.dart';
import 'package:dailymotion_app/app/features/home_features/data/remote/entities/video_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoriteButton extends StatelessWidget {
  final VideoEntity video;
  const FavoriteButton({super.key, required this.video});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<FavoriteCubit, FavoriteState, bool>(
      selector: (state) {
        if (state is FavoriteLoaded) {
          return state.favorites.any((f) => f.videoId == video.id);
        }

        return context.read<FavoriteCubit>().isFavLocal(video.id);
      },
      builder: (context, isFav) {
        return IconButton(
          icon: Icon(isFav ? Icons.favorite : Icons.favorite_border),
          color: isFav ? Colors.red : null,
          onPressed: () {
            final fav = FavoriteEntity(
              videoId: video.id,
              title: video.title,
              thumbnailUrl: video.thumbnailUrl,
              videoUrl: video.url,
              owner: video.owner,
            );
            context.read<FavoriteCubit>().toggleFavorite(fav);
          },
        );
      },
    );
  }
}
