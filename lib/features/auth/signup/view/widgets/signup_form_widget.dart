import 'package:chat_up/features/auth/signup/view/widgets/agree_terms_widget.dart';
import 'package:chat_up/features/auth/signup/view/widgets/email_form_widget.dart';
import 'package:chat_up/features/auth/signup/view/widgets/fullname_field_widget.dart';
import 'package:chat_up/features/auth/signup/view/widgets/password_field_widget.dart';
import 'package:flutter/material.dart';

import '../../../../../core/app_ui/app_ui.dart';

class SignupFormWidget extends StatelessWidget {
  const SignupFormWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.fullName,
          style: context.bodyMedium?.copyWith(color: AppColors.black10),
        ),
        gapH8,
        const FullNameFieldWidget(),
        gapH16,
        Text(
          AppStrings.email,
          style: context.bodyMedium?.copyWith(color: AppColors.black10),
        ),
        gapH8,
        const EmailFieldWidget(),
        gapH16,
        Text(
          AppStrings.password,
          style: context.bodyMedium?.copyWith(color: AppColors.black10),
        ),
        gapH8,
        const PasswordFieldWidget(),
        gapH24,
        const AgreeTermsWidget(),
      ],
    );
  }
}
