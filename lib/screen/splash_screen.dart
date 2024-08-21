import 'package:flutter/material.dart';

import '../widgets/splash_column.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SplashColumn(),
    );
  }
}
