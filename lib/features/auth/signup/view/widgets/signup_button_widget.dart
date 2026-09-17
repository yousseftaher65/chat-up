import 'package:chat_up/features/auth/signup/view/cubit/signup_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/app_ui/app_ui.dart';

class SignupButtonWidget extends StatelessWidget {
  const SignupButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final style = ButtonStyle(
      padding: WidgetStatePropertyAll<EdgeInsetsGeometry>(
        EdgeInsetsGeometry.symmetric(vertical: AppSpacing.lg),
      ),
      minimumSize: WidgetStatePropertyAll<Size>(
        const Size(double.maxFinite, 45),
      ),
      elevation: WidgetStatePropertyAll<double>(0),
      shadowColor: WidgetStatePropertyAll<Color>(Colors.transparent),
      backgroundColor: WidgetStatePropertyAll<Color>(Colors.transparent),
      shape: WidgetStatePropertyAll<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSpacing.lg * 2),
        ),
      ),
    );

    final isLoading = context.select(
      (SignupCubit bloc) => bloc.state.status.isLoading,
    );
    final isAgree = context.select((SignupCubit bloc) => bloc.state.isAgree);

    final child = isLoading
        ? AppButton.inProgress(
            style: style,
            scale: 0.5,
            icon: CircularProgressIndicator(color: Colors.white),
          )
        : AppButton.auth(
            AppStrings.createAccount,
            textStyle: context.bodyLarge?.copyWith(color: Colors.white),
            isAgree
                ? () {
                    context.read<SignupCubit>().onSignupPressed();
                  }
                : () {},
            style: style,
            outlined: false,
          );

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: AppColors.primaryButtonGradient,
          begin: AlignmentGeometry.topCenter,
          end: AlignmentGeometry.bottomCenter,
        ),
        borderRadius: BorderRadius.circular(AppSpacing.lg * 2),
      ),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minWidth: switch (context.screenWidth) {
            > 600 => context.screenWidth * .6,
            _ => context.screenWidth,
          },
        ),
        child: child,
      ),
    );
  }
}
