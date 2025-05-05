import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:tezda_task/app.dart';
import 'package:tezda_task/core/core.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tezda_task/firebase_options.dart';

import 'injection.dart';

void main() async {
  Setups.run();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await configDependencies();

  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    FocusScope.of(context).unfocus();
    return MaterialApp(
      title: 'Tezda App',
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      theme: ThemeData(
        useMaterial3: false,
        fontFamily: 'DMSans',
      ),
      builder: (_, child) {
        return _UnFocus(
          child: child!,
        );
      },
      home: const App(),
    );
  }
}

class _UnFocus extends StatelessWidget {
  final Widget child;
  const _UnFocus({required this.child});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: child,
    );
  }
}
