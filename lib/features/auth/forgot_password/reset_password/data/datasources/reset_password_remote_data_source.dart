import 'package:chat_up/core/services/remote_auth_service.dart';
import 'package:injectable/injectable.dart';

abstract class ResetPasswordRemoteDataSource {
  Future<void> setNewPassword({
    required String oobCode,
    required String newPassword,
  });
}

@Injectable(as: ResetPasswordRemoteDataSource)
class ResetPasswordRemoteDataSourceImpl
    implements ResetPasswordRemoteDataSource {
  final RemoteAuthService _firebaseAuthService;

  ResetPasswordRemoteDataSourceImpl(this._firebaseAuthService);

  @override
  Future<void> setNewPassword({
    required String oobCode,
    required String newPassword,
  }) {
    return _firebaseAuthService.completePasswordReset(
      oobCode: oobCode,
      newPassword: newPassword,
    );
  }
}
