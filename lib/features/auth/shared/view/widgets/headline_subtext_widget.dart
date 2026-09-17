import 'package:chat_up/core/app_ui/app_ui.dart';
import 'package:flutter/material.dart';

class HeadlineSubtextWidget extends StatelessWidget {
  final String text;
  const HeadlineSubtextWidget({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.color9BCBFC.withValues(alpha: 0.4)),
        borderRadius: BorderRadius.circular(AppSpacing.xlg),
        color: AppColors.colorCFE5FF.withValues(alpha: 0.5),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(Assets.images.dotImg.path),
          gapW8,
          Text(
            text,
            style: context.bodyLarge?.copyWith(
              color: AppColors.color2F628D,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
