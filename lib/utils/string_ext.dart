
extension StringX on String? {

  String orEmpty() {
    return this == null ? '' : this!;
  }

  bool isNullOrEmpty() {
    return this == null || this!.isEmpty;
  }
}