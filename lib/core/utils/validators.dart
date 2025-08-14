extension InputValidators on String {
  bool get isValidEmail {
    return RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$").hasMatch(this);
  }

  bool get isValidPassword {
    return length >= 6;
  }

  bool get isValidName {
    return trim().isNotEmpty && length >= 2;
  }

  bool equals(String other) {
    return this == other;
  }
}

extension StringCheck on String? {
  bool get isNullOrEmpty =>
      this == null || this!.isEmpty || !this!.startsWith("http");
}
