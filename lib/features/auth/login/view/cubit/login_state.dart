import 'package:chat_up/features/auth/shared/data/models/user_model.dart';
import 'package:equatable/equatable.dart';
import '../../../../../core/form_fields/form_fields.dart';

enum LoginStatus {
  initial,
  loading,
  success,
  invalidCredentials,
  userNotFound,
  googleSignInFailure,
  googleLoginInProgress,
  networkError,
  error;

  bool get isInitial => this == LoginStatus.initial;
  bool get isLoading => this == LoginStatus.loading;
  bool get isSuccess => this == LoginStatus.success;
  bool get isInvalidCredentials => this == LoginStatus.invalidCredentials;
  bool get isGoogleLoginInProgress => this == LoginStatus.googleLoginInProgress;
  bool get isUserNotFound => this == LoginStatus.userNotFound;
  bool get isNetworkError => this == LoginStatus.networkError;
  bool get isGoogleSignInFailure => this == LoginStatus.googleSignInFailure;
  bool get isError =>
      this == LoginStatus.error ||
      isInvalidCredentials ||
      isUserNotFound ||
      isNetworkError;
}

class LoginState extends Equatable {
  final LoginStatus status;
  final String? errorMessage;
  final Password password;
  final Email email;
  final bool showPassword;
  final UserModel? user;
  const LoginState._({
    required this.status,
    this.errorMessage,
    required this.email,
    required this.password,
    required this.showPassword,
    this.user,
  });

  const LoginState.initial()
    : this._(
        status: LoginStatus.initial,
        errorMessage: '',
        email: const Email.pure(),
        password: const Password.pure(),
        showPassword: false,
        user: null
      );

  LoginState copyWith({
    LoginStatus? status,
    String? errorMessage,
    Email? email,
    Password? password,
    bool? showPassword,
    UserModel? user
  }) {
    return LoginState._(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      showPassword: showPassword ?? this.showPassword,
      email: email ?? this.email,
      password: password ?? this.password,
      user: user ?? this.user
    );
  }

  @override
  List<Object?> get props => [
    status,
    errorMessage,
    email,
    password,
    showPassword,
    user
  ];
}
