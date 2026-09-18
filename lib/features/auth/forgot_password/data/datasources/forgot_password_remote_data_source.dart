import 'package:chat_up/core/services/remote_auth_service.dart';
import 'package:injectable/injectable.dart';

abstract class ForgotPasswordRemoteDataSource {
  Future<void> sendPasswordResetEmail(String email);
}

@Injectable(as: ForgotPasswordRemoteDataSource)
class ForgotPasswordRemoteDataSourceImpl
    implements ForgotPasswordRemoteDataSource {
  final RemoteAuthService _firebaseAuthService;

  ForgotPasswordRemoteDataSourceImpl(this._firebaseAuthService);

  @override
  Future<void> sendPasswordResetEmail(String email) {
    return _firebaseAuthService.sendPasswordResetEmail(email);
  }
}
