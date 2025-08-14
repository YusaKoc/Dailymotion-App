import 'package:dailymotion_app/app/features/user_profile_features/data/datasource/user_remote_data_source.dart';

abstract class UserRepository {
  Future<Map<String, dynamic>?> getProfile();
}

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource remoteDataSource;

  UserRepositoryImpl(this.remoteDataSource);

  @override
  Future<Map<String, dynamic>?> getProfile() {
    return remoteDataSource.fetchUserProfile();
  }
}
