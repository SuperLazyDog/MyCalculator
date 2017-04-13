//
//  DoubleEqual.swift
//  MyCalculator
//
//  Created by shareAccount on 2017/03/09.
//  Copyright © 2017年 shareAccount. All rights reserved.
//

import Foundation

class DoubleEqual {
    var touchedEqual = false
    //var doubleTouchedEqual = false
    var operatorTemp: Operator = .plus
    var operantTemp: Double = 0.0
    var nowNum = 0.0
    //タッチした
    func hasTouchedEqual() {
        /*if touchedEqual {
            doubleTouchedEqual = true
        }*/
        touchedEqual = true
    }
    //ダブルタッチの場合　true
    func isDoubleTouched() -> Bool {
        if touchedEqual { //&& doubleTouchedEqual {
            return true
        }
        return false
    }
    
    //リセット　成功すればtrue
    func reSet(){
        touchedEqual = false
        //doubleTouchedEqual = false
        nowNum = 0.0
        operantTemp = 0.0
    }
    
    //連続タッチの場合の処理　引数は今のオペラント
    func doubleTouchProcessor(nowNum n: Double) -> Double {
        switch operatorTemp {
        case .plus:
            return n + operantTemp
        case .minus:
            return n - operantTemp
        case .multi:
            return n * operantTemp
        case .divi:
            return n / operantTemp
        }
    }
    
}
