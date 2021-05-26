//
//  EYBaseNavigationController.swift
//  EY.Mtel_ProjectTemplate_Swift
//
//  Created by zxj on 2020/8/11.
//  Copyright © 2020 EY.Mtel. All rights reserved.
//

import UIKit

class EYBaseNavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        let appearance = UIBarButtonItem.appearance()
        appearance.setBackButtonTitlePositionAdjustment(UIOffset.init(horizontal: 0.0, vertical: -60), for: .default)
        self.navigationBar.isTranslucent = true
        self.navigationBar.barTintColor = UIColor.init(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 0.7)
        #if swift(>=4.0)
        self.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.init(red: 38/255.0, green: 38/255.0, blue: 38/255.0, alpha: 1.0), NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16.0)]
        #elseif swift(>=3.0)
        self.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.init(red: 38/255.0, green: 38/255.0, blue: 38/255.0, alpha: 1.0), NSFontAttributeName: UIFont.systemFont(ofSize: 16.0)];
        #endif
        self.navigationBar.tintColor = UIColor.init(red: 38/255.0, green: 38/255.0, blue: 38/255.0, alpha: 1.0)
        
    }
    
}
