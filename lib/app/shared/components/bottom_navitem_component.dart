import 'package:tezda_task/app/shared/shared.dart';
import 'package:tezda_task/core/core.dart';
import 'package:flutter/material.dart';

class BottomNavItemComponent extends StatelessWidget {
  final IconData icon;
  final String text;
  final bool active;
  final void Function()? onTap;
  const BottomNavItemComponent({
    super.key,
    required this.icon,
    required this.text,
    required this.active,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ThemeBuilder(
      builder: (colors) {
        return SizedBox(
          height: Spacings.spacing70,
          width: Spacings.spacing70,
          child: GestureDetector(
            onTap: onTap,
            child: Column(
              children: [
                Icon(
                  icon,
                  size: Spacings.spacing24,
                  color: active ? colors.tF9A03F : colors.ggray400,
                ),
                BaseText(
                  text,
                  fontSize: TextSizes.size12,
                  color: active ? colors.tF9A03F : colors.ggray400,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
