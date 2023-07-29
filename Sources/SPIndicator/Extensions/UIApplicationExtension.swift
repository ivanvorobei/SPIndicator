//
//  UIApplicationExtension.swift
//  SPIndicator
//
//  Created by flexih on 2023/7/29.
//

import UIKit

#if os(visionOS)
public extension UIApplication {
    var keyWindow: UIWindow? {
        for scene in UIApplication.shared.connectedScenes {
            if scene.activationState == .foregroundActive,
               let sceneDeleate = (scene as? UIWindowScene)?.delegate as? UIWindowSceneDelegate,
               let window = sceneDeleate.window {
                return window
            }
        }
        print("\(#function): Failed to retrieve the window.")
        return nil
    }
}
#endif
