import 'package:chat_up/core/di/service_locator.dart';
import 'package:chat_up/features/auth/login/view/cubit/login_cubit.dart';
import 'package:chat_up/features/auth/login/view/cubit/login_state.dart';
import 'package:chat_up/features/auth/login/view/widgets/headline_welcomeing_widget.dart';
import 'package:chat_up/features/auth/login/view/widgets/login_form_widget.dart';
import 'package:chat_up/features/auth/login/view/widgets/signin_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/app_ui/app_ui.dart';
import '../../../../../core/routes/routes.dart';
import '../../../shared/view/widgets/dividers_widget.dart';
import '../../../shared/view/widgets/social_login_widget.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<LoginCubit>()..idle(),
      child: const LoginView(),
    );
  }
}

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
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
            SvgPicture.asset(Assets.images.chatUpImg.path),
            const Spacer(),
            Text(
              AppStrings.help,
              style: context.titleSmall?.copyWith(color: context.adaptiveColor),
            ),
          ],
        ),
      ),
      body: BlocListener<LoginCubit, LoginState>(
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
        listenWhen: (previous, current) => previous.status != current.status,
        child: AppConstrainedScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xlg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 87),
                HeadlineWelcomeingWidget(),
                gapH32,
                LoginFormWidget(),
                gapH16,
                SigninButtonWidget(),
                gapH24,
                DividersWidget(text: AppStrings.continueWith),
                gapH24,
                SocialLoginWidget(
                  onGooglePressed: () =>
                      context.read<LoginCubit>().onLoginWithGooglePressed(),
                ),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      AppStrings.dontHaveAccount,
                      style: context.bodyLarge?.copyWith(
                        color: AppColors.black10,
                      ),
                    ),
                    gapW4,
                    Tappable.faded(
                      onTap: () {
                        context.pushNamed(PageRouteName.signup);
                      },
                      child: Text(
                        AppStrings.signUp,
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
      ),
    );
  }
}
