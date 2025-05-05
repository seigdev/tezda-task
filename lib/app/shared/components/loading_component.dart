import 'package:tezda_task/app/shared/constants/spacings/spacings.dart';
import 'package:tezda_task/core/core.dart';
import 'package:flutter/material.dart';

class LinearLoadingComponent extends StatelessWidget {
  final double? width;
  final double? value;
  final double? height;
  final Color? color;
  const LinearLoadingComponent(
      {super.key, this.width, this.value, this.height, this.color});

  @override
  Widget build(BuildContext context) {
    return ThemeBuilder(builder: (colors) {
      return SizedBox(
        width: width,
        child: LinearProgressIndicator(
          color: color ?? colors.tF9A03F,
          value: value,
          backgroundColor: colors.ggray400.withOpacity(0.5),
          borderRadius: BorderRadius.circular(20),
          minHeight: height ?? 2,
        ),
      );
    });
  }
}

class CircularLoadingComponent extends StatelessWidget {
  final Color? color;
  final double? value;
  const CircularLoadingComponent({super.key, this.color, this.value});
  @override
  Widget build(BuildContext context) {
    return ThemeBuilder(builder: (colors) {
      return Center(
        child: SizedBox(
          width: Spacings.spacing20,
          height: Spacings.spacing20,
          child: CircularProgressIndicator(
            value: value,
            color: color ?? colors.tF9A03F,
            strokeWidth: 2,
          ),
        ),
      );
    });
  }
}

class DialogLoadingComponent {
  static void showLoading() {
    showDialog(
      barrierColor: Colors.transparent,
      context: context!,
      builder: (context) {
        return ThemeBuilder(
          builder: (colors) {
            return Stack(
              children: [
                Positioned.fill(
                  child: Container(
                    color: Colors.transparent,
                  ),
                ),
                // Center(
                //   child: SizedBox(
                //     width: Spacings.spacing20,
                //     height: Spacings.spacing20,
                //     child: CircularProgressIndicator(
                //       color: colors.e006869,
                //       strokeWidth: 2,
                //     ),
                //   ),
                // ),
              ],
            );
          },
        );
      },
    );
  }

  static void hideLoading() {
    pop();
  }
}
