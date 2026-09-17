import 'package:equatable/equatable.dart';

import '../../../../../core/form_fields/form_fields.dart';

enum ForgotPasswordStep { enterEmailAndSendCode, createPassword, completed }

enum ForgotPasswordStatus {
  initial,
  loading,
  success,
  error,
  sendCodeSuccess,
  resendCodeSuccess,
  verifyCodeSuccess,
  createdNewPasswordSuccess,
  invalidCode,
  invalidEmail,
  userNotFound,
  networkError;

  bool get isInitial => this == ForgotPasswordStatus.initial;
  bool get isLoading => this == ForgotPasswordStatus.loading;
  bool get isVerifyCodeSuccess =>
      this == ForgotPasswordStatus.verifyCodeSuccess;
  bool get isCreatedNewPasswordSuccess =>
      this == ForgotPasswordStatus.createdNewPasswordSuccess;
  bool get isSendCodeSuccess => this == ForgotPasswordStatus.sendCodeSuccess;
  bool get isResendCodeSuccess =>
      this == ForgotPasswordStatus.resendCodeSuccess;
  bool get isInvalidCode => this == ForgotPasswordStatus.invalidCode;
  bool get isInvalidEmail => this == ForgotPasswordStatus.invalidEmail;
  bool get isUserNotFound => this == ForgotPasswordStatus.userNotFound;
  bool get isNetworkError => this == ForgotPasswordStatus.networkError;
  bool get isSuccess =>
      this == ForgotPasswordStatus.success ||
      isVerifyCodeSuccess ||
      isCreatedNewPasswordSuccess ||
      isSendCodeSuccess ||
      isResendCodeSuccess;
  bool get isError =>
      this == ForgotPasswordStatus.error ||
      isInvalidCode ||
      isInvalidEmail ||
      isUserNotFound ||
      isNetworkError;
}

class ForgotPasswordState extends Equatable {
  final ForgotPasswordStatus status;
  final ForgotPasswordStep step;
  final String? errorMessage;
  final Otp digitCode;
  final Password newPassword;
  final Email email;
  final bool showPassword, showConfirmPassword, isCodeSent, isResendCodeSent;
  const ForgotPasswordState._({
    required this.status,
    required this.errorMessage,
    required this.newPassword,
    required this.email,
    required this.digitCode,
    required this.showPassword,
    required this.showConfirmPassword,
    required this.isCodeSent,
    required this.isResendCodeSent,
    required this.step,
  });

  const ForgotPasswordState.initial()
    : this._(
        status: ForgotPasswordStatus.initial,
        errorMessage: '',
        newPassword: const Password.pure(),
        email: const Email.pure(),
        showPassword: false,
        showConfirmPassword: false,
        isCodeSent: false,
        isResendCodeSent: false,
        digitCode: const Otp.pure(),
        step: ForgotPasswordStep.enterEmailAndSendCode,
      );

  ForgotPasswordState copyWith({
    ForgotPasswordStatus? status,
    ForgotPasswordStep? step,
    String? errorMessage,
    Email? email,
    Password? newPassword,
    bool? showPassword,
    showConfirmPassword,
    isCodeSent,
    isResendCodeSent,
    Otp? digitCode,
  }) {
    return ForgotPasswordState._(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      showPassword: showPassword ?? this.showPassword,
      showConfirmPassword: showConfirmPassword ?? this.showConfirmPassword,
      isCodeSent: isCodeSent ?? this.isCodeSent,
      isResendCodeSent: isResendCodeSent ?? this.isResendCodeSent,
      email: email ?? this.email,
      newPassword: newPassword ?? this.newPassword,
      digitCode: digitCode ?? this.digitCode,
      step: step ?? this.step,
    );
  }

  @override
  List<Object?> get props => [
    status,
    errorMessage,
    newPassword,
    email,
    showPassword,
    digitCode,
    step,
    showConfirmPassword,
    isCodeSent,
    isResendCodeSent,
  ];
}
