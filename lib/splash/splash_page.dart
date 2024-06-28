import 'package:flutter/material.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("SplashPage....");
    return const Scaffold(
      body: Center(
        child: Text('GTNexpress Loading...'),
      ),
    );
  }
}
