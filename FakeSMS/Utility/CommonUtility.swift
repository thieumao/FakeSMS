//
//  CommonUtility.swift
//  FakeSMS
//
//  Created by Thieu Mao on 5/20/17.
//  Copyright © 2017 Hay Nhanh. All rights reserved.
//

import UIKit

class CommonUtility {
    
    class func getPortraitScreenSize() -> CGSize {
        let w = UIScreen.main.bounds.size.width
        let h = UIScreen.main.bounds.size.height
        return CGSize(width: min(w, h), height: max(w, h))
    }
    
    class func getLandscapeScreenSize() -> CGSize {
        let w = UIScreen.main.bounds.size.width
        let h = UIScreen.main.bounds.size.height
        return CGSize(width: max(w, h), height: min(w, h))
    }
    
    class func isPortrait() -> Bool {
        return UIApplication.shared.statusBarOrientation.isPortrait
    }
    
}
