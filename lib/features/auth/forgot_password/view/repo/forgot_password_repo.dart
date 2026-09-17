abstract class ForgotPasswordRepo{
  Future<void> forgotPassword(String email);
  Future<void> sendCode(String digitCode);
}