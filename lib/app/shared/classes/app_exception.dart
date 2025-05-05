import 'dart:convert';

import 'package:tezda_task/app/shared/shared.dart';
import 'package:http/http.dart';

class AppException implements Exception {
  late final String message;

  AppException(String? message) {
    this.message = message ?? "Something went wrong";
  }

  factory AppException.fromResponse(Response r) {
    showErrorToast(jsonDecode(r.body)['message']);
    return AppException(jsonDecode(r.body)['message']);
  }
}
