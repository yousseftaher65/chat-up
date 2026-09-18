import 'package:equatable/equatable.dart';

import '../../../../../../core/form_fields/form_fields.dart';

enum ChangePasswordStatus {
  initial,
  loading,
  success,
  error,
  networkError;

  bool get isInitial => this == ChangePasswordStatus.initial;
  bool get isLoading => this == ChangePasswordStatus.loading;
  bool get isNetworkError => this == ChangePasswordStatus.networkError;
  bool get isSuccess => this == ChangePasswordStatus.success;
  bool get isError => this == ChangePasswordStatus.error || isNetworkError;
}

class ResetPasswordState extends Equatable {
  final ChangePasswordStatus status;
  final String? errorMessage;
  final Password newPassword, confirmPassword;
  final bool showNewPassword, showConfirmPassword;
  const ResetPasswordState._({
    required this.status,
    required this.errorMessage,
    required this.newPassword,
    required this.confirmPassword,
    required this.showNewPassword,
    required this.showConfirmPassword,
  });

  const ResetPasswordState.initial()
    : this._(
        status: ChangePasswordStatus.initial,
        errorMessage: '',
        newPassword: const Password.pure(),
        confirmPassword: const Password.pure(),
        showNewPassword: false,
        showConfirmPassword: false,
      );

  ResetPasswordState copyWith({
    ChangePasswordStatus? status,
    String? errorMessage,
    Password? newPassword,
    confirmPassword,
    bool? showNewPassword,
    showConfirmPassword,
  }) {
    return ResetPasswordState._(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      showNewPassword: showNewPassword ?? this.showNewPassword,
      showConfirmPassword: showConfirmPassword ?? this.showConfirmPassword,
      newPassword: newPassword ?? this.newPassword,
      confirmPassword: confirmPassword ?? this.confirmPassword,
    );
  }

  @override
  List<Object?> get props => [
    status,
    errorMessage,
    newPassword,
    showNewPassword,
    showConfirmPassword,
    confirmPassword,
  ];
}
