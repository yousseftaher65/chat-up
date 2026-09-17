import 'package:chat_up/features/auth/shared/data/models/user_model.dart';

abstract class LoginRepo {
  Future<UserModel> login({required String email, required String password});
  Future<UserModel> loginWithGoogle();
  Future<UserModel?> getUser();
}
