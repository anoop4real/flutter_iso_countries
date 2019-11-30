#import "IsoCountriesPlugin.h"
#import <iso_countries/iso_countries-Swift.h>

@implementation IsoCountriesPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftIsoCountriesPlugin registerWithRegistrar:registrar];
}
@end
