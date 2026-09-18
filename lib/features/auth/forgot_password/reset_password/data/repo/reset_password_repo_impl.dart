import 'package:chat_up/features/auth/forgot_password/reset_password/data/datasources/reset_password_remote_data_source.dart';
import 'package:chat_up/features/auth/forgot_password/reset_password/view/repo/reset_password_repo.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ResetPasswordRepo)
class ResetPasswordRepoImpl implements ResetPasswordRepo {
  final ResetPasswordRemoteDataSource resetPasswordDataSource;

  ResetPasswordRepoImpl({required this.resetPasswordDataSource});

  @override
  Future<void> setNewPassword({
    required String oobCode,
    required String newPassword,
  }) {
    return resetPasswordDataSource.setNewPassword(
      oobCode: oobCode,
      newPassword: newPassword,
    );
  }
}
