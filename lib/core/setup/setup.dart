import 'package:tezda_task/app/shared/shared.dart';
import 'package:tezda_task/core/core.dart';
import 'package:flutter/material.dart';

class Setups {
  static Future<void> run() async {
    WidgetsFlutterBinding.ensureInitialized();

    EnvironmentPath.set(environment: Environment.dev);
    await EnvironmentPath.load();

    await CacheData.init();

    setStatusBarColor(color: BarColor.black);
  }
}
