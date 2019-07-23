//
//  UIWindow.swift
//  GHRepoBrowser
//
//  Created by Andrzej Puczyk on 17/07/2019.
//  Copyright © 2019 Andrzej Puczyk. All rights reserved.
//

import UIKit

extension UIWindow {

    func setRootViewController(_ viewController: UIViewController?, animated: Bool) -> Void {
        if animated {
            // create snapshot of current root view controller
            let snapshot = snapshotView(afterScreenUpdates: false)

            // change root view controller
            rootViewController = viewController

            // show snapshot and remove it with animation
            if let snapshot = snapshot {
                addSubview(snapshot)
            }

            UIView.animate(withDuration: 0.5,
                           animations: { () -> Void in snapshot?.alpha = 0.0 },
                           completion: { (finished) -> Void in snapshot?.removeFromSuperview() })
        } else {
            rootViewController = viewController
        }
    }

}
