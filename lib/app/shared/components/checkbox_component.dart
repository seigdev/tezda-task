import 'package:flutter/material.dart';
import 'package:tezda_task/core/core.dart';

class CheckboxComponenet extends StatelessWidget {
  final void Function(bool?)? onChanged;
  final bool value;
  const CheckboxComponenet(
      {super.key, required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return ThemeBuilder(builder: (colors) {
      return Checkbox(
        value: value,
        onChanged: onChanged,
        side: BorderSide(color: colors.ggray400),
        fillColor: MaterialStateColor.resolveWith(
          (states) {
            if (states.contains(MaterialState.selected)) {
              return colors.tF9A03F;
            } else {
              return colors.kBackground; // Default color
            }
          },
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
      );
    });
  }
}
