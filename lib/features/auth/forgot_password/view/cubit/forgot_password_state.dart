import 'package:equatable/equatable.dart';

import '../../../../../core/form_fields/form_fields.dart';

enum ForgotPasswordStep { verifyEmail, createPassword, completed }

enum ForgotPasswordStatus {
  initial,
  loading,
  success,
  error,
  verifyEmailSuccess,
  createdNewPasswordSuccess,
  invalidCode,
  invalidEmail,
  userNotFound,
  networkError;

  bool get isInitial => this == ForgotPasswordStatus.initial;
  bool get isLoading => this == ForgotPasswordStatus.loading;
  bool get isVerifyEmailSuccess =>
      this == ForgotPasswordStatus.verifyEmailSuccess;
  bool get isCreatedNewPasswordSuccess =>
      this == ForgotPasswordStatus.createdNewPasswordSuccess;
  bool get isInvalidCode => this == ForgotPasswordStatus.invalidCode;
  bool get isInvalidEmail => this == ForgotPasswordStatus.invalidEmail;
  bool get isUserNotFound => this == ForgotPasswordStatus.userNotFound;
  bool get isNetworkError => this == ForgotPasswordStatus.networkError;
  bool get isSuccess =>
      this == ForgotPasswordStatus.success ||
      isVerifyEmailSuccess ||
      isCreatedNewPasswordSuccess;
  bool get isError =>
      this == ForgotPasswordStatus.error ||
      isInvalidCode ||
      isInvalidEmail ||
      isUserNotFound ||
      isNetworkError;
}

class ForgotPasswordState extends Equatable {
  final ForgotPasswordStatus status;
  final String? errorMessage;
  final Email email;
  const ForgotPasswordState._({
    required this.status,
    required this.errorMessage,
    required this.email,
  });

  const ForgotPasswordState.initial()
    : this._(
        status: ForgotPasswordStatus.initial,
        errorMessage: '',
        email: const Email.pure(),
      );

  ForgotPasswordState copyWith({
    ForgotPasswordStatus? status,
    String? errorMessage,
    Email? email,
  }) {
    return ForgotPasswordState._(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,

      email: email ?? this.email,
    );
  }

  @override
  List<Object?> get props => [status, errorMessage, email];
}
