import 'package:chat_up/core/di/service_locator.dart';
import 'package:chat_up/core/routes/page_route_name.dart';
import 'package:chat_up/features/auth/forgot_password/reset_password/view/cubit/reset_password_state.dart';
import 'package:chat_up/features/auth/forgot_password/reset_password/view/widgets/reset_password_form_widget.dart';
import 'package:chat_up/features/auth/forgot_password/reset_password/view/widgets/verify_button_widget.dart';
import 'package:chat_up/features/auth/shared/view/widgets/forgot_password_header_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../core/app_ui/app_ui.dart';
import '../cubit/reset_password_cubit.dart';

class ResetPasswordPage extends StatelessWidget {
  final String? oobCode;
  const ResetPasswordPage({super.key, this.oobCode});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<ResetPasswordCubit>(),
      child: ResetPasswordView(oobCode: oobCode),
    );
  }
}

class ResetPasswordView extends StatelessWidget {
  final String? oobCode;
  const ResetPasswordView({super.key, this.oobCode});

  @override
  Widget build(BuildContext context) {
    // Edge case: Link clicked without a valid token
    if (oobCode == null) {
      return const Scaffold(
        body: Center(child: Text('Invalid or expired reset link.')),
      );
    }

    return AppScaffold(
      releaseFocus: true,
      resizeToAvoidBottomInset: true,
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        title: Row(
          children: [
            SvgPicture.asset(Assets.images.chatUpImg.path),
            const Spacer(),
            gapW24,
            Text(
              AppStrings.help,
              style: context.titleSmall?.copyWith(color: context.adaptiveColor),
            ),
          ],
        ),
      ),
      body: AppConstrainedScrollView(
        padding: EdgeInsets.symmetric(horizontal: AppSpacing.xlg),
        child: BlocConsumer<ResetPasswordCubit, ResetPasswordState>(
          listener: (context, state) {
            if (state.status.isSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(AppStrings.changePasswordSuccessMessage),
                ),
              );

              context.goNamed(PageRouteName.login);
            }
            if (state.status.isError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    state.errorMessage ?? AppStrings.somethingWentWrong,
                  ),
                ),
              );
            }
          },
          builder: (context, state) {
            return Column(
              children: [
                gapH32,
                ForgotPasswordHeaderWidget(
                  imagePath: Assets.images.resetPasswordImg.path,
                  title: AppStrings.createNewPassword,
                  subtitle: AppStrings.createNewPasswordSubtext,
                ),
                gapH32,
                const ResetPasswordFormWidget(),
                gapH24,
                VerifyButtonWidget(oobCode: oobCode),
                gapH16,
                ConstrainedBox(
                  constraints: BoxConstraints(
                    minWidth: switch (context.screenWidth) {
                      > 600 => context.screenWidth * .6,
                      _ => context.screenWidth,
                    },
                  ),
                  child: AppButton(
                    color: AppColors.white,
                    onPressed: () {
                      context.push(PageRouteName.login);
                    },
                    text: AppStrings.cancelAndReturn,
                    textStyle: TextStyle(
                      color: AppColors.color2F628D,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
