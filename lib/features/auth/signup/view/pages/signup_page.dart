import 'package:chat_up/core/di/service_locator.dart';
import 'package:chat_up/core/routes/routes.dart';
import 'package:chat_up/features/auth/shared/view/widgets/dividers_widget.dart';
import 'package:chat_up/features/auth/shared/view/widgets/social_login_widget.dart';
import 'package:chat_up/features/auth/signup/view/cubit/signup_cubit.dart';
import 'package:chat_up/features/auth/signup/view/cubit/signup_states.dart';
import 'package:chat_up/features/auth/signup/view/widgets/headline_signup_widget.dart';
import 'package:chat_up/features/auth/signup/view/widgets/join_peers_widget.dart';
import 'package:chat_up/features/auth/signup/view/widgets/signup_button_widget.dart';
import 'package:chat_up/features/auth/signup/view/widgets/signup_form_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/app_ui/app_ui.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<SignupCubit>(),
      child: const SignupView(),
    );
  }
}

class SignupView extends StatelessWidget {
  const SignupView({super.key});

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
      body: BlocListener<SignupCubit, SignupState>(
        listener: (context, state) {
          if (state.status.isSuccess) {
            context.goNamed(PageRouteName.home);
          } else if (state.status.isError ||
              state.status.isGoogleSignInFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  state.errorMessage ?? AppStrings.somethingWentWrong,
                ),
              ),
            );
          }
        },
        child: AppConstrainedScrollView(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xlg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              gapH24,
              const HeadlineSignupWidget(),
              gapH24,
              JoinPeersWidget(),
              gapH24,
              const SignupFormWidget(),
              gapH32,
              const SignupButtonWidget(),
              gapH24,
              DividersWidget(text: AppStrings.signUpWith),
              gapH24,
              SocialLoginWidget(
                onGooglePressed: () =>
                    context.read<SignupCubit>().onLoginWithGooglePressed(),
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    AppStrings.alreadyHaveAccount,
                    style: context.bodyLarge?.copyWith(
                      color: AppColors.black10,
                    ),
                  ),
                  gapW4,
                  Tappable.faded(
                    onTap: () {
                      context.pop();
                    },
                    child: Text(
                      AppStrings.login,
                      style: context.bodyLarge?.copyWith(
                        color: AppColors.bluePrimary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              gapH16,
            ],
          ),
        ),
      ),
    );
  }
}
