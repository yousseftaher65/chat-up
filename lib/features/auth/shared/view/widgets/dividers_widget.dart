import 'package:flutter/material.dart';

import '../../../../../core/app_ui/app_ui.dart';

class DividersWidget extends StatelessWidget {
  final String text;
  const DividersWidget({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Divider(thickness: 1, color: AppColors.colorBFC7D3)),
        Padding(
          padding: EdgeInsetsDirectional.only(
            start: AppSpacing.lg,
            end: AppSpacing.lg,
          ),
          child: Text(
            "${AppStrings.or} $text",
            style: context.bodyMedium?.copyWith(
              color: AppColors.grey,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Expanded(child: Divider(thickness: 1, color: AppColors.colorBFC7D3)),
      ],
    );
  }
}
