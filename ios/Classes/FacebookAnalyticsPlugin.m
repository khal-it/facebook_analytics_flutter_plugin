#import "FacebookAnalyticsPlugin.h"
#import <facebook_analytics_plugin/facebook_analytics_plugin-Swift.h>

@implementation FacebookAnalyticsPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftFacebookAnalyticsPlugin registerWithRegistrar:registrar];
}
@end
