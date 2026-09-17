import 'package:chat_up/core/form_fields/email.dart';
import 'package:chat_up/core/form_fields/full_name.dart';
import 'package:chat_up/core/form_fields/password.dart';
import 'package:chat_up/features/auth/shared/data/models/user_model.dart';
import 'package:equatable/equatable.dart';

enum SignupStatus {
  initial,
  loading,
  success,
  invalidCredentials,
  userNotFound,
  googleSignInFailure,
  googleLoginInProgress,
  networkError,
  error;

  bool get isInitial => this == SignupStatus.initial;
  bool get isLoading => this == SignupStatus.loading;
  bool get isSuccess => this == SignupStatus.success;
  bool get isInvalidCredentials => this == SignupStatus.invalidCredentials;
  bool get isGoogleLoginInProgress =>
      this == SignupStatus.googleLoginInProgress;
  bool get isUserNotFound => this == SignupStatus.userNotFound;
  bool get isNetworkError => this == SignupStatus.networkError;
  bool get isGoogleSignInFailure => this == SignupStatus.googleSignInFailure;
  bool get isError =>
      this == SignupStatus.error ||
      isInvalidCredentials ||
      isUserNotFound ||
      isNetworkError;
}

class SignupState extends Equatable {
  final SignupStatus status;
  final String? errorMessage;
  final Password password;
  final Email email;
  final FullName fullname;
  final bool showPassword, isAgree;
  final UserModel? user;
  const SignupState._({
    required this.status,
    this.errorMessage,
    required this.email,
    required this.fullname,
    required this.password,
    required this.showPassword,
    required this.isAgree,
    this.user,
  });

  const SignupState.initial()
    : this._(
        status: SignupStatus.initial,
        errorMessage: '',
        email: const Email.pure(),
        fullname: const FullName.pure(),
        password: const Password.pure(),
        showPassword: false,
        isAgree: false,
        user: null,
      );

  SignupState copyWith({
    SignupStatus? status,
    String? errorMessage,
    Email? email,
    Password? password,
    FullName? fullname,
    bool? showPassword,
    bool? isAgree,
    UserModel? user,
  }) {
    return SignupState._(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      showPassword: showPassword ?? this.showPassword,
      isAgree: isAgree ?? this.isAgree,
      email: email ?? this.email,
      fullname: fullname ?? this.fullname,
      password: password ?? this.password,
      user: user ?? this.user,
    );
  }

  @override
  List<Object?> get props => [
    status,
    errorMessage,
    email,
    fullname,
    password,
    showPassword,
    isAgree,
    user,
  ];
}
