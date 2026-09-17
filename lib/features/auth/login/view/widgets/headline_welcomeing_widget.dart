import 'package:chat_up/core/app_ui/app_ui.dart';
import 'package:flutter/material.dart';

import '../../../shared/view/widgets/headline_subtext_widget.dart';

class HeadlineWelcomeingWidget extends StatelessWidget {
  const HeadlineWelcomeingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        HeadlineSubtextWidget(text: AppStrings.readyToConnect),
        gapH12,
        Text(
          AppStrings.welcome,
          style: context.headlineLarge?.copyWith(
            color: AppColors.black10,
            fontWeight: FontWeight.bold,
          ),
        ),
        gapH8,
        Text(
          AppStrings.welcomeSubtext,
          style: context.bodyLarge?.copyWith(
            color: AppColors.deepBlue,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}
