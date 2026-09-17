import 'package:chat_up/features/auth/signup/view/cubit/signup_states.dart';
import 'package:chat_up/features/auth/signup/view/repo/signup_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/form_fields/form_fields.dart';

@injectable
class SignupCubit extends Cubit<SignupState> {
  final SignupRepo signupRepo;
  SignupCubit({required this.signupRepo}) : super(SignupState.initial());

  void resetState() => emit(const SignupState.initial());

  void onEmailChanged(String email) {
    final newEmailState = state.email.isNotValid
        ? Email.dirty(email)
        : Email.pure(email);

    final newScreenState = state.copyWith(email: newEmailState);

    emit(newScreenState);
  }

  void onPasswordChanged(String password) {
    final newPasswordState = state.password.isNotValid
        ? Password.dirty(password)
        : Password.pure(password);

    final newScreenState = state.copyWith(password: newPasswordState);
    emit(newScreenState);
  }

  void onShowPasswordChanged() =>
      emit(state.copyWith(showPassword: !state.showPassword));

  void onAgreeChanged(bool? isAgree) =>
      emit(state.copyWith(isAgree: isAgree ?? false));

  void onPasswordUnfocused() {
    emit(state.copyWith(password: Password.dirty(state.password.value)));
  }

  void onEmailUnfocused() {
    emit(state.copyWith(email: Email.dirty(state.email.value)));
  }

  void idle() => emit(state.copyWith(status: SignupStatus.initial));

  Future<void> onSignupPressed() async {
    final email = Email.dirty(state.email.value);
    final passowrd = Password.dirty(state.password.value);
    final fullname = FullName.dirty(state.fullname.value);
    final isFormValid =
        FormzValid([email, passowrd, fullname]).isFormValid && state.isAgree;

    final newState = state.copyWith(
      email: email,
      password: passowrd,
      fullname: fullname,
      status: isFormValid ? SignupStatus.loading : null,
    );

    emit(newState);

    if (!isFormValid) return;

    try {
      final user = await signupRepo.createAccount(
        email: state.email.value,
        password: state.password.value,
        fullname: state.fullname.value,
      );

      emit(state.copyWith(status: SignupStatus.success, user: user));
    } catch (e) {
      emit(
        state.copyWith(status: SignupStatus.error, errorMessage: e.toString()),
      );
    }
  }

  void onFullNameUnfocused() {
    emit(state.copyWith(fullname: FullName.dirty(state.fullname.value)));
  }

  void onFullNameChanged(String value) {
    final newFullNameState = state.fullname.isNotValid
        ? FullName.dirty(value)
        : FullName.pure(value);

    final newScreenState = state.copyWith(fullname: newFullNameState);
    emit(newScreenState);
  }

  Future<void> onLoginWithGooglePressed() async {
    emit(state.copyWith(status: SignupStatus.googleLoginInProgress));
    try {
      final user = await signupRepo.loginWithGoogle();
      emit(state.copyWith(status: SignupStatus.success, user: user));
    } catch (e) {
      emit(
        state.copyWith(
          status: SignupStatus.googleSignInFailure,
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
