# iso_countries

A plugin for fetching ISOCountries data from device OS. Name of countries can be
obtained in different languages by passing in the language format. ("fr-fr", "de-de").
No values are HARDCODED, country details are fetched from OS.

```
Android: API level 21 required

```


![iso_countries](https://user-images.githubusercontent.com/6782228/69907084-a58ea080-13ce-11ea-957b-9068a49a6e19.gif)


#### Update

Version 2.0.0 updated to support null safety

## Usage
For detailed use, see the example.
### Fetch Default (English)

```
    List<Country>? countries;
    try {
      countries = await IsoCountries.iso_countries;
    } on PlatformException {
      countries = null;
    }
```

### Fetch based on Language
```

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
    
```

#### Usage in Widget as function
```
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
  
  ```
  #### New API Added

  Passing in a country code( 2 letter) and an optional localeIdentifier( eg 'de-de', 'fr-fr'), you can get a country object with a translated name.

  ```
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
  ```

### Note 

If you are getting any error related to pods while running iOS example, then please delete the podfile and podfile.lock and re-run.