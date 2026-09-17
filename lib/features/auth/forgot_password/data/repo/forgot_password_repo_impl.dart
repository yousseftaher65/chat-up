import 'package:chat_up/features/auth/forgot_password/view/repo/forgot_password_repo.dart';
import 'package:injectable/injectable.dart';

import '../datasources/forgot_password_remote_data_source.dart';

@Injectable(as: ForgotPasswordRepo)
class ForgotPasswordRepoImpl implements ForgotPasswordRepo {
  final ForgotPasswordRemoteDataSource remoteDataSource;

  ForgotPasswordRepoImpl({required this.remoteDataSource});
  @override
  Future<void> forgotPassword(String email) {
    // TODO: implement forgotPassword
    throw UnimplementedError();
  }

  @override
  Future<void> sendCode(String digitCode) {
    // TODO: implement sendCode
    throw UnimplementedError();
  }
}
