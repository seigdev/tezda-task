extension StringExtension on String {
  String truncateWithEllipsis(int maxLength) {
    if (length <= maxLength) {
      return this;
    }
    return '${substring(0, maxLength - 3)}...';
  }

  String toSentenceCase() {
    if (isEmpty) {
      return this;
    }

    List<String> words = toLowerCase().split(' ');

    List<String> capitalizedWords = words.map((word) {
      if (word.isNotEmpty) {
        return word[0].toUpperCase() + word.substring(1);
      } else {
        return '';
      }
    }).toList();

    return capitalizedWords.join(' ');
  }

  List<String> toList() {
    List<String> words = toLowerCase().split(' ');
    return words;
  }
}
