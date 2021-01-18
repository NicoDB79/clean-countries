//
//  AppDelegate.swift
//  CleanCountries
//
//  Created by Nicola De Bei on 12/12/2020.
//

import UIKit
import RealmSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        if #available(iOS 13.0, *) {
            window = UIWindow(frame: UIScreen.main.bounds)
        }
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
}

// MARK: UIApplication extension
extension UIApplication {
    
    func setDefaultRealm() {
        var config = Realm.Configuration()
        
        // Use the default directory, but replace the filename with the app name
        config.fileURL = config.fileURL!.deletingLastPathComponent().appendingPathComponent("CleanCountries.realm")
        AppLog.d("Realm: version = \(config.schemaVersion)")
                
        // Set this as the configuration used for the default Realm
        Realm.Configuration.defaultConfiguration = config
        
        let _ = try! Realm()
    }
    
    /* Setup Clean Countries loggers. Default is AppLog using NSLog
     * Yu can plant any logger you want.
     * For example you can provide the implementation of other loggers as CocoaLumberjack or Crashlytics.
    */
    func configureLoggers(level: AppLogLevel = .v) {
        AppLog.plant(tree: DefaultLogger(level))
        //AppLog.plant(tree: CocoaLumberjackLogger(level))
        //AppLog.plant(tree: CrashlyticsLogger(level))
    }
    
    class func topViewController(controller: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let navigationController = controller as? UINavigationController {
            return topViewController(controller: navigationController.visibleViewController)
        }
        if let tabController = controller as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return topViewController(controller: selected)
            }
        }
        if let presented = controller?.presentedViewController {
            return topViewController(controller: presented)
        }
        return controller
    }
}
