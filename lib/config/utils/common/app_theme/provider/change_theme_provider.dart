import 'package:flutter_riverpod/flutter_riverpod.dart';

enum ThemeModesForApp {dark, light, sys_default}

class ChangeThemeNotifier extends StateNotifier<ThemeModesForApp> {
  ChangeThemeNotifier() : super(ThemeModesForApp.sys_default);

  void toggleThemeMode(ThemeModesForApp themeMode) {
    state = themeMode;
  }
}

final themeProvider = StateNotifierProvider<ChangeThemeNotifier, ThemeModesForApp>(
      (ref) => ChangeThemeNotifier(),
);
