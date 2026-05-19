extension StringFormatting on String {
  String toSnakeCase() => toLowerCase().replaceAll(' ', '_');

  String capitalize() {
    if (isEmpty) {
      return this;
    }
    return '${this[0].toUpperCase()}${substring(1).toLowerCase()}';
  }
}
