import 'package:chat_up/core/app_ui/app_ui.dart';
import 'package:chat_up/features/auth/signup/view/cubit/signup_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AgreeTermsWidget extends StatelessWidget {
  const AgreeTermsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final isAgree = context.select((SignupCubit cubit) => cubit.state.isAgree);
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            context.read<SignupCubit>().onAgreeChanged(!isAgree);
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            width: 22,
            height: 22,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isAgree ? AppColors.bluePrimary : Colors.transparent,
              border: isAgree ? null : Border.all(color: AppColors.color2F628D),
            ),
            child: isAgree
                ? const Icon(Icons.check, size: 15, color: AppColors.white)
                : null,
          ),
        ),
        gapW8,
        Expanded(
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: AppStrings.iAgree,
                  style: context.bodyMedium?.copyWith(
                    color: AppColors.color2F628D,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                TextSpan(
                  text: AppStrings.termsOfService,
                  style: context.bodyMedium?.copyWith(
                    decoration: TextDecoration.underline,
                    decorationColor: AppColors.color0062A0,
                    color: AppColors.color0062A0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(
                  text: AppStrings.and,
                  style: context.bodyMedium?.copyWith(
                    color: AppColors.color2F628D,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                TextSpan(
                  text: AppStrings.privacyPolicy,
                  style: context.bodyMedium?.copyWith(
                    decoration: TextDecoration.underline,
                    decorationColor: AppColors.color0062A0,
                    color: AppColors.color0062A0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
