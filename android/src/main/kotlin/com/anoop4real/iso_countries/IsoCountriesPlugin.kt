package com.anoop4real.iso_countries

import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry.Registrar
import java.util.*
import kotlin.collections.ArrayList
import kotlin.collections.HashMap

class IsoCountriesPlugin: MethodCallHandler {
  companion object {
    @JvmStatic
    fun registerWith(registrar: Registrar) {
      val channel = MethodChannel(registrar.messenger(), "com.anoop4real.iso_countries")
      channel.setMethodCallHandler(IsoCountriesPlugin())
    }
  }

  override fun onMethodCall(call: MethodCall, result: Result) {
    if (call.method == "getPlatformVersion") {
      result.success("Android ${android.os.Build.VERSION.RELEASE}")
    } else if (call.method == "getISOCountries"){
      result.success(CountryDataStore.getIsoCountries())
    }
    else if (call.method == "getISOCountriesForLocale"){
      // TODO: Implement in a better way
      val args = call.arguments as? HashMap<String,String>
      if (args !=null){
        val identifier = args.getOrElse("locale_identifier"){"en_US"}
        result.success(CountryDataStore.getIsoCountries(identifier))
      }else{
        result.success(CountryDataStore.getIsoCountries())
      }
    }
    else if (call.method == "getCountryForCountryCodeWithLocaleIdentifier") {
      val args = call.arguments as? HashMap<String,String>
      if (args !=null){
        val identifier = args.getOrElse("locale_identifier"){""}
        val code = args.getOrElse("countryCode"){""}
        result.success(CountryDataStore.getCountryForCountryCode(code,identifier))
      } else {
        // Return an empty hashmap if arguments are missing
        result.success(hashMapOf<String, String>())
      }
    }
    else {
      result.notImplemented()
    }
  }
}

class CountryDataStore private constructor() {

  companion object{

    fun getIsoCountries(localeIdentifier: String = "" ) : ArrayList<HashMap<String, String>> {
      var countriesList = arrayListOf<HashMap<String, String>>()
      for (countryCode in Locale.getISOCountries()) {
        lateinit var locale: Locale
        // If no locale is passed, then take the locale from Current
        if (localeIdentifier.isEmpty()) {
          locale = Locale.getDefault()
        } else {
          locale = Locale(localeIdentifier,countryCode)
        }
        var countryName: String? = locale.getDisplayCountry(Locale.forLanguageTag(localeIdentifier))
        if (countryName == null) {
          countryName = "UnIdentified"
        }
        val simpleCountry = hashMapOf("name" to countryName, "countryCode" to countryCode)
        countriesList.add(simpleCountry)
      }
      countriesList = ArrayList(countriesList.sortedWith(compareBy { it["name"] }))
      return  countriesList
    }

    // Get a country name from code
    fun getCountryForCountryCode(code: String, localeIdentifier: String = "" ): HashMap<String, String> {
      if (code.isEmpty()){
        return hashMapOf<String, String>()
      }
      lateinit var locale: Locale
      // If no locale is passed, then take the locale from Current
      if (localeIdentifier.isEmpty()) {
        locale = Locale.getDefault()
      } else {
        locale = Locale(localeIdentifier,code)
      }
      val countryName: String? = locale.getDisplayCountry(Locale.forLanguageTag(localeIdentifier))
      if (countryName == null) {
        return hashMapOf<String, String>()
      }
      val simpleCountry = hashMapOf("name" to countryName, "countryCode" to code)
      return simpleCountry
    }
  }
}

