import 'dart:developer' as dev;

void log(dynamic value) {
  if (value is int) {
    dev.log('Integer: $value');
  } else if (value is double) {
    dev.log('Double: $value');
  } else if (value is String) {
    dev.log('String: "$value"');
  } else if (value is bool) {
    dev.log('Boolean: $value');
  } else if (value is List) {
    dev.log('List: $value');
  } else if (value is Map) {
    dev.log('Map: $value');
  } else {
    dev.log('Unknown type: $value');
  }
}
