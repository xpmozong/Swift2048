//
//  GameModel.swift
//  Swift2048
//
//  Created by 许 萍 on 14-6-26.
//  Copyright (c) 2014年 许 萍. All rights reserved.
//

import Foundation

class GameModel
{
    var dimension:Int = 0
    
    // 4x4 = 16
    
    var tiles:Array<Int>!
    
    var mtiles:Array<Int>!
    
    var scoreDelegate:ScoreViewProtocol!
    var bestscoreDelegate:ScoreViewProtocol!
    
    var score:Int = 0
    var bestscore:Int = 0
    
    var maxnumber:Int = 0
    
    init(dimension:Int, maxnumber:Int, score:ScoreViewProtocol, bestscore:ScoreViewProtocol)
    {
        self.maxnumber = maxnumber
        self.dimension = dimension
        self.scoreDelegate = score
        self.bestscoreDelegate = bestscore
        initTiles()
    }
    
    // 判断是否通关
    func isSuccess() -> Bool
    {
        for i in 0..(dimension*dimension)
        {
            if(tiles[i] >= maxnumber)
            {
                return true
            }
        }
        
        return false
    }
    
    // 初始化数组
    func initTiles()
    {
        self.tiles = Array<Int>(count:dimension*dimension, repeatedValue:0)
        self.mtiles = Array<Int>(count:dimension*dimension, repeatedValue:0)
    }
    
    
    // 判断该位置能否填充数字 如果返回 false, 表示该位置 已经有值
    func setPosition(row:Int, col:Int, value:Int) -> Bool
    {
        assert(row >= 0 && row < dimension)
        assert(col >= 0 && col < dimension)
        // 3行4列， 即 row=2, col=3 index=2*4+3 = 11
        var index = dimension * row + col
        var val = tiles[index]
        if(val > 0)
        {
            println("该位置已经有值了")
            return false
        }
        tiles[index] = value
        
        return true
    }
    
    // 返回空位置数组
    func emptyPositions()-> Int[]
    {
        var emptytiles = Array<Int>()
        for i in 0..(dimension*dimension)
        {
            if(tiles[i] == 0)
            {
                emptytiles += i
            }
        }
        
        return emptytiles
    }
    
    // 判断是否填满数字
    func isFull()-> Bool
    {
        if(emptyPositions().count == 0)
        {
            return true
        }
        
        return false
    }
    
    // 拷贝值
    func copyToMtiles()
    {
        for i in 0..dimension * dimension
        {
            mtiles[i] = tiles[i]
        }
    }
    
    // 拷贝值
    func copyFromMtiles()
    {
        for i in 0..dimension * dimension
        {
            tiles[i] = mtiles[i]
        }
    }
    
    // 重绘向上滑动
    func reflowUp()
    {
        copyToMtiles()
        var index:Int
        for var i = dimension - 1; i > 0; i--
        {
            for j in 0..dimension
            {
                index = dimension * i + j
                if(mtiles[index - dimension] == 0 && (mtiles[index] > 0))
                {
                    mtiles[index - dimension] = mtiles[index]
                    mtiles[index] = 0
                    
                    var subindex:Int = index
                    while(subindex + dimension < mtiles.count)
                    {
                        if(mtiles[subindex + dimension] > 0)
                        {
                            mtiles[subindex] = mtiles[subindex + dimension]
                            mtiles[subindex + dimension] = 0
                        }
                        subindex += dimension
                    }
                    
                }
            }
        }
        
        copyFromMtiles()
        
    }
    
    // 重绘向下滑动
    func reflowDown()
    {
        copyToMtiles()
        var index:Int
        for i in 0..dimension - 1
        {
            for j in 0..dimension
            {
                index = dimension * i + j
                if(mtiles[index + dimension] == 0 && (mtiles[index] > 0))
                {
                    mtiles[index + dimension] = mtiles[index]
                    mtiles[index] = 0
                    
                    var subindex:Int = index
                    while(subindex - dimension >= 0)
                    {
                        if(mtiles[subindex - dimension] > 0)
                        {
                            mtiles[subindex] = mtiles[subindex - dimension]
                            mtiles[subindex - dimension] = 0
                        }
                        subindex -= dimension
                    }
                    
                }
            }
        }
        copyFromMtiles()
    }
    
