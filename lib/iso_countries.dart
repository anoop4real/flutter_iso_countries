library iso_countries;

import 'dart:async';

import 'package:flutter/services.dart';
import 'package:iso_countries/country.dart';

export 'country.dart';

/// Platform channel claa to fetch the country info
class IsoCountries {
  static const MethodChannel _channel =
      const MethodChannel('com.anoop4real.iso_countries');

  /// Function to get the country data in English
  static Future<List<Country>> get iso_countries async {
    final List<Country> isoCountries = [];
    final List countries = await _channel.invokeMethod('getISOCountries');
    // Parse
    for (final countryMap in countries) {
      final country = Country(
          name: countryMap['name'], countryCode: countryMap['countryCode']);
      isoCountries.add(country);
    }
    return isoCountries;
  }

  /// Function to get the country data in the language code passed in
  static Future<List<Country>> iso_countries_for_locale(
      locale_identifier) async {
    final List<Country> isoCountries = [];
    final List countries = await _channel.invokeMethod(
        'getISOCountriesForLocale', {'locale_identifier': locale_identifier});
    // Parse
    for (final countryMap in countries) {
      final country = Country(
          name: countryMap['name'], countryCode: countryMap['countryCode']);
      isoCountries.add(country);
    }
    return isoCountries;
  }

  /// Function to get a single country data for the country code and locale identifier passed in
  /// If no valid country found, then you will get an empty hash map
  /// Optional localeIdentifier, if the identifier is not provided, then current locale is used

  static Future<Country> iso_country_for_code_for_locale(countryCode,
      {locale_identifier = ''}) async {
    final countryMap = await _channel.invokeMethod(
        'getCountryForCountryCodeWithLocaleIdentifier',
        {'countryCode': countryCode, 'locale_identifier': locale_identifier});
    // Parse
    final Country country = Country(
        name: countryMap['name'], countryCode: countryMap['countryCode']);
    return country;
  }
}
