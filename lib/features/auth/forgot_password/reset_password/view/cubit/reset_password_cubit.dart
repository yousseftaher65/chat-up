import 'package:chat_up/features/auth/forgot_password/reset_password/view/cubit/reset_password_state.dart';
import 'package:chat_up/features/auth/forgot_password/reset_password/view/repo/reset_password_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../core/form_fields/form_fields.dart';

@injectable
class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  final ResetPasswordRepo resetPasswordRepo;
  ResetPasswordCubit({required this.resetPasswordRepo})
    : super(ResetPasswordState.initial());

  void onNewPasswordChanged(String newPassword) {
    final newPasswordState = state.newPassword.isNotValid
        ? Password.dirty(newPassword)
        : Password.pure(newPassword);

    final newScreenState = state.copyWith(
      status: ChangePasswordStatus.initial,
      errorMessage: '',
      newPassword: newPasswordState,
    );
    emit(newScreenState);
  }

  void onNewPasswordUnfocused() {
    emit(state.copyWith(newPassword: Password.dirty(state.newPassword.value)));
  }

  void onShowNewPasswordChanged() =>
      emit(state.copyWith(showNewPassword: !state.showNewPassword));

  void onConfirmPasswordChanged(String confirmPassword) {
    final confirmPasswordState = state.confirmPassword.isNotValid
        ? Password.dirty(confirmPassword)
        : Password.pure(confirmPassword);

    final newScreenState = state.copyWith(
      status: ChangePasswordStatus.initial,
      errorMessage: '',
      confirmPassword: confirmPasswordState,
    );
    emit(newScreenState);
  }

  void onConfirmPasswordUnfocused() {
    emit(
      state.copyWith(
        confirmPassword: Password.dirty(state.confirmPassword.value),
      ),
    );
  }

  void onShowConfirmPasswordChanged() =>
      emit(state.copyWith(showConfirmPassword: !state.showConfirmPassword));

  Future<void> updatePassword({required String oobCode}) async {
    final newPassword = state.newPassword.value;
    final confirmPassword = state.confirmPassword.value;

    if (newPassword != confirmPassword) {
      emit(
        state.copyWith(
          status: ChangePasswordStatus.error,
          errorMessage: 'Passwords do not match',
        ),
      );
      return;
    }

    final isFormValid = FormzValid([Password.dirty(newPassword)]).isFormValid;

    final newState = state.copyWith(
      status: isFormValid ? ChangePasswordStatus.loading : null,
    );

    emit(newState);

    if (!isFormValid) return;

    emit(state.copyWith(status: ChangePasswordStatus.loading));
    try {
      await resetPasswordRepo.setNewPassword(
        oobCode: oobCode,
        newPassword: newPassword,
      );
      emit(state.copyWith(status: ChangePasswordStatus.success));
    } catch (e) {
      emit(
        state.copyWith(
          status: ChangePasswordStatus.error,
          errorMessage: (e.toString()),
        ),
      );
    }
  }
}
