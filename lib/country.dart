
import 'package:flutter/foundation.dart';

class Country {

  /// the 2-letter ISO code
  final String countryCode;

  /// Country name
  final String name;

  /// Instantiates an [Country] with the specified [name], and [countryCode]
  const Country({
    @required this.name,
    @required this.countryCode,
  });
}