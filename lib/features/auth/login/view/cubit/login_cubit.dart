import 'package:bloc/bloc.dart';
import 'package:chat_up/core/form_fields/formz_vaild.dart';
import 'package:chat_up/core/form_fields/password.dart';
import 'package:chat_up/features/auth/login/view/cubit/login_state.dart';
import 'package:chat_up/features/auth/login/view/repo/login_repo.dart';
import 'package:injectable/injectable.dart';
import '../../../../../core/form_fields/email.dart';

@injectable
class LoginCubit extends Cubit<LoginState> {
  LoginCubit({required this.loginRepo}) : super(LoginState.initial());

  final LoginRepo loginRepo;

  void resetState() => emit(const LoginState.initial());

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

  void onPasswordUnfocused() {
    emit(state.copyWith(password: Password.dirty(state.password.value)));
  }

  void onEmailUnfocused() {
    emit(state.copyWith(email: Email.dirty(state.email.value)));
  }

  void idle() => emit(state.copyWith(status: LoginStatus.initial));

  Future<void> onLoginPressed() async {
    final email = Email.dirty(state.email.value);
    final passowrd = Password.dirty(state.password.value);
    final isFormValid = FormzValid([email, passowrd]).isFormValid;

    final newState = state.copyWith(
      email: email,
      password: passowrd,
      status: isFormValid ? LoginStatus.loading : null,
    );

    emit(newState);

    if (!isFormValid) return;

    try {
      final user = await loginRepo.login(
        email: email.value,
        password: passowrd.value,
      );

      emit(state.copyWith(status: LoginStatus.success, user: user));
    } catch (e) {
      emit(
        state.copyWith(status: LoginStatus.error, errorMessage: e.toString()),
      );
    }
  }

  Future<void> onLoginWithGooglePressed() async {
    emit(state.copyWith(status: LoginStatus.googleLoginInProgress));
    try {
      final user = await loginRepo.loginWithGoogle();
      emit(state.copyWith(status: LoginStatus.success, user: user));
    } catch (e) {
      emit(
        state.copyWith(
          status: LoginStatus.googleSignInFailure,
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
