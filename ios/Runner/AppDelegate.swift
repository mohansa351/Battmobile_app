import Flutter
import UIKit
import FirebaseCore
import PhoneNumberKit

@main
@objc class AppDelegate: FlutterAppDelegate {
 override func application(
   _ application: UIApplication,
   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
 ) -> Bool {
   FirebaseApp.configure() // Ensure Firebase initializes first
   GeneratedPluginRegistrant.register(with: self)
   let _phoneNumberKit: PhoneNumberKit = PhoneNumberKit()
   return super.application(application, didFinishLaunchingWithOptions: launchOptions)
 }
}

// // import Firebase

// // @UIApplicationMain
// // class AppDelegate: UIResponder, UIApplicationDelegate {

// //     func application(_ application: UIApplication,
// //                      didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
// //         FirebaseApp.configure()
// //         return true
// //     }
// // }

// import UIKit
// import FirebaseCore


// @UIApplicationMain
// class AppDelegate: UIResponder, UIApplicationDelegate {

//   var window: UIWindow?

//   func application(_ application: UIApplication,
//     didFinishLaunchingWithOptions launchOptions:
//                    [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
//     FirebaseApp.configure()

//     return true
//   }
// }

