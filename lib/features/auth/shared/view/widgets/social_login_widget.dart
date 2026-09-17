import 'package:flutter/material.dart';

import '../../../../../core/app_ui/app_ui.dart';

class SocialLoginWidget extends StatelessWidget {
  const SocialLoginWidget({required this.onGooglePressed, super.key});

  final VoidCallback onGooglePressed;

  @override
  Widget build(BuildContext context) {
    final style = ButtonStyle(
      padding: WidgetStatePropertyAll(
        const EdgeInsets.symmetric(vertical: AppSpacing.lg),
      ),
      backgroundColor: WidgetStatePropertyAll<Color>(Colors.white),
      elevation: WidgetStatePropertyAll<double>(0),
      shadowColor: WidgetStatePropertyAll<Color>(Colors.transparent),
      shape: WidgetStatePropertyAll<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          side: const BorderSide(color: AppColors.colorE2E2E6, width: 1.0),
          borderRadius: BorderRadius.circular(AppSpacing.lg * 2),
        ),
      ),
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: AppButton.outlined(
            style: style,
            onPressed: onGooglePressed,
            text: AppStrings.google,
            textStyle: context.bodyLarge?.copyWith(
              color: AppColors.black,
              fontWeight: FontWeight.w500,
            ),
            icon: SvgPicture.asset(Assets.icons.googleIc.path),
          ),
        ),
        gapW12,
        Expanded(
          child: AppButton.outlined(
            style: style,
            onPressed: () {},
            text: AppStrings.apple,
            textStyle: context.bodyLarge?.copyWith(
              color: AppColors.black,
              fontWeight: FontWeight.w500,
            ),
            icon: SvgPicture.asset(Assets.icons.appleIc.path),
          ),
        ),
      ],
    );
  }
}
