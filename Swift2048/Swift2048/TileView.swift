//
//  TileView.swift
//  Swift2048
//
//  Created by 许 萍 on 14-6-23.
//  Copyright (c) 2014年 许 萍. All rights reserved.
//

import UIKit

class TileView:UIView{
    
    let colorMap = [
        2:UIColor.brownColor(),
        4:UIColor.purpleColor(),
        8:UIColor.redColor(),
        16:UIColor.greenColor(),
        32:UIColor.blueColor(),
        64:UIColor.cyanColor(),
        128:UIColor.magentaColor(),
        256:UIColor.orangeColor(),
        512:UIColor.grayColor(),
        1024:UIColor.lightGrayColor(),
        2048:UIColor.blackColor()
    
    ]
    
    var value:Int = 0{
        didSet{
            backgroundColor = colorMap[value]
            numberLabel.text = "\(value)"
        }
    }
    
    var numberLabel:UILabel
    
    init(pos:CGPoint, width:CGFloat, value:Int)
    {
        numberLabel = UILabel(frame:CGRectMake(0, 0, width, width))
        numberLabel.textColor = UIColor.whiteColor()
        numberLabel.textAlignment = NSTextAlignment.Center
        numberLabel.minimumScaleFactor = 0.5
        numberLabel.font = UIFont.boldSystemFontOfSize(16)
        numberLabel.text = "\(value)"
        super.init(frame:CGRectMake(pos.x, pos.y, width, width))
        addSubview(numberLabel)
        self.value = value
        backgroundColor = colorMap[value];
    }
    
}
