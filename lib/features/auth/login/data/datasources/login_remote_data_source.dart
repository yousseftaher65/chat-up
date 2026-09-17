import 'package:chat_up/core/services/remote_auth_service.dart';
import 'package:chat_up/features/auth/shared/data/models/user_model.dart';
import 'package:injectable/injectable.dart';

abstract class LoginRemoteDataSource {
  Future<UserModel> login({required String email, required String password});
  Future<UserModel> loginWithGoogle();
}

@Injectable(as: LoginRemoteDataSource)
class RemoteDataSourceImpl implements LoginRemoteDataSource {
  final RemoteAuthService _firebaseAuthService;

  RemoteDataSourceImpl(this._firebaseAuthService);

  @override
  Future<UserModel> loginWithGoogle() {
    final userModel = _firebaseAuthService.loginWithGoogle();
    return userModel;
  }

  @override
  Future<UserModel> login({required String email, required String password}) {
    final userModel = _firebaseAuthService.login(
      email: email,
      password: password,
    );
    return userModel;
  }
}
