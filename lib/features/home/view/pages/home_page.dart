import 'package:flutter/material.dart';

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
    return AppScaffold(body: Column(children: [Text('welcome home')]));
  }
}
