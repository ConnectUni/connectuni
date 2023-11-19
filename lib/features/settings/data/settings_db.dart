import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'settings_db.g.dart';

@riverpod
class CurrentThemeMode extends _$CurrentThemeMode {
  @override
  ThemeMode build() {
    return ThemeMode.system;
  }

  void setThemeMode(ThemeMode themeMode) {
    state = themeMode;
  }
}