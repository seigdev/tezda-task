import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tezda_task/app/modules/authentication/presentation/pages/sign_in_page.dart';
import 'package:tezda_task/app/shared/classes/dashboard.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> with WidgetsBindingObserver {
  User? user;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    checkLoginStatus();
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  void checkLoginStatus() async {
    User? currentUser = FirebaseAuth.instance.currentUser;
    setState(() {
      user = currentUser;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (user == null) {
      return const SignInPage();
    } else {
      return const Dashboard();
    }
  }
}
