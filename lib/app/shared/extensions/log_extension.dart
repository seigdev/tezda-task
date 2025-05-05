import 'dart:convert';

import 'package:tezda_task/app/shared/shared.dart';

extension PrettyPrint on Map<String, dynamic> {
  void prettyLogJson() {
    var encoder = const JsonEncoder.withIndent('  ');
    var prettyJson = encoder.convert(this);
    log(prettyJson);
  }
}
