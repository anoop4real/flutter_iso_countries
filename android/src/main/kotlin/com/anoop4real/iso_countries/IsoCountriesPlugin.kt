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
    else {
      result.notImplemented()
    }
  }
}

class CountryDataStore private constructor() {

  companion object{

    var countriesList = arrayListOf<HashMap<String, String>>()

    fun getIsoCountries(localeIdentifer: String = "" ) : ArrayList<HashMap<String, String>> {
      countriesList.clear()
      for (countryCode in Locale.getISOCountries()) {
        val locale = Locale(localeIdentifer,countryCode)
        var countryName: String? = locale.getDisplayCountry(Locale.forLanguageTag(localeIdentifer))
        if (countryName == null) {
          countryName = "UnIdentified"
        }
        val simpleCountry = hashMapOf("name" to countryName, "countryCode" to countryCode)
        countriesList.add(simpleCountry)
      }
      countriesList = ArrayList(countriesList.sortedWith(compareBy { it["name"] }))

      return  countriesList
    }

  }
}

