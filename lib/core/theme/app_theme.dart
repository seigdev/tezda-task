import 'package:flutter/material.dart';
import 'package:tezda_task/core/theme/app_colors.dart';

class AppTheme {
  final AppColors colors;
  final ThemeMode mode;

  const AppTheme._({
    required this.colors,
    required this.mode,
  });

  factory AppTheme.light() {
    return AppTheme._(
      mode: ThemeMode.light,
      colors: AppColors(
        kWhite: Colors.white,
        kBlack: const Color(0xff121212),
        kBackground: Colors.white,
        tF9A03F: const Color(0xffF9A03F),
        ggray900: const Color(0xff0E1F1D),
        ggray500: const Color(0xff6B7280),
        ggray400: const Color(0xffA4A8A7),
        ggray200: const Color(0xffE5E7EB),
        ggray100: const Color(0xffE9EAEA),
      ),
    );
  }
}
