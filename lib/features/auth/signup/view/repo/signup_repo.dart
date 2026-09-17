import 'package:chat_up/features/auth/shared/data/models/user_model.dart';

abstract class SignupRepo {
  Future<UserModel> createAccount({
    required String email,
    required String password,
    required String fullname,
  });

  Future<UserModel> loginWithGoogle();
}
