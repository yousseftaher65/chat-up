import 'package:chat_up/features/auth/forgot_password/view/cubit/forgot_password_state.dart';
import 'package:chat_up/features/auth/forgot_password/view/repo/forgot_password_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/form_fields/form_fields.dart';

@injectable
class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  final ForgotPasswordRepo forgotPasswordRepo;
  ForgotPasswordCubit({required this.forgotPasswordRepo})
    : super(ForgotPasswordState.initial());

  void onEmailChanged(String email) {
    final newEmailState = state.email.isNotValid
        ? Email.dirty(email)
        : Email.pure(email);

    final newScreenState = state.copyWith(email: newEmailState);

    emit(newScreenState);
  }

  void onEmailUnfocused() {
    emit(state.copyWith(email: Email.dirty(state.email.value)));
  }

  void sendPasswordResetEmail() async {
    final email = Email.dirty(state.email.value);
    final isFormValid = FormzValid([email]).isFormValid;

    final newState = state.copyWith(
      email: email,
      status: isFormValid ? ForgotPasswordStatus.loading : null,
    );

    emit(newState);

    if (!isFormValid) return;

    try {
      await forgotPasswordRepo.sendPasswordResetEmail(email.value);

      emit(state.copyWith(status: ForgotPasswordStatus.success));
    } catch (e) {
      emit(
        state.copyWith(
          status: ForgotPasswordStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  void resetState() {
    emit(ForgotPasswordState.initial());
  }
}
