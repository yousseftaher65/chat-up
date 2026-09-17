import 'package:chat_up/core/app_ui/app_ui.dart';
import 'package:chat_up/core/di/service_locator.dart';
import 'package:chat_up/features/auth/shared/data/datasources/auth_local_data_source.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/routes/routes.dart';

import '../widgets/dots_loading_indicator_widget.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SplashView();
  }
}

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    _navigateBasedOnAuthState();
  }

  Future<void> _navigateBasedOnAuthState() async {
    await Future<void>.delayed(const Duration(seconds: 3));

    if (!mounted) return;

    try {
      final cachedUser = await sl<AuthLocalDataSource>().getCachedUser();

      if (!mounted) return;

      context.goNamed(
        cachedUser == null ? PageRouteName.login : PageRouteName.home,
      );
    } catch (_) {
      if (mounted) context.goNamed(PageRouteName.login);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      safeArea: false,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: AppColors.backgroundGradient,
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: const [0.0, 0.5, 1.0],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            SvgPicture.asset(Assets.images.splashImg.path),
            SvgPicture.asset(Assets.images.appLogoSplashImg.path),
            gapH32,
            DotsLoadingIndicatorWidget(),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.lock, color: AppColors.color2F628D),
                gapW8,
                Text(
                  AppStrings.connectEffortlessly,
                  style: context.bodyLarge?.copyWith(
                    color: AppColors.color2F628D,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            gapH24,
          ],
        ),
      ),
    );
  }
}
