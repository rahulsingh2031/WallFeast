import 'package:flutter/material.dart';

class SplashColumn extends StatelessWidget {
  const SplashColumn({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            "assets/icon/logo_2.png",
            height: 200,
          ),
          CircularProgressIndicator(
            color: Theme.of(context).colorScheme.primary,
          ),
          const SizedBox(
            height: 5,
          ),
          const Text("Please wait...")
        ],
      ),
    );
  }
}
