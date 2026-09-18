import 'package:chat_up/core/app_ui/app_ui.dart';
import 'package:chat_up/features/auth/forgot_password/reset_password/view/widgets/confirmed_password_field_widget.dart';
import 'package:chat_up/features/auth/forgot_password/reset_password/view/widgets/new_password_field_widget.dart';
import 'package:flutter/material.dart';

class ResetPasswordFormWidget extends StatelessWidget {
  const ResetPasswordFormWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.newPassword,
          style: context.bodyMedium?.copyWith(color: AppColors.black10),
        ),
        gapH8,
        const NewPasswordFieldWidget(),
        gapH16,
        Text(
          AppStrings.confirmPassword,
          style: context.bodyMedium?.copyWith(color: AppColors.black10),
        ),
        gapH8,
        const ConfirmedPasswordFieldWidget(),
      ],
    );
  }
}
