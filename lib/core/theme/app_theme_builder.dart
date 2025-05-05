import 'package:tezda_task/core/core.dart';
import 'package:tezda_task/injection.dart';
import 'package:flutter/material.dart';

typedef ThemeBuilderWidget = Widget Function(AppColors colors);

class ThemeBuilder extends StatefulWidget {
  final ThemeBuilderWidget builder;

  const ThemeBuilder({
    super.key,
    required this.builder,
  });

  @override
  State<ThemeBuilder> createState() => _ThemeBuilderState();
}

class _ThemeBuilderState extends State<ThemeBuilder> with AppThemeMixin {
  @override
  Widget build(BuildContext context) {
    final AppTheme theme = inj<AppThemeController>().currentTheme;
    return widget.builder(theme.colors);
  }
}
