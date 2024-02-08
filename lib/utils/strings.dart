class Strings {
  static bool isNullOrEmpty(String? value) {
    if (value == null) {
      return true;
    }

    return value.isEmpty;
  }

  static bool isNotNullOrEmpty(String? value) {
    return !isNullOrEmpty(value);
  }

  static String? trimValue(String? value) {
    if (value == null) {
      return null;
    }

    if (value.trim().isEmpty) {
      return null;
    }

    return value.trim();
  }

  static String localizePhoneNumber(String phoneNumber) {
    //Kenya for now
    if (phoneNumber.substring(0, 3) == '254') {
      return '0${phoneNumber.substring(3)}';
    } else {
      return phoneNumber;
    }
  }

  static String capitalize(String value) {
    return "${value[0].toUpperCase()}${value.substring(1).toLowerCase()}";
  }

  static String formatMeters(int meters) {
    if (meters < 1000) {
      return "$meters m";
    } else {
      return "${(meters / 1000).toStringAsFixed(1)} km";
    }
  }
}
