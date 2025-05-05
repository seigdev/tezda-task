// ignore_for_file: unused_element

import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';

void showSuccessToast(String message) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.TOP,
    timeInSecForIosWeb: 1,
    backgroundColor: const Color(0xFF006C38),
    textColor: Colors.white,
    fontSize: 14,
  );
}

void showErrorToast(String message) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.TOP,
    timeInSecForIosWeb: 1,
    backgroundColor: const Color(0xFFFF5252),
    textColor: Colors.white,
    fontSize: 14,
  );
}

class _AlertWidget extends StatelessWidget {
  final double width;
  final double height;
  final Widget child;
  final double borderRadius;
  final Color color;

  const _AlertWidget({
    this.width = 200,
    this.height = 50,
    required this.child,
    required this.color,
    this.borderRadius = 30,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: Container(
        color: color,
        width: width,
        height: height,
        child: Center(child: child),
      ),
    );
  }
}
