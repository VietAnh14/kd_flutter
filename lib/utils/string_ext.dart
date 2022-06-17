
import 'dart:convert';

extension StringX on String? {

  String orEmpty() {
    return this == null ? '' : this!;
  }

  bool isNullOrEmpty() {
    return this == null || this!.isEmpty;
  }

  Map<String, dynamic>? asJson() {
    if (this == null) {
      return null;
    }

    try {
      return jsonDecode(this!);
    } catch (e) {
      return null;
    }
  }

  String? asBearerToken() {
    if (this == null) {
      return null;
    }

    return "Bearer $this";
  }
}