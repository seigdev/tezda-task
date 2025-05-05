import 'dart:async';
import 'package:tezda_task/core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppThemeController {
  // Singleton instance
  static final AppThemeController _instance = AppThemeController._internal();
  factory AppThemeController() => _instance;
  AppThemeController._internal();

  final _controller = StreamController<AppTheme>.broadcast();

  Stream<AppTheme> get stream => _controller.stream;

  AppTheme _currentTheme = AppTheme.light();

  AppTheme get currentTheme => _currentTheme;

  void setTheme(AppTheme theme) {
    if (theme.mode == ThemeMode.dark) {
      setStatusBarColor(color: BarColor.white);
      // _currentTheme = AppTheme.dark();
      _controller.add(theme);
      return;
    }
    setStatusBarColor(color: BarColor.black);
    _currentTheme = AppTheme.light();
    _controller.add(theme);
  }

  void dispose() {
    _controller.close();
  }
}

void setStatusBarColor({required BarColor color}) {
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
        statusBarBrightness:
            color == BarColor.white ? Brightness.dark : Brightness.light),
  );
}

enum BarColor { white, black }
