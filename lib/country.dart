/// Model object to hold the Country data
class Country {
  /// Instantiates an [Country] with the specified [name], and [countryCode]
  const Country({
    required this.name,
    required this.countryCode,
  });

  /// the 2-letter ISO code
  final String countryCode;

  /// Country name
  final String name;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is Country && runtimeType == other.runtimeType && countryCode == other.countryCode;

  @override
  int get hashCode => countryCode.hashCode;

}
