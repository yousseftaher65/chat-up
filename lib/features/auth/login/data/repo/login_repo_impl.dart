import 'package:chat_up/features/auth/shared/data/datasources/auth_local_data_source.dart';
import 'package:chat_up/features/auth/shared/data/models/user_model.dart';
import 'package:chat_up/features/auth/login/view/repo/login_repo.dart';
import 'package:injectable/injectable.dart';

import '../datasources/login_remote_data_source.dart';
import '../../../shared/data/datasources/auth_remote_database.dart';

@Injectable(as: LoginRepo)
class LoginRepoImpl implements LoginRepo {
  final LoginRemoteDataSource remoteDataSource;
  final AuthLocalDataSource localDataSource;
  final AuthRemoteDatabase authRemoteDatabase;

  LoginRepoImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.authRemoteDatabase,
  });
  @override
  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    final userCredential = await remoteDataSource.login(
      email: email,
      password: password,
    );

    final storedUser = await authRemoteDatabase.getUser(userCredential.id);
    final user = storedUser ?? userCredential;

    await authRemoteDatabase.setUser(user);

    await localDataSource.cacheUser(user);

    return user;
  }

  @override
  Future<UserModel> loginWithGoogle() async {
    final userCredential = await remoteDataSource.loginWithGoogle();

    final storedUser = await authRemoteDatabase.getUser(userCredential.id);
    final user = storedUser ?? userCredential;

    await authRemoteDatabase.setUser(user);

    await localDataSource.cacheUser(user);

    return user;
  }

  @override
  Future<UserModel?> getUser() {
    return localDataSource.getCachedUser();
  }
}
