import 'dart:async';

import 'package:flutter/services.dart';
import 'package:iso_countries/country.dart';

class IsoCountries {
  static const MethodChannel _channel =
      const MethodChannel('com.anoop4real.iso_countries');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static Future<List<Country>> get iso_countries async {
    final List<Country> isoCountries = [];
    final List countries = await _channel.invokeMethod('getISOCountries');
    // Parse
    for(final countryMap in countries){
      final country = Country(name: countryMap['name'], countryCode: countryMap['countryCode']);
      isoCountries.add(country);
    }
    return isoCountries;
  }

  static Future<List<Country>> iso_countries_for_locale(locale_identifier) async {
    final List<Country> isoCountries = [];
    final List countries = await _channel.invokeMethod('getISOCountriesForLocale',{'locale_identifier' : locale_identifier});
    // Parse
    for(final countryMap in countries){
      final country = Country(name: countryMap['name'], countryCode: countryMap['countryCode']);
      isoCountries.add(country);
    }
    return isoCountries;
  }
}
