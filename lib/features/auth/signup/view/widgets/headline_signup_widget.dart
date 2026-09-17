import 'package:chat_up/core/app_ui/app_ui.dart';
import 'package:chat_up/features/auth/shared/view/widgets/headline_subtext_widget.dart';
import 'package:flutter/material.dart';

class HeadlineSignupWidget extends StatelessWidget {
  const HeadlineSignupWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        HeadlineSubtextWidget(text: AppStrings.newExperience),
        gapH12,
        Text(
          AppStrings.createAccount,
          style: context.headlineLarge?.copyWith(
            color: AppColors.black10,
            fontWeight: FontWeight.bold,
          ),
        ),
        gapH8,
        Text(
          AppStrings.createAccountSubtext,
          style: context.bodyLarge?.copyWith(
            color: AppColors.deepBlue,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}
