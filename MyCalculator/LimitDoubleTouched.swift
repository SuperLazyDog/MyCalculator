//
//  LimitDoubleTouched.swift
//  MyCalculator
//
//  Created by shareAccount on 2017/03/09.
//  Copyright © 2017年 shareAccount. All rights reserved.
//

import Foundation

class LimitDoubleTouched {//演算子とイコールの重複タッチを無視
    var isDoubleTouched = false
    //var elementCount = 0
    var operatorArray: [Operator] = []
    
    
    func limitTEOALengh() -> Bool {//正しく実行する場合 true
        if operatorArray.count >= 2{
            return false
        }else {
            return true
        }
    }
    func insertElement(operatorEnum o: Operator){
        //elementCount += 1
        operatorArray.append(o)
    }
    
    func neverBeDoubleTouch() {
        isDoubleTouched = false
        //elementCount = 0
        operatorArray = []
    }
    func judgeIfDoubleTouched() -> Bool { //重複処理じゃない場合はtrue
        if operatorArray.count == 1 {
            return true
        }else {
            return false
        }
    }
    func touchedOperator(){
        operatorArray = [.divi]
    }
}
