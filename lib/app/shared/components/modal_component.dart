import 'package:flutter/material.dart';
import 'package:tezda_task/core/core.dart';

class ModalComponent extends StatelessWidget {
  final Widget child;
  const ModalComponent({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return ThemeBuilder(
      builder: (colors) {
        return Dialog(
          insetPadding: const EdgeInsets.symmetric(horizontal: 10),
          backgroundColor: colors.kBackground,
          surfaceTintColor: colors.kBackground,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: child,
          ),
        );
      },
    );
  }
}
