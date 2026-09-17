import 'package:chat_up/features/auth/login/view/widgets/email_field_widget.dart';
import 'package:chat_up/features/auth/login/view/widgets/password_field_widget.dart';
import 'package:flutter/material.dart';
import '../../../../../core/app_ui/app_ui.dart';

class LoginFormWidget extends StatefulWidget {
  const LoginFormWidget({super.key});

  @override
  State<LoginFormWidget> createState() => _LoginFormWidgetState();
}

class _LoginFormWidgetState extends State<LoginFormWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
        gapH16,
        Align(
          alignment: Alignment.centerRight,
          child: Text(
            AppStrings.forgotPassword,
            style: context.bodyMedium?.copyWith(
              color: AppColors.color2F628D,
            ),
          ),
        ),
      ],
    );
  }
}
