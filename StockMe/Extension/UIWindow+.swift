//
//  UIWindow+.swift
//  StockMe
//
//  Created by BYUNGKI HAN on 4/13/22.
//

import UIKit

extension UIWindow {
    open override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
            if motion == .motionShake {
                UserManager.shared.current = nil
            }
         }
}

