import SwiftUI
import Firebase

@main
struct E_commerceApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    @AppStorage("isOnboarding") var isOnboarding:Bool = true
    var body: some Scene {
        WindowGroup {
            if isOnboarding{
                OnBoardingView()
            }
            else {
                ContentView()
            }
        }
    }
}

class AppDelegate: NSObject,UIApplicationDelegate {
    static var orientationLock = UIInterfaceOrientationMask.portrait

    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        return AppDelegate.orientationLock
    }
//  Disabling Screen recording
    func detectScreenRecording(action: @escaping () -> ()) {
            let mainQueue = OperationQueue.main
            NotificationCenter.default.addObserver(forName: UIScreen.capturedDidChangeNotification, object: nil, queue: mainQueue) { notification in
                // executes after screenshot
                action()
            }
        }
        
       //Call in vewWillApper
    func detectScreenRecording() {
                print(UIScreen.main.isCaptured)
                if UIScreen.main.isCaptured{
                    //your view hide code
                    print("self.toHide()")
                }else{
                    //  self.sceneDeleg(ate?.window?.isHidden = false
                    //your view show code
                    print("self.toShow()")
                }
            }
//Configuring firebase
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
        }
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
//    Phone Auth notification handler
    func application(_ application: UIApplication,
                     didReceiveRemoteNotification notification: [AnyHashable : Any],
                     fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        if Auth.auth().canHandleNotification(notification) {
            completionHandler(.noData)
            return
        }
        
    }
}
