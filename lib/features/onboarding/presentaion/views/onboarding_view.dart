import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../../core/core.dart';
import '../../onboarding.dart';

class OnboardingView extends ConsumerWidget {
  const OnboardingView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: context.theme.colorScheme.secondary,
      appBar: const OnboardingAppBar(),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
        width: context.screenSize.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(appLogo),
            const SizedBox(
              height: 30,
            ),
            Expanded(
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Transform.scale(
                      scale: 2.5,
                      child: SvgPicture.asset(
                        onBoardingTexture,
                      ),
                    ),
                  ),
                  const OnboardingSlider(),
                ],
              ),
            ),
            const OnboardingButton()
          ],
        ),
      ),
    );
  }
}
