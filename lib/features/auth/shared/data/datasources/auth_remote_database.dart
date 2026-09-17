import 'package:chat_up/core/services/remote_database_service.dart';
import 'package:chat_up/features/auth/shared/data/models/user_model.dart';
import 'package:injectable/injectable.dart';

abstract class AuthRemoteDatabase {
  Future<UserModel?> getUser(String id);
  Future<void> setUser(UserModel user);
}

@Injectable(as: AuthRemoteDatabase)
class AuthRemoteDatabaseImpl implements AuthRemoteDatabase {
  final RemoteDatabaseService remoteDatabaseService;

  AuthRemoteDatabaseImpl(this.remoteDatabaseService);
  @override
  Future<UserModel?> getUser(String id) async {
    final document = await remoteDatabaseService.getDocument('users/$id');
    final data = document?.data();

    if (document?.exists != true || data == null) return null;

    return UserModel.fromMap(data);
  }

  @override
  Future<void> setUser(UserModel user) {
    return remoteDatabaseService.set<UserModel>(
      'users/${user.id}',
      user,
      (user) => user.toMap(),
    );
  }
}
