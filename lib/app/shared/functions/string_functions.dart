import 'dart:io';
import 'dart:math' as math;
import 'package:intl/intl.dart';
import 'package:tezda_task/app/shared/shared.dart';

String getDynamicGreeting(String input) {
  String greeting = "";
  if (DateTime.now().hour >= 0 && DateTime.now().hour < 12) {
    greeting = "Good Morning,";
  } else if (DateTime.now().hour >= 12 && DateTime.now().hour < 18) {
    greeting = "Good Afternoon,";
  } else if (DateTime.now().hour >= 18 && DateTime.now().hour < 24) {
    greeting = "Good Evening,";
  }
  return "$greeting $input";
}

List splitToString(String number) {
  String numberStr = number.toString();

  List<String> digitsStr = numberStr.split('');

  // List<int> digits = digitsStr.map(int.parse).toList();

  return digitsStr;
}

String generateRandomUserId() {
  String characters =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz0123456789';
  int length = 24;

  final random = math.Random();

  final chars = List<String>.generate(
      length, (index) => characters[random.nextInt(characters.length)]);

  return chars.join();
}

String fetchProfileUrl(String name) {
  try {
    return 'https://avatar.iran.liara.run/username?username=$name';
  } on SocketException {
    return '';
  } catch (e) {
    return '';
  }
}

String formatAmount(dynamic amount) {
  try {
    if (amount.runtimeType == double || amount.runtimeType == int) {
      return NumberFormat.simpleCurrency(
              locale: 'en_US', decimalDigits: 2, name: 'USD')
          .format(amount);
    }
  } catch (e) {
    log(e);
    return "Can't Format";
  }
  return amount.toString();
}

String formatCompact(dynamic amount) {
  try {
    if (amount.runtimeType == double || amount.runtimeType == int) {
      return NumberFormat.compactSimpleCurrency(locale: 'en_US', name: "USD")
          .format(amount);
    }
  } catch (e) {
    log(e.toString());
    return "Can't Format";
  }
  return amount.toString();
}

bool verifyUrl(String url) {
  try {
    Uri parsedUrl = Uri.parse(url);
    if (parsedUrl.scheme.isNotEmpty) {
      // Use the parsed URL
      log("Valid URL: ${parsedUrl}");
      return true;
    } else {
      log("Invalid URL: Scheme is missing or invalid");
      return false;
    }
  } catch (e) {
    log("Error parsing URL: $e");
    return false;
  }
}
