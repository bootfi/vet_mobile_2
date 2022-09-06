import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:vet_mobile/core/constants/constants.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: kPrimaryColor,
      body: Center(
        child: SizedBox(
          width: 130,
          child: RiveAnimation.asset(appLogoAnimation),
        ),
      ),
    );
  }
}
