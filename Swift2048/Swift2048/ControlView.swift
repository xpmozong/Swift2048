//
//  ControlView.swift
//  Swift2048
//
//  Created by 许 萍 on 14-6-26.
//  Copyright (c) 2014年 许 萍. All rights reserved.
//

import UIKit

class ControlView
{
    let defaultFrame = CGRectMake(0, 0, 100, 30)
    
    func createButton(title:String, action:Selector, sender:UIViewController)->UIButton
    {
        var button = UIButton(frame:defaultFrame)
        
        button.backgroundColor = UIColor.orangeColor()
        button.setTitle(title, forState:.Normal)
        button.titleLabel.textColor = UIColor.whiteColor()
        button.titleLabel.font = UIFont(name:"微软雅黑", size:16)
        
        button.addTarget(sender, action:action, forControlEvents:UIControlEvents.TouchUpInside)
        
        return button
    }
    
    func createTextField(value:String, sender:UITextFieldDelegate)->UITextField
    {
        var textField = UITextField(frame:defaultFrame)
        
        textField.backgroundColor = UIColor.clearColor()
        textField.textColor = UIColor.blackColor()
        textField.text = value
        textField.borderStyle = UITextBorderStyle.RoundedRect
        textField.adjustsFontSizeToFitWidth = true
        textField.delegate = sender
        
        return textField
    }
    
    func createSegment(items:String[], action:Selector, sender:UIViewController)->UISegmentedControl
    {
        var segment = UISegmentedControl(items:items)
        
        segment.frame = defaultFrame
        segment.segmentedControlStyle = UISegmentedControlStyle.Bordered
        segment.momentary = false
        segment.addTarget(sender, action:action, forControlEvents:UIControlEvents.ValueChanged)
        
        return segment
    }
    
    func createLabel(title:String)->UILabel
    {
        let label = UILabel()
        
        label.textColor = UIColor.blackColor()
        label.backgroundColor = UIColor.whiteColor()
        label.text = title
        label.frame = defaultFrame
        label.font = UIFont(name:"微软雅黑", size:16)
        
        return label
    }
    
    
    
}
