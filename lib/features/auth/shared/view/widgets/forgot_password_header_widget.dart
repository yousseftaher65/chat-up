import 'package:flutter/material.dart';

import '../../../../../core/app_ui/app_ui.dart';

class ForgotPasswordHeaderWidget extends StatelessWidget {
  final String title;
  final String subtitle;
  final String imagePath;

  const ForgotPasswordHeaderWidget({
    super.key,
    required this.title,
    required this.subtitle,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SvgPicture.asset(imagePath),
        gapH16,
        Text(
          title,
          style: context.headlineLarge?.copyWith(
            color: AppColors.black10,
            fontWeight: FontWeight.bold,
          ),
        ),
        gapH8,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xxxlg),
          child: Text(
            subtitle,
            textAlign: TextAlign.center,
            style: context.bodyLarge?.copyWith(
              color: AppColors.color2F628D,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }
}
