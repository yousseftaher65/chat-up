abstract class ResetPasswordRepo {
  Future<void> setNewPassword({
    required String oobCode,
    required String newPassword,
  });
}
