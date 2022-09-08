import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../../core/core.dart';
import '../../onboarding.dart';

class OnboardingAppBar extends ConsumerWidget implements PreferredSizeWidget {
  const OnboardingAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(60);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppBar(
        backgroundColor: context.theme.colorScheme.secondary,
        elevation: 0.0,
        leadingWidth: 150.0,
        actions: [
          InkWell(
            onTap: () {
              ref.read(onboardingProvider.notifier).setIsFirst();
              // TODO : add navigation
            },
            child: Padding(
              padding: const EdgeInsetsDirectional.only(end: 15),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: Text(
                      context.locale.skip,
                      style:
                          TextStyle(color: context.theme.colorScheme.primary),
                    ),
                  ),
                  RotatedBox(
                    quarterTurns: context.locale.localeName == 'en' ? 4 : 2,
                    child: SvgPicture.asset(
                      skipIcon,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ]);
  }
}
