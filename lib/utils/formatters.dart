class Formatters {
  static String camelCaseToSnakeCase(String input) {
    final regex = RegExp(r'(?<!^)([A-Z])');
    return input
        .replaceAllMapped(regex, (match) => '_${match.group(1)}')
        .toLowerCase();
  }
}
