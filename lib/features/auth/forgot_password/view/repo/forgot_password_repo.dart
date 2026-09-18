abstract class ForgotPasswordRepo {
  Future<void> sendPasswordResetEmail(String email);
}
