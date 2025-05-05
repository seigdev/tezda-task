import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tezda_task/app/modules/authentication/domain/controllers/authentication_controller.dart';
import 'package:tezda_task/app/shared/shared.dart';
import 'package:tezda_task/core/core.dart';

class LogOutComponent extends ConsumerWidget {
  const LogOutComponent({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ThemeBuilder(
      builder: (colors) {
        return GestureDetector(
          onTap: () {
            showDialog(
              context: context,
              builder: (context) {
                if (Platform.isIOS) {
                  return CupertinoAlertDialog(
                    title: const BaseText(
                      "Logout",
                      fontWeight: FontWeight.w600,
                    ),
                    content:
                        const BaseText("Are you sure you want to log out?"),
                    actions: <Widget>[
                      TextButton(
                        child: const Text("Cancel"),
                        onPressed: () {
                          pop();
                        },
                      ),
                      TextButton(
                        child: const BaseText("Logout", color: Colors.red),
                        onPressed: () async {
                          final authController =
                              ref.read(authenticationProvider);
                          await authController.signOut();
                        },
                      ),
                    ],
                  );
                }
                return AlertDialog(
                  title: const BaseText(
                    "Logout",
                    fontWeight: FontWeight.w600,
                  ),
                  content: const BaseText("Are you sure you want to log out?"),
                  actions: <Widget>[
                    TextButton(
                      child: const Text("Cancel"),
                      onPressed: () {
                        pop();
                      },
                    ),
                    TextButton(
                      child: const BaseText("Logout", color: Colors.red),
                      onPressed: () async {
                        final authController = ref.read(authenticationProvider);
                        await authController.signOut();
                      },
                    ),
                  ],
                );
              },
            );
          },
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: Spacings.spacing20),
            child: const Row(
              children: [
                SizedBox(
                  child: Icon(
                    IconlyBroken.logout,
                    color: Colors.red,
                  ),
                ),
                HSpacer(Spacings.spacing16),
                BaseText(
                  "Log Out",
                  color: Colors.red,
                  fontSize: TextSizes.size16,
                  fontWeight: FontWeight.w500,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
