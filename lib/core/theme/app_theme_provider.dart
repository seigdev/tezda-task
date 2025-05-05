import 'dart:async';

import 'package:tezda_task/core/core.dart';
import 'package:tezda_task/injection.dart';
import 'package:flutter/material.dart';

mixin AppThemeMixin<T extends StatefulWidget> on State<T> {
  late AppTheme theme;
  late AppColors colors;
  late StreamSubscription<AppTheme> streamSubscription;

  @override
  void initState() {
    theme = AppTheme.light();

    colors = theme.colors;

    streamSubscription =
        inj<AppThemeController>().stream.listen((AppTheme newTheme) {
      if (mounted) {
        setState(() {
          this.theme = newTheme;
          this.colors = theme.colors;
        });
      }
    });
    super.initState();
  }
}
