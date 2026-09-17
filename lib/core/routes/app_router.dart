import 'package:chat_up/core/di/service_locator.dart';
import 'package:chat_up/core/routes/page_route_name.dart';
import 'package:chat_up/features/auth/forgot_password/view/pages/forgot_password_page.dart';
import 'package:chat_up/features/auth/shared/data/datasources/auth_local_data_source.dart';
import 'package:chat_up/features/auth/shared/data/models/user_model.dart';
import 'package:chat_up/features/auth/login/view/pages/login_page.dart';
import 'package:chat_up/features/auth/signup/view/pages/signup_page.dart';
import 'package:chat_up/features/home/view/pages/home_page.dart';
import 'package:chat_up/features/splash/view/pages/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final routeNavigatorKey = GlobalKey<NavigatorState>(
  debugLabel: 'routeNavigatorKey',
);

class AppRouter {
  static GoRouter get router => appRouter;

  static GoRouter appRouter = GoRouter(
    navigatorKey: routeNavigatorKey,
    initialLocation: PageRouteName.init,
    routes: [
      GoRoute(
        path: PageRouteName.init,
        name: PageRouteName.init,
        builder: (_, state) => const SplashPage(),
      ),
      GoRoute(
        path: PageRouteName.login,
        name: PageRouteName.login,
        pageBuilder: (context, state) =>
            getFadeTransitionPage(state: state, child: const LoginPage()),
      ),
      GoRoute(
        path: PageRouteName.signup,
        name: PageRouteName.signup,
        pageBuilder: (context, state) =>
            getFadeTransitionPage(state: state, child: const SignupPage()),
      ),
      GoRoute(
        path: PageRouteName.forgotPassword,
        name: PageRouteName.forgotPassword,
        pageBuilder: (context, state) => getFadeTransitionPage(
          state: state,
          child: const ForgotPasswordPage(),
        ),
      ),
      GoRoute(
        path: PageRouteName.home,
        name: PageRouteName.home,
        pageBuilder: (context, state) =>
            getFadeTransitionPage(state: state, child: const HomePage()),
      ),
    ],
    redirect: (context, state) async {
      final location = state.matchedLocation;
      if (location == PageRouteName.init) return null;

      UserModel? cachedUser;
      try {
        cachedUser = await sl<AuthLocalDataSource>().getCachedUser();
      } catch (_) {
        cachedUser = null;
      }
      final isAuthPage =
          location == PageRouteName.login || location == PageRouteName.signup;

      if (cachedUser == null && location == PageRouteName.home) {
        return PageRouteName.login;
      }

      if (cachedUser != null && isAuthPage) {
        return PageRouteName.home;
      }

      return null;
    },
  );

  static CustomTransitionPage<dynamic> getFadeTransitionPage({
    required GoRouterState state,
    required Widget child,
  }) {
    return CustomTransitionPage(
      key: state.pageKey,
      child: child,
      transitionDuration: Duration.zero,
      reverseTransitionDuration: Duration.zero,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: CurveTween(curve: Curves.easeInOut).animate(animation),
          child: child,
        );
      },
    );
  }
}
