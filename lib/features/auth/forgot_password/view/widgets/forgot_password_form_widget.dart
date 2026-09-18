import 'package:chat_up/features/auth/forgot_password/view/widgets/email_field_widget.dart';
import 'package:chat_up/features/auth/forgot_password/view/widgets/reset_password_button_widget.dart';
import 'package:flutter/material.dart';

import '../../../../../core/app_ui/app_ui.dart';

class ForgotPasswordFormWidget extends StatelessWidget {
  const ForgotPasswordFormWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.registeredEmail,
          style: context.bodyMedium?.copyWith(color: AppColors.black10),
        ),
        gapH8,
        const EmailFieldWidget(),
        gapH24,
        ResetPasswordButtonWidget(),
      ],
    );
  }
}
