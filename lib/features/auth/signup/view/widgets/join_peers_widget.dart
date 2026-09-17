import 'package:flutter/material.dart';

import '../../../../../core/app_ui/app_ui.dart';

class JoinPeersWidget extends StatelessWidget {
  const JoinPeersWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.colorBFC7D3.withValues(alpha: 0.4)),
        borderRadius: BorderRadius.circular(AppSpacing.lg),
        color: AppColors.colorF3F3F7.withValues(alpha: 0.7),
      ),
      child: Row(
        children: [
          Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.bluePrimary, width: 2),
                ),
                child: Image.asset(
                  Assets.images.personImg.path,
                  height: AppSpacing.xxxlg,
                  width: AppSpacing.xxxlg,
                ),
              ),
              Positioned(
                right: -1,
                bottom: -1,
                child: Container(
                  width: 14,
                  height: 14,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.bluePrimary,
                    border: Border.all(color: AppColors.white, width: 2),
                  ),
                ),
              ),
            ],
          ),
          gapW8,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppStrings.joinPeers,
                style: context.bodyLarge?.copyWith(
                  color: AppColors.black10,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                AppStrings.joinPeersSubtext,
                style: context.bodyMedium?.copyWith(
                  color: AppColors.color2F628D,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          Spacer(),
          SvgPicture.asset(Assets.images.peersStackImg.path),
        ],
      ),
    );
  }
}
