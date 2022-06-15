
extension StringX on String? {

  String orEmpty() {
    return this == null ? '' : this!;
  }
}