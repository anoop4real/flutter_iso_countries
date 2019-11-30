# iso_countries

A plugin for fetching ISOCountries data from device OS. Name of countries can be
obtained in different languages by passing in the language format. ("fr-fr", "de-de").
No values are HARDCODED, country details are fetched from OS.


![iso_countries](https://user-images.githubusercontent.com/6782228/69907084-a58ea080-13ce-11ea-957b-9068a49a6e19.gif)

## Usage

```
  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> prepareDefaultCountries() async {
    List<Country> countries;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      countries = await IsoCountries.iso_countries;
    } on PlatformException {
      countries = null;
    }
    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      countryList = countries;
    });
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> prepareLocaleSpecificCountries() async {
    List<Country> countries;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      // If you need country names in a specific language please pass language code sample
      // fr-fr, en-en, de-de... IMPORTANT: In Android there seem to be some issue with case
      // so passing fr-FR wont work
      countries = await IsoCountries.iso_countries_for_locale("fr-fr");
    } on PlatformException {
      countries = null;
    }
    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      countryList = countries;
    });
  }
  
  ```
  
