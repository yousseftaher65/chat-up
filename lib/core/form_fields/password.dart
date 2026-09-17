import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart' show immutable;
import '../form_fields/formz_vaildation_mixin.dart';
import 'package:formz/formz.dart' show FormzInput;

/// {@template password}
/// Form input for a password. It extends [FormzInput] and uses
/// [PasswordValidationError] for its validation errors.
/// {@endtemplate}
@immutable
class Password extends FormzInput<String, PasswordValidationError>
    with Equatable, FormzValidationMixin {
  /// {@macro password.pure}
  const Password.pure([super.value = '']) : super.pure();

  /// {@macro password.dirty}
  const Password.dirty([
    super.value = '',
  ]) : super.dirty();

  @override
  PasswordValidationError? validator(String value) {
    if (value.isEmpty) {
      return PasswordValidationError.empty;
    } else if (value.length < 6 || value.length > 120) {
      return PasswordValidationError.invalid;
    } else {
      return null;
    }
  }

  @override
  Map<PasswordValidationError?, String?> get validationErrorMessage => {
    PasswordValidationError.empty: 'This field is required',
    PasswordValidationError.invalid:
        'Password should contain at least 6 characters',
    null: null,
  };

  @override
  List<Object?> get props => [value, isPure];
}

/// Validation errors for [Password]. It can be empty or invalid.
enum PasswordValidationError {
  /// Empty password.
  empty,

  /// Invalid password.
  invalid,
}
