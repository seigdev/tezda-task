import 'package:tezda_task/app/shared/shared.dart';
import 'package:tezda_task/core/core.dart';
import 'package:flutter/material.dart';

class AppBarComponent extends StatelessWidget implements PreferredSizeWidget {
  const AppBarComponent({
    super.key,
    this.centerTitle,
    this.title,
    this.leading,
    this.actions,
    this.onLeadingTapped,
    this.hasLeading = false,
  });
  final bool? centerTitle;
  final String? title;
  final Widget? leading;
  final List<Widget>? actions;
  final VoidCallback? onLeadingTapped;
  final bool hasLeading;

  @override
  Widget build(BuildContext context) {
    return ThemeBuilder(
      builder: (color) {
        return AppBar(
          backgroundColor: color.kBackground,
          centerTitle: centerTitle ?? false,
          elevation: 0,
          leading: hasLeading ? leading : const CustomBackButton(),
          actions: [
            Padding(
              padding: const EdgeInsets.only(
                right: Spacings.spacing20,
              ),
              child: Row(
                children: [
                  ...?actions,
                ],
              ),
            ),
          ],
          title: title != null
              ? BaseText(
                  title ?? '',
                  fontWeight: FontWeight.w600,
                  fontSize: TextSizes.size18,
                )
              : const SizedBox.shrink(),
        );
      },
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(Spacings.spacing40);
}

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ThemeBuilder(
      builder: (color) {
        return GestureDetector(
          onTap: () => pop(),
          child: Padding(
            padding: const EdgeInsets.all(Spacings.spacing8),
            child: Icon(
              Icons.arrow_back,
              color: color.ggray900,
            ),
          ),
        );
      },
    );
  }
}

class CustomCloseButton extends StatelessWidget {
  final Function()? onTap;
  const CustomCloseButton(this.onTap, {super.key});

  @override
  Widget build(BuildContext context) {
    return ThemeBuilder(
      builder: (color) {
        return GestureDetector(
          onTap: onTap,
          child: Icon(
            Icons.close,
            color: color.ggray900,
          ),
        );
      },
    );
  }
}

GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
