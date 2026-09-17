import 'package:chat_up/core/services/remote_auth_service.dart';
import 'package:chat_up/features/auth/shared/data/models/user_model.dart';
import 'package:injectable/injectable.dart';

abstract class SignupRemoteDataSource {
  Future<UserModel> signUp({
    required String email,
    required String password,
    required String fullname,
  });

  Future<UserModel> loginWithGoogle();
}

@Injectable(as: SignupRemoteDataSource)
class RemoteDataSourceImpl implements SignupRemoteDataSource {
  final RemoteAuthService _firebaseAuthService;
  RemoteDataSourceImpl(this._firebaseAuthService);
  @override
  Future<UserModel> signUp({
    required String email,
    required String password,
    required String fullname,
  }) {
    return _firebaseAuthService.signup(
      email: email,
      password: password,
      fullname: fullname,
    );
  }

  @override
  Future<UserModel> loginWithGoogle() {
    final userModel = _firebaseAuthService.loginWithGoogle();
    return userModel;
  }
}
