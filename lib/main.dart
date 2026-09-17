import 'package:chat_up/bloc_observer.dart';
import 'package:chat_up/core/env/env.dart';
import 'package:chat_up/core/routes/app_router.dart';
import 'package:chat_up/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'core/app_ui/app_ui.dart';
import 'core/di/service_locator.dart';

Future<void> main() async {
  final iOSClientId = Env.firebaseIosClientId;
  final webClientId = Env.firebaseWebClientId;

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await GoogleSignIn.instance.initialize(
    clientId: defaultTargetPlatform == TargetPlatform.iOS ? iOSClientId : null,
    serverClientId: webClientId,
  );
  configureDependencies();
  Bloc.observer = MyBlocObserver();
  runApp(const ChatUp());
}

class ChatUp extends StatelessWidget {
  const ChatUp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: ThemeData(
        textSelectionTheme: TextSelectionThemeData(
          selectionColor: AppColors.bluePrimary.withValues(
            alpha: 0.3,
          ), // the highlighted text-selection background
          selectionHandleColor:
              AppColors.bluePrimary, // the drag handles on mobile
        ),
      ),
      debugShowCheckedModeBanner: false,
      routerConfig: AppRouter.appRouter,
      title: 'Chat Up',
    );
  }
}
