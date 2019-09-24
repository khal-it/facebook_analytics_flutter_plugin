import Flutter
import UIKit
import FBSDKCoreKit





public class SwiftFacebookAnalyticsPlugin: NSObject, FlutterPlugin {
    
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "facebook_analytics_plugin", binaryMessenger: registrar.messenger())
    let instance = SwiftFacebookAnalyticsPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
    
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    handleLogEvent(call: call, result: result)
    result(nil)
    
  }
  
  
    func handleLogEvent(call: FlutterMethodCall, result: @escaping FlutterResult) {
        let parameters = call.arguments as! [String:Any]
        let eventName = parameters["name"] as! String
        
        if var optionalParams = parameters["parameters"] as? [String:Any] {
            optionalParams = serializeParameterDict(paramDict: optionalParams)
            AppEvents.logEvent(AppEvents.Name(eventName), parameters: optionalParams)
        } else {
            AppEvents.logEvent(AppEvents.Name(eventName))
        }
        
    }
    
    func serializeParameterDict(paramDict: [String:Any]) -> [String:Any] {
        var convertedParams : [String :Any] = [:]
        for (key, val ) in paramDict {
            switch val {
                case let i as Int:
                    convertedParams.updateValue(NSNumber(value: i) , forKey: key)
                    break
                case let s as String:
                    convertedParams.updateValue(NSString(string: s ), forKey: key)
                    break
                case let d as Double:
                    convertedParams.updateValue(NSNumber(value: d), forKey: key)
                    break
                case let b as Bool:
                    convertedParams.updateValue(NSNumber(value: b ), forKey: key)
                    break
                default:
                    print("Type not supported: ")
                    print(type(of: val))
                }
         
            
            }
           return convertedParams
        }
    
}
