import 'package:tezda_task/app/shared/shared.dart';
import 'package:tezda_task/core/core.dart';
import 'package:flutter/material.dart';

class BaseText extends StatelessWidget {
  final String text;
  final double? fontSize;
  final double? letterSpacing;
  final FontWeight? fontWeight;
  final Color? color;
  final VoidCallback? onPressed;
  final TextAlign? textAlign;
  final TextDecoration? textDecoration;
  final TextOverflow? overflow;
  const BaseText(
    this.text, {
    super.key,
    this.fontSize,
    this.letterSpacing,
    this.fontWeight,
    this.color,
    this.onPressed,
    this.textAlign,
    this.textDecoration,
    this.overflow,
  });

  @override
  Widget build(BuildContext context) {
    return ThemeBuilder(
      builder: (colors) {
        return Text(
          text,
          textAlign: textAlign,
          style: TextStyle(
            color: color ?? colors.ggray900,
            fontSize: fontSize,
            fontFamily: 'DMSans',
            decoration: textDecoration,
            fontWeight: fontWeight ?? FontWeight.w400,
            letterSpacing: letterSpacing,
            overflow: overflow,
          ),
        );
      },
    );
  }
}

class BaseTextLink extends StatelessWidget {
  final String text;
  final String redirecText;

  final VoidCallback? onPressed;

  const BaseTextLink(
    this.redirecText,
    this.onPressed, {
    this.text = "",
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ThemeBuilder(
      builder: (colors) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text,
              style: TextStyle(
                color: colors.ggray900,
                fontSize: TextSizes.size14,
                fontFamily: 'DMSans',
                fontWeight: FontWeight.w400,
              ),
            ),
            const HSpacer(5),
            GestureDetector(
              onTap: onPressed,
              child: Text(
                redirecText,
                style: TextStyle(
                  color: colors.tF9A03F,
                  fontSize: TextSizes.size14,
                  fontFamily: 'DMSans',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class BaseLabelText extends StatelessWidget {
  final String label;
  final String value;
  final bool vertical;
  const BaseLabelText({
    super.key,
    required this.label,
    required this.value,
    this.vertical = false,
  });

  @override
  Widget build(BuildContext context) {
    return ThemeBuilder(
      builder: (colors) {
        return vertical
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BaseText(
                    "$label ",
                    color: colors.ggray400,
                    fontWeight: FontWeight.w700,
                  ),
                  const VSpacer(4),
                  BaseText(
                    value,
                    color: colors.ggray900,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BaseText(
                    label,
                    color: colors.ggray500,
                  ),
                  BaseText(
                    value,
                    color: colors.ggray900,
                    fontWeight: FontWeight.w700,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              );
      },
    );
  }
}
