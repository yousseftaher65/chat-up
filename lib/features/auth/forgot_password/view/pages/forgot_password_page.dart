import 'package:chat_up/core/app_ui/app_ui.dart';
import 'package:chat_up/core/di/service_locator.dart';
import 'package:chat_up/features/auth/forgot_password/view/cubit/forgot_passowrd_cubit.dart';
import 'package:chat_up/features/auth/forgot_password/view/cubit/forgot_password_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/forgot_password_header_widget.dart';

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
            // TODO: implement listener
          },
          buildWhen: (previous, current) {
            // TODO: implement buildWhen
            return false;
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
              ],
            );
          },
        ),
      ),
    );
  }
}
