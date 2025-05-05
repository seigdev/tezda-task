import 'package:flutter/material.dart';
import 'package:tezda_task/app/shared/shared.dart';
import 'package:tezda_task/core/core.dart';

class ActivityComponent extends StatelessWidget {
  final String activityTitle;
  final IconData activityIcon;
  const ActivityComponent(this.activityTitle, this.activityIcon, {super.key});

  @override
  Widget build(BuildContext context) {
    return ThemeBuilder(
      builder: (colors) {
        return GestureDetector(
          onTap: () {},
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: Spacings.spacing20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SizedBox(
                      child: Icon(activityIcon),
                    ),
                    const HSpacer(Spacings.spacing16),
                    BaseText(
                      activityTitle,
                      fontSize: TextSizes.size16,
                      fontWeight: FontWeight.w500,
                    ),
                  ],
                ),
                Icon(
                  Icons.chevron_right_rounded,
                  color: colors.ggray500,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
