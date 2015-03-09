//
//  MainTabViewController.swift
//  Swift2048
//
//  Created by 许 萍 on 14-6-23.
//  Copyright (c) 2014年 许 萍. All rights reserved.
//

import UIKit

class MainTabViewController:UITabBarController
{
    init()
    {
        super.init(nibName:nil, bundle:nil)
        
        var viewMain = MainViewController()
        
        viewMain.title = "2048"
        
        var viewSetting = SettingViewController(mainview:viewMain)
        
        viewSetting.title = "设置"
        
        var main = UINavigationController(rootViewController:viewMain)
        var setting = UINavigationController(rootViewController:viewSetting)
        
        self.viewControllers = [main, setting]
        
        self.selectedIndex = 0;
        
    }
}