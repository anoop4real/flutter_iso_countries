import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iso_countries/iso_countries.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<Country> countryList = <Country>[];
  Country? country;
  @override
  void initState() {
    super.initState();
    prepareDefaultCountries();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> prepareDefaultCountries() async {
    List<Country>? countries;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      countries = await IsoCountries.iso_countries;
    } on PlatformException {
      countries = null;
    }
    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) {
      return;
    }

    setState(() {
      if (countries != null) {
        countryList = countries;
      }
    });
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> prepareLocaleSpecificCountries() async {
    List<Country>? countries;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      // If you need country names in a specific language please pass language code sample
      // fr-fr, en-en, de-de... IMPORTANT: In Android there seem to be some issue with case
      // so passing fr-FR wont work
      countries = await IsoCountries.iso_countries_for_locale('fr-fr');
    } on PlatformException {
      countries = null;
    }
    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) {
      return;
    }

    setState(() {
      if (countries != null) {
        countryList = countries;
      }
    });
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  // IMPORTANT: Make sure the country code passed in is valid, in Android passing
  // in a wrong country code, returns the country name as passed in country code not sure why.
  Future<void> getCountryForCodeWithIdentifier(
      String code, String localeIdentifier) async {
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      country = await IsoCountries.iso_country_for_code_for_locale(code,
          locale_identifier: localeIdentifier);
    } on PlatformException {
      country = null;
    }
    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) {
      return;
    }

    setState(() {
      print(country?.name);
    });
  }

  @override
  Widget build(BuildContext context) => MaterialApp(
    home: Scaffold(
        appBar: AppBar(
          actions: <Widget>[
            TextButton(
                onPressed: prepareLocaleSpecificCountries,
                child: const Text('fr-fr'),
                style: TextButton.styleFrom(
                  primary: Colors.white,
                )),
            TextButton(
              onPressed: prepareDefaultCountries,
              style: TextButton.styleFrom(
                primary: Colors.white,
              ),
              child: const Text('Default'),
            ),
          ],
          title: const Text('Plugin example app'),
        ),
        body: _buildListOfCountries()),
  );

  Widget _buildListOfCountries() => ListView.builder(
    itemBuilder: (BuildContext context, int index) {
      final Country country = countryList[index];
      return ListTile(
          title: Text(country.name),
          subtitle: Text(country.countryCode),
          onTap: () =>
          // Test: This will get a country object for a code and optional locale passed in
          getCountryForCodeWithIdentifier(
              country.countryCode, 'de-de'));
    },
    itemCount: countryList.length,
  );
}