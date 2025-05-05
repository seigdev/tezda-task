bool validateMatricNumber(String matricNumber) {
  if (matricNumber.length < 7) {
    return false;
  }
  return true;
}

bool validatePassword(String password) {
  final RegExp specialCharPattern = RegExp(r'[!@#\$%^&*(),.?":{}|<>]');
  final RegExp digitPattern = RegExp(r'\d');
  final RegExp uppercasePattern = RegExp(r'[A-Z]');
  final RegExp lowercasePattern = RegExp(r'[a-z]');

  // Check if the password meets the criteria
  if (password.length < 8) {
    return false;
  }
  if (!specialCharPattern.hasMatch(password)) {
    return false;
  }
  if (!digitPattern.hasMatch(password)) {
    return false;
  }
  if (!uppercasePattern.hasMatch(password)) {
    return false;
  }
  if (!lowercasePattern.hasMatch(password)) {
    return false;
  }
  return true;
}

List<Map<String, dynamic>> searchList(
    List<Map<String, dynamic>> data, String keyword) {
  return data.where((location) {
    return location.values.any((value) =>
        value.toString().toLowerCase().contains(keyword.toLowerCase()));
  }).toList();
}
