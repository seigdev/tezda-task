import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

final context = navigatorKey.currentContext;

Future<T?> pushTo<T>(Widget page, [PushStyle? pushStyle]) async {
  return await Navigator.push<T>(
      context!,
      pushStyle == PushStyle.cupertino
          ? CupertinoPageRoute(builder: (context) => page)
          : MaterialPageRoute(builder: (context) => page));
}

Future<T> pushReplacementTo<T>(Widget page, [PushStyle? pushStyle]) async {
  return await Navigator.pushReplacement(
      context!,
      pushStyle == PushStyle.cupertino
          ? CupertinoPageRoute(builder: (context) => page)
          : MaterialPageRoute(builder: (context) => page));
}

void pushToAndClearStack(Widget page) {
  Navigator.of(context!).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => page), (route) => false);
}

void pop<T>([T? value]) {
  return Navigator.pop<T>(context!, value);
}

Future<T?> pushNamed<T>(String page, [PushStyle? pushStyle]) {
  return Navigator.pushNamed(context!, page);
}

Future<T?> pushNamedAndClear<T>(String page, [PushStyle? pushStyle]) {
  return Navigator.pushNamedAndRemoveUntil(context!, page, (route) => false);
}

enum PushStyle { material, cupertino }