    // 重绘向左滑动
    func reflowLeft()
    {
        copyToMtiles()
        var index:Int
        for i in 0..dimension
        {
            for var j = dimension - 1; j > 0; j--
            {
                index = dimension * i + j
                if(mtiles[index - 1] == 0 && (mtiles[index] > 0))
                {
                    mtiles[index - 1] = mtiles[index]
                    mtiles[index] = 0
                    
                    var subindex:Int = index
                    while(subindex + 1 < i * dimension + dimension)
                    {
                        if(mtiles[subindex + 1] > 0)
                        {
                            mtiles[subindex] = mtiles[subindex + 1]
                            mtiles[subindex + 1] = 0
                        }
                        subindex += 1
                    }
                }
            }
        }
        copyFromMtiles()
    }
    
    // 重绘向右滑动
    func reflowRight()
    {
        copyToMtiles()
        var index:Int
        for i in 0..dimension
        {
            for j in 0..dimension - 1
            {
                index = dimension * i + j
                if(mtiles[index + 1] == 0 && (mtiles[index] > 0))
                {
                    mtiles[index + 1] = mtiles[index]
                    mtiles[index] = 0
                    
                    var subindex:Int = index
                    while((subindex - 1) > i * dimension - 1)
                    {
                        if(mtiles[subindex - 1] > 0)
                        {
                            mtiles[subindex] = mtiles[subindex - 1]
                            mtiles[subindex - 1] = 0
                        }
                        subindex -= 1
                    }
                    
                }
            }
        }
        copyFromMtiles()
    }
    
    // 改变分数
    func changeScore(s:Int)
    {
        score += s
        if(bestscore < score)
        {
            bestscore = score
        }
        scoreDelegate.changeScore(value: score)
        bestscoreDelegate.changeScore(value: score)
    }
    
    
    // 向上合并
    func mergeUp()
    {
        copyToMtiles()
        var index:Int
        for var i = dimension - 1; i > 0; i--
        {
            for j in 0..dimension
            {
                index = dimension * i + j
                if(mtiles[index] > 0 && (mtiles[index - dimension]) == mtiles[index])
                {
                    mtiles[index - dimension] = mtiles[index] * 2
                    changeScore(mtiles[index] * 2)
                    mtiles[index] = 0
                }
            }
        }
        copyFromMtiles()
    }
    
    // 向下合并
    func mergeDown()
    {
        copyToMtiles()
        var index:Int
        for i in 0..dimension - 1
        {
            for j in 0..dimension
            {
                index = dimension * i + j
                if(mtiles[index] > 0 && (mtiles[index + dimension]) == mtiles[index])
                {
                    mtiles[index + dimension] = mtiles[index] * 2
                    changeScore(mtiles[index] * 2)
                    mtiles[index] = 0
                }
            }
        }
        copyFromMtiles()
    }
    
    // 向左合并
    func mergeLeft()
    {
        copyToMtiles()
        var index:Int
        for i in 0..dimension
        {
            for var j = dimension - 1; j > 0; j--
            {
                index = dimension * i + j
                if(mtiles[index] > 0 && (mtiles[index - 1]) == mtiles[index])
                {
                    mtiles[index - 1] = mtiles[index] * 2
                    changeScore(mtiles[index] * 2)
                    mtiles[index] = 0
                }
            }
        }
        copyFromMtiles()
    }
    
    // 向左合并
    func mergeRight()
    {
        copyToMtiles()
        var index:Int
        for i in 0..dimension
        {
            for j in 0..dimension - 1
            {
                index = dimension * i + j
                if(mtiles[index] > 0 && (mtiles[index + 1]) == mtiles[index])
                {
                    mtiles[index + 1] = mtiles[index] * 2
                    changeScore(mtiles[index] * 2)
                    mtiles[index] = 0
                }
            }
        }
        copyFromMtiles()
    }
    
    
}