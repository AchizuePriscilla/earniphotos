

import 'dart:developer';

class ParserUtil<T> {

  static String parseJsonString(
    Object? json,
    String param, {
    String? defaultValue,
  }) {
    try {
      json = json as Map;
      Object? result = json[param];

      if (result == null) return defaultValue ?? '';

      String resultString = result.toString();
      final parsedString =
          resultString.isEmpty ? defaultValue ?? resultString : resultString;

      return parsedString;
    } catch (e) {
     log(e.toString());

      return defaultValue ?? '';
    }
  }
 static bool parseJsonBoolean(Map? json, String param) {
    try {
      Object? result = json![param];

      if (result == null) return false;
      return result as bool;
    } catch (e) {
      return false;
    }
  }
}
