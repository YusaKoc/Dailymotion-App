import 'package:dailymotion_app/app/features/user_profile_features/data/repository/user_repo.dart';

class GetUserProfile {
  final UserRepository repository;

  GetUserProfile(this.repository);

  Future<Map<String, dynamic>?> call() {
    return repository.getProfile();
  }
}
