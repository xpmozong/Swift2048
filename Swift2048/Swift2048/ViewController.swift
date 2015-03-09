//
//  ViewController.swift
//  Swift2048
//
//  Created by 许 萍 on 14-6-23.
//  Copyright (c) 2014年 许 萍. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
                            
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func startGame(sender:UIButton)
    {
        let alertView = UIAlertView()
        alertView.title = "开始"
        alertView.message = "游戏就要开始了"
        alertView.addButtonWithTitle("Ready Go!")
        alertView.show()
        alertView.delegate = self
    }
    
    func alertView(alertView: UIAlertView, clickedButtonAtIndex: Int){
        self.presentViewController(MainTabViewController(), animated:true, completion:nil);
    }
    
}

