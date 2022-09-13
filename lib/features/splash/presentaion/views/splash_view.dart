import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rive/rive.dart';
import '../../../../core/core.dart';
import '../../../auth/presentation/views/login_view.dart';
import '../../../onboarding/presentaion/views/onboarding_view.dart';

class SplashView extends ConsumerStatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SplashViewState();
}

class _SplashViewState extends ConsumerState<SplashView> {
  late final bool showOnboard;
  @override
  void initState() {
    checkIsFirst();
    Timer(
        const Duration(milliseconds: 2500),
        (() => context.pushReplacment(
            showOnboard ? const OnboardingView() : LoginView())));
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

  checkIsFirst() async {
    final prefs = await ref.read(sharedPreferencesProvider.future);
    showOnboard = prefs.getBool(SharedPrefrenceKeys.isFirst.name) ?? true;
  }
}
