import UIKit
import Flutter
import common

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    lazy var sqlDelightManager: SqlDelightManager = {
        Db().defaultDriver()
        let accountingRepository = AccountingRepository(accountingDB: Db().instance)
        return SqlDelightManager(accountingRepository: accountingRepository)
    }()
    
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?
    ) -> Bool {
    let controller: FlutterViewController = window?.rootViewController as! FlutterViewController

    let sqlDelightChannel = FlutterMethodChannel(
        name: SqlDelightManagerKt.SQLDELIGHT_CHANNEL,
        binaryMessenger: controller)

    sqlDelightChannel.setMethodCallHandler({
        [weak self] (methodCall: FlutterMethodCall, flutterResult: @escaping FlutterResult) -> Void in
        let args = methodCall.arguments as? [String: Any] ?? [:]
        
        self?.sqlDelightManager.methodCall(
            method: methodCall.method,
            arguments: args,
            result: {(r: Any) -> Void in
                flutterResult(r)
            })
    })

    GeneratedPluginRegistrant.register(with: self)
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    override func applicationWillTerminate(_ application: UIApplication) {
        sqlDelightManager.clear()
    }
}
