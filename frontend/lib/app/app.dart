import 'package:flutter/material.dart';

import 'router.dart';
import 'theme.dart';

class BurnoutApp extends StatelessWidget {
  const BurnoutApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Burnout Detection',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      initialRoute: AppRouter.splash,
      onGenerateRoute: AppRouter.onGenerateRoute,
    );
  }
}
