import 'package:chat_up/core/routes/page_route_name.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/app_ui/app_ui.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return HomeView();
  }
}

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: Column(
        children: [
          Text('welcome home'),
          gapH16,
          ElevatedButton(
            onPressed: () {
              context.goNamed(PageRouteName.login);
            },
            child: Text('logout'),
          ),
        ],
      ),
    );
  }
}
