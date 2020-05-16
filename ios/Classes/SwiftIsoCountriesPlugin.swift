import Flutter
import UIKit

public class SwiftIsoCountriesPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "com.anoop4real.iso_countries", binaryMessenger: registrar.messenger())
    let instance = SwiftIsoCountriesPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    
    switch call.method {
    case "getPlatformVersion":
        result("iOS " + UIDevice.current.systemVersion)
    case "getISOCountries":
        result(CountryDataStore().getIsoCountries())
    case "getISOCountriesForLocale":
        guard let args = call.arguments as? [String: Any], let localeId = args["locale_identifier"] as? String else {
            //If no arguments then retuen the default
          result(CountryDataStore().getIsoCountries())
            return
        }
        result(CountryDataStore().getIsoCountries(localeIdentifer: localeId))
    case "getCountryForCountryCodeWithLocaleIdentifier":
        guard let args = call.arguments as? [String: Any], let code = args["countryCode"] as? String ,let localeId = args["locale_identifier"] as? String else {
            //If no arguments then retuen the default
            result([:])
            return
        }
        result(CountryDataStore().getCountryForCountryWithCode(code: code, localeIdentifier: localeId))
    default:
        result(FlutterMethodNotImplemented)
    }
  }
}

internal class CountryDataStore{
    
    private var countriesList = [[String: String]]()
    // Get the list of iso countries from NSLocale
    func getIsoCountries(localeIdentifer: String = "") -> [[String: String]]{
        
        // Get current locale
        var locale = Locale.current as NSLocale
        if (!localeIdentifer.isEmpty) {
            locale = NSLocale(localeIdentifier: localeIdentifer)
        }
        for countryCode in NSLocale.isoCountryCodes {
            let countryName: String? = locale.displayName(forKey: .countryCode, value: countryCode)
            let simpleCountry = ["name": countryName ?? "Unknown","countryCode": countryCode.lowercased() ]
            countriesList.append(simpleCountry)
        }
        countriesList = countriesList.sorted(by: {$0["name"]! < $1["name"]!})
        return countriesList
    }
    
    func getCountryForCountryWithCode(code: String, localeIdentifier: String = "") ->[String: String] {
        if code.isEmpty {
            return [:]
        }
        // Get current locale
        var locale = Locale.current as NSLocale
        if (!localeIdentifier.isEmpty) {
            locale = NSLocale(localeIdentifier: localeIdentifier)
        }

        guard let countryName = locale.displayName(forKey: .countryCode, value: code) else {
            return [:]
        }
        let simpleCountry = ["name": countryName ,"countryCode": code.lowercased() ]
        return simpleCountry
    }
}
