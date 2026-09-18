import 'package:chat_up/core/app_ui/app_ui.dart';
import 'package:chat_up/core/di/service_locator.dart';
import 'package:chat_up/features/auth/forgot_password/view/cubit/forgot_passowrd_cubit.dart';
import 'package:chat_up/features/auth/forgot_password/view/cubit/forgot_password_state.dart';
import 'package:chat_up/features/auth/forgot_password/view/widgets/forgot_password_form_widget.dart';
import 'package:chat_up/features/auth/shared/view/widgets/forgot_password_header_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<ForgotPasswordCubit>(),
      child: const ForgotPasswordView(),
    );
  }
}

class ForgotPasswordView extends StatelessWidget {
  const ForgotPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      resizeToAvoidBottomInset: true,
      releaseFocus: true,
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        title: Row(
          children: [
            const Spacer(),
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
        child: BlocConsumer<ForgotPasswordCubit, ForgotPasswordState>(
          listener: (context, state) {
            if (state.status.isSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(AppStrings.resetPasswordSuccessMessage),
                ),
              );
            }
            if (state.status.isError) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.errorMessage ?? '')));
            }
          },
          builder: (context, state) {
            return Column(
              children: [
                gapH24,
                ForgotPasswordHeaderWidget(
                  imagePath: Assets.images.resetPasswordImg.path,
                  title: AppStrings.resetPassword,
                  subtitle: AppStrings.resetPasswordSubtext,
                ),
                gapH32,
                const ForgotPasswordFormWidget(),
              ],
            );
          },
        ),
      ),
    );
  }
}
