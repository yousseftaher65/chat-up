import 'package:chat_up/features/auth/shared/data/datasources/auth_local_data_source.dart';
import 'package:chat_up/features/auth/shared/data/datasources/auth_remote_database.dart';
import 'package:chat_up/features/auth/shared/data/models/user_model.dart';
import 'package:chat_up/features/auth/signup/view/repo/signup_repo.dart';
import 'package:injectable/injectable.dart';
import '../datasources/signup_remote_data_source.dart';

@Injectable(as: SignupRepo)
class SignupRepoImpl implements SignupRepo {
  final AuthRemoteDatabase authRemoteDatabase;
  final SignupRemoteDataSource remoteDataSource;
  final AuthLocalDataSource authlocalDataSource;

  SignupRepoImpl({
    required this.remoteDataSource,
    required this.authRemoteDatabase,
    required this.authlocalDataSource,
  });
  @override
  Future<UserModel> createAccount({
    required String email,
    required String password,
    required String fullname,
  }) async {
    final userCredential = await remoteDataSource.signUp(
      email: email,
      password: password,
      fullname: fullname,
    );

    final user = userCredential;

    await authlocalDataSource.cacheUser(user);

    await authRemoteDatabase.setUser(user);

    return user;
  }

  @override
  Future<UserModel> loginWithGoogle() async {
    final userCredential = await remoteDataSource.loginWithGoogle();

    final storedUser = await authRemoteDatabase.getUser(userCredential.id);
    final user = storedUser ?? userCredential;

    await authRemoteDatabase.setUser(user);

    await authlocalDataSource.cacheUser(user);

    return user;
  }
}
