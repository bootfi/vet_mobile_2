import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import '../../../../core/core.dart';
import '../../../onboarding/presentaion/views/onboarding_view.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    Timer(const Duration(milliseconds: 2500),
        (() => context.pushReplacment(const OnboardingView())));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.colorScheme.primary,
      body: const Center(
        child: SizedBox(
          width: 130,
          child: RiveAnimation.asset(appLogoAnimation),
        ),
      ),
    );
  }
}
