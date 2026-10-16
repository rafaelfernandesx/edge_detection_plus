import Flutter
import UIKit
import WeScan

public class SwiftEdgeDetectionPlugin: NSObject, FlutterPlugin, UIApplicationDelegate {
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "edge_detection", binaryMessenger: registrar.messenger())
        let instance = SwiftEdgeDetectionPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
        registrar.addApplicationDelegate(instance)
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        let args = call.arguments as! Dictionary<String, Any>
        let saveTo = args["save_to"] as! String
        let canUseGallery = args["can_use_gallery"] as? Bool ?? false

        if (call.method == "edge_detect")
        {
            if let rootViewController = UIApplication.shared.delegate?.window??.rootViewController {
                let viewController = rootViewController.visibleViewController
                let destinationViewController = HomeViewController()
                destinationViewController.setParams(saveTo: saveTo, canUseGallery: canUseGallery)
                destinationViewController._result = result
                destinationViewController.modalPresentationStyle = .fullScreen
                viewController.present(destinationViewController, animated: true, completion: nil)
            }
        }
        if (call.method == "edge_detect_gallery")
        {
            if let rootViewController = UIApplication.shared.delegate?.window??.rootViewController {
                let viewController = rootViewController.visibleViewController
                let destinationViewController = HomeViewController()
                destinationViewController.setParams(saveTo: saveTo, canUseGallery: canUseGallery)
                destinationViewController._result = result
                destinationViewController.modalPresentationStyle = .fullScreen
                viewController.present(destinationViewController, animated: true) {
                    destinationViewController.selectPhoto()
                }
            }
        }
    }
}

private extension UIViewController {
    var visibleViewController: UIViewController {
        if let presentedViewController = presentedViewController {
            return presentedViewController.visibleViewController
        }
        if let navigationController = self as? UINavigationController,
           let topViewController = navigationController.topViewController {
            return topViewController.visibleViewController
        }
        if let tabBarController = self as? UITabBarController,
           let selectedViewController = tabBarController.selectedViewController {
            return selectedViewController.visibleViewController
        }
        return self
    }
}
