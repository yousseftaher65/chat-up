import 'package:chat_up/core/services/cache_service.dart';
import 'package:chat_up/features/auth/shared/data/models/user_model.dart';
import 'package:injectable/injectable.dart';

abstract class AuthLocalDataSource {
  Future<void> cacheUser(UserModel user);
  Future<UserModel?> getCachedUser();
  Future<void> removeUser();
}

const kUserKey = 'USER_CACHE_KEY';

@Injectable(as: AuthLocalDataSource)
class LoginLocalDataSourceImpl implements AuthLocalDataSource {
  final CacheService cacheService;

  LoginLocalDataSourceImpl(this.cacheService);
  @override
  Future<void> removeUser() {
    return cacheService.remove(kUserKey);
  }

  @override
  Future<void> cacheUser(UserModel user) {
    return cacheService.setString(kUserKey, user.toJson());
  }

  @override
  Future<UserModel?> getCachedUser() async {
    final userJson = await cacheService.getString(kUserKey);

    if (userJson == null) {
      return null;
    }

    return UserModel.fromJson(userJson);
  }
}
