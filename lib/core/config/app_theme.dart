import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart'
    show Ref, StateNotifier, StateNotifierProvider;

import '../core.dart';

class ThemeNotifier extends StateNotifier<ThemeData?> {
  ThemeNotifier(this.ref) : super(null) {
    init();
  }
  final Ref ref;
  void init() async {
    final config = await ref.watch(configurationsProvider.future);
    final primaryColor = Color(int.parse(config.primaryColor));
    state = _theme('SST Arabic', primaryColor);
    debugPrint('in ar');
  }

  final _baseTheme = ThemeData.light();
  ThemeData _theme(String fontFamily, Color primaryColor) => ThemeData(
        brightness: Brightness.light,
        primaryColor: primaryColor,
        textTheme: _baseTheme.textTheme.apply(
          fontFamily: fontFamily,
        ),
        primaryTextTheme: _baseTheme.primaryTextTheme.apply(
          fontFamily: fontFamily,
        ),
        colorScheme: _baseTheme.colorScheme.copyWith(
          primary: primaryColor,
          secondary: kSecondrayColor,
          background: Colors.white,
        ),
        appBarTheme: _baseTheme.appBarTheme.copyWith(
          elevation: 0,
          backgroundColor: Colors.white,
        ),
      );
}

final themeProvider = StateNotifierProvider<ThemeNotifier, ThemeData?>((ref) {
  return ThemeNotifier(ref);
});
