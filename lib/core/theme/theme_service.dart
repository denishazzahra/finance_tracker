import 'package:finance_tracker/app/data/models/theme_mode_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeService {
  static final List<ThemeModeModel> themes = [
    ThemeModeModel(name: 'Dark', icon: Symbols.dark_mode, mode: ThemeMode.dark),
    ThemeModeModel(
      name: 'Light',
      icon: Symbols.light_mode,
      mode: ThemeMode.light,
    ),
    ThemeModeModel(
      name: 'Auto',
      icon: Symbols.contrast,
      mode: ThemeMode.system,
    ),
  ];
  final _key = "mode";

  String _loadThemeFromBox() {
    return Get.find<SharedPreferences>().getString(_key) ?? 'Auto';
  }

  ThemeMode get theme =>
      themes.firstWhere((theme) => theme.name == _loadThemeFromBox()).mode;

  String get name => _loadThemeFromBox();

  IconData get icon =>
      themes.firstWhere((theme) => theme.name == _loadThemeFromBox()).icon;

  void switchTheme(String mode) {
    Get.find<SharedPreferences>().setString(_key, mode);
    Get.changeThemeMode(theme);
  }
}
