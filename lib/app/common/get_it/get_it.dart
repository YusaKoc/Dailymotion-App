import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dailymotion_app/app/common/theme/theme_cubit.dart';
import 'package:dailymotion_app/core/utils/network_info.dart';
import 'package:dailymotion_app/app/common/widgets/bottomnavbar/navbar_cubit.dart';
import 'package:dailymotion_app/app/features/auth_features/data/datasources/auth_remote_data_source.dart';
import 'package:dailymotion_app/app/features/auth_features/data/repository/auth_repo_impl.dart';
import 'package:dailymotion_app/app/features/auth_features/data/repository/auth_repository.dart';
import 'package:dailymotion_app/app/features/auth_features/data/usecases/login_user.dart';
import 'package:dailymotion_app/app/features/auth_features/data/usecases/logout_user.dart';
import 'package:dailymotion_app/app/features/auth_features/data/usecases/register_user.dart';
import 'package:dailymotion_app/app/features/auth_features/presentation/cubit/login_cubit.dart';
import 'package:dailymotion_app/app/features/auth_features/presentation/cubit/logout_cubit.dart';
import 'package:dailymotion_app/app/features/auth_features/presentation/cubit/register_cubit.dart';
import 'package:dailymotion_app/app/features/channel_detail_features/data/datasources/channel_remote_data_sources.dart';
import 'package:dailymotion_app/app/features/channel_detail_features/data/repository/channel_video_repo.dart';
import 'package:dailymotion_app/app/features/channel_detail_features/data/usecases/channel_video_usecase.dart';
import 'package:dailymotion_app/app/features/channel_detail_features/presentation/cubit/channel_video_cubit.dart';
import 'package:dailymotion_app/app/features/favorites_features/data/datasources/favori_remote_data_source.dart';
import 'package:dailymotion_app/app/features/favorites_features/data/repository/favori_repository.dart';
import 'package:dailymotion_app/app/features/favorites_features/data/usecase/favori_usecase.dart';
import 'package:dailymotion_app/app/features/favorites_features/presentation/cubit/favorite_cubit.dart';
import 'package:dailymotion_app/app/features/home_features/data/local/local_video_datasource/local_video_data_source.dart';
import 'package:dailymotion_app/app/features/home_features/data/local/model_local/local_video_model.dart';
import 'package:dailymotion_app/app/features/home_features/data/remote/datasources/video_remote_data_source.dart';
import 'package:dailymotion_app/app/features/home_features/data/repository/video_repository_impl.dart';
import 'package:dailymotion_app/app/features/home_features/data/repository/videp_repo.dart';
import 'package:dailymotion_app/app/features/home_features/data/usecases/fetch_videos.dart';
import 'package:dailymotion_app/app/features/home_features/data/usecases/search_usecase.dart';
import 'package:dailymotion_app/app/features/home_features/presentation/cubit/video_cubit.dart';
import 'package:dailymotion_app/app/features/search_features/presentation/cubit/search_cubit.dart';
import 'package:dailymotion_app/app/features/subs_features/data/datasource/subs_remote_data_source.dart';
import 'package:dailymotion_app/app/features/subs_features/data/usecases/subs_usecase.dart';
import 'package:dailymotion_app/app/features/subs_features/presentation/cubit/subs_cubit.dart';
import 'package:dailymotion_app/app/features/subs_features/data/repository/subs_repo.dart';
import 'package:dailymotion_app/app/features/user_profile_features/data/datasource/profile_remote_data_source.dart';
import 'package:dailymotion_app/app/features/user_profile_features/data/datasource/user_remote_data_source.dart';
import 'package:dailymotion_app/app/features/user_profile_features/data/repository/profile_repo.dart';
import 'package:dailymotion_app/app/features/user_profile_features/data/repository/user_repo.dart';
import 'package:dailymotion_app/app/features/user_profile_features/data/usecases/profile_usecase.dart';
import 'package:dailymotion_app/app/features/user_profile_features/presentation/cubit/profile_cubit.dart';
import 'package:dailymotion_app/app/features/video_detail_features/data/datasources/channel_data_remote_source.dart';
import 'package:dailymotion_app/app/features/video_detail_features/data/repository/channel_repository.dart';
import 'package:dailymotion_app/app/features/video_detail_features/data/usecases/get_channel_detail.dart';
import 'package:dailymotion_app/app/features/video_detail_features/presentation/cubit/channel_cubit.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //Core Widgets
  sl.registerLazySingleton<NavigationCubit>(() => NavigationCubit());
  final box = await Hive.openBox('settings');
  sl.registerLazySingleton<Box>(() => box);
  sl.registerLazySingleton<ThemeCubit>(() => ThemeCubit(sl<Box>()));

  //Firebase Core
  sl.registerLazySingleton<FirebaseStorage>(() => FirebaseStorage.instance);
  sl.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
  sl.registerLazySingleton<FirebaseFirestore>(() => FirebaseFirestore.instance);
  // Auth
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(
      firebaseAuth: sl(),
      firestore: sl(),
    ),
  );
  sl.registerLazySingleton(() => LogoutUser(sl()));
  sl.registerFactory(() => LogoutCubit(sl()));
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl());
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(
        remoteDataSource: sl(),
        firebaseAuth: sl(),
        networkInfo: sl(),
      ));
  sl.registerLazySingleton(() => RegisterUser(sl()));
  sl.registerLazySingleton(() => LoginUser(sl()));
  sl.registerFactory(() => RegisterCubit(sl()));
  sl.registerFactory(() => LoginCubit(sl()));

  //Video Repository and UseCase

  sl.registerLazySingleton<VideoLocalDataSource>(
    () => VideoLocalDataSourceImpl(Hive.box<LocalVideoModel>('videos')),
  );

  sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton<VideoRemoteDataSource>(
      () => VideoRemoteDataSourceImpl(dio: sl()));
  sl.registerLazySingleton<VideoRepository>(() => VideoRepositoryImpl(
        remoteDataSource: sl(),
        localDataSource: sl(),
        networkInfo: sl(),
      ));
  sl.registerLazySingleton(() => FetchVideos(sl()));
  sl.registerLazySingleton(() => SearchVideos(sl()));
  sl.registerFactory<VideoCubit>(() => VideoCubit(
        sl<FetchVideos>(),
        sl<SearchVideos>(),
      ));

  // Channel Detail Data
  sl.registerLazySingleton<ChannelRemoteDataSource>(
      () => ChannelRemoteDataSourceImpl(sl()));
  sl.registerLazySingleton<ChannelRepository>(
      () => ChannelRepositoryImpl(sl(), sl()));
  sl.registerLazySingleton(() => GetChannelDetail(sl()));
  sl.registerFactory(() => ChannelCubit(sl()));

  // Channel Video Data
  sl.registerLazySingleton<ChannelVideosRemoteDataSource>(
      () => ChannelVideosRemoteDataSourceImpl(sl<Dio>()));

  sl.registerLazySingleton<ChannelVideosRepository>(
      () => ChannelVideosRepositoryImpl(sl(), sl()));

  sl.registerLazySingleton(() => FetchChannelVideos(sl()));
  sl.registerFactory(() => ChannelVideosCubit(sl(), sl()));

  //Favorites
  sl.registerLazySingleton<FavoriteRemoteDataSource>(
    () => FavoriteRemoteDataSourceImpl(sl(), sl()),
  );
  sl.registerLazySingleton<FavoriteRepository>(
      () => FavoriteRepositoryImpl(sl(), sl()));
  sl.registerLazySingleton(() => GetFavorites(sl()));
  sl.registerLazySingleton(() => AddFavorite(sl()));
  sl.registerLazySingleton(() => RemoveFavorite(sl()));
  sl.registerLazySingleton(() => IsFavorite(sl()));
  sl.registerFactory(() => FavoriteCubit(
        addFavorite: sl(),
        removeFavorite: sl(),
        getFavorites: sl(),
        isFavorite: sl(),
        repo: sl(),
      ));

  // Subscription
  sl.registerLazySingleton<SubscriptionRemoteDataSource>(
      () => SubscriptionRemoteDataSourceImpl(sl(), sl()));
  sl.registerLazySingleton<SubscriptionRepository>(
      () => SubscriptionRepositoryImpl(sl()));

  sl.registerLazySingleton(() => ToggleSubscription(sl()));
  sl.registerLazySingleton(() => IsSubscribed(sl()));
  sl.registerLazySingleton(() => GetSubscriptions(sl()));

  sl.registerFactory(() => SubscriptionCubit(sl(), sl(), sl()));

//profile - Related

  sl.registerLazySingleton<UserRemoteDataSource>(
    () => UserRemoteDataSourceImpl(sl(), sl()),
  );
  sl.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(sl()),
  );

  sl.registerLazySingleton<ProfileRemoteDataSource>(
      () => ProfileRemoteDataSourceImpl(sl(), sl(), sl()));

  sl.registerLazySingleton<ProfileRepository>(
      () => ProfileRepositoryImpl(sl(), sl()));

  sl.registerLazySingleton(() => UploadProfilePhotoBytes(sl()));
  sl.registerLazySingleton(() => GetUserProfile(sl()));
  sl.registerLazySingleton(() => UploadProfilePhoto(sl()));
  sl.registerLazySingleton(() => UpdateNameSurname(sl()));

  sl.registerFactory(() => ProfileCubit(sl(), sl(), sl(), sl()));

  //search page
  sl.registerFactory(() => SearchCubit());
}
