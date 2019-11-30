
import 'package:flutter/foundation.dart';

/// Model object to hold the Country data
class Country {
  /// Instantiates an [Country] with the specified [name], and [countryCode]
  const Country({
    @required this.name,
    @required this.countryCode,
  });

  /// the 2-letter ISO code
  final String countryCode;

  /// Country name
  final String name;


}