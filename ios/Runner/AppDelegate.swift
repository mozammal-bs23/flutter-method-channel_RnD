import UIKit
import Flutter

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)

    let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
    let methodChannel = FlutterMethodChannel(
        name: "com.example.verygoodcore.bettery_health/batteryHealth",
        binaryMessenger: controller.binaryMessenger
    )

    methodChannel.setMethodCallHandler { (call: FlutterMethodCall, result: @escaping FlutterResult) in
        if call.method == "getBatteryLevel" {
            self.getBatteryLevel(result: result)
        } else {
            result(FlutterError(code: "UNAVAILABLE", message: "Battery level not available", details: nil))
        }
    }

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  private func getBatteryLevel(result: FlutterResult) {
      UIDevice.current.isBatteryMonitoringEnabled = true
      let batteryLevel = UIDevice.current.batteryLevel

      if batteryLevel >= 0 {
          result(Int(batteryLevel * 100)) // Convert to percentage
      } else {
          result(FlutterError(code: "UNAVAILABLE", message: "Battery level not available", details: nil))
      }

      UIDevice.current.isBatteryMonitoringEnabled = false
  }
}
