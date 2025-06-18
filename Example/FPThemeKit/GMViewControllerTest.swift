//
//  GMViewControllerTest.swift
//  FPThemeKit_Example
//
//  Created by admin on 2025/5/15.
//  Copyright © 2025 fanpeng. All rights reserved.
//

import UIKit

import FPThemeKit
@objc class GMViewControllerTest: UIViewController {

    @IBOutlet weak var label: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.themeKit().backgroundColor = kColorWithKey("BAR")
        self.navigationController?.navigationBar.themeKit().tintColor = kColorWithKey("TINT")
        label.themeKit().textColor = kColorWithKey("TEXT")
        
        if #available(iOS 13.0, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.themeKit().backgroundColor = kColorWithKey("BAR") // 设置背景色
            appearance.titleTextAttributes = [
                .foregroundColor: kColorWithKey("TEXT") ?? .white
            ] // 设置标题颜色

            navigationController?.navigationBar.themeKit().standardAppearance = { theme in
                return appearance
            }

            navigationController?.navigationBar.themeKit().scrollEdgeAppearance = { theme in
                return appearance
            }
        } else {
            navigationController?.navigationBar.themeKit().barTintColor = kColorWithKey("BAR")
            navigationController?.navigationBar.themeKit().backgroundColor = kColorWithKey("BAR")
        }
        


    }


    @IBAction func red(_ sender: Any) {
        FPThemeManager.share().updateTheme("RED")
    }
    
    @IBAction func night(_ sender: Any) {
        FPThemeManager.share().updateTheme("NIGHT")
    }
    
    @IBAction func normal(_ sender: Any) {
        FPThemeManager.share().updateTheme("NORMAL")

    }
}
