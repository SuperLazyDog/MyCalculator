//
//  LimitDoubleMax.swift
//  MyCalculator
//
//  Created by shareAccount on 2017/03/09.
//  Copyright © 2017年 shareAccount. All rights reserved.
//

import Foundation

class LimitDoubleMax {//overの場合false
    private var isOveRange = false
    init(num: Double) {
         isOveRange = limitDoubleMax(douleNum: num)
    }
    func limitDoubleMax(douleNum: Double) -> Bool {
        if douleNum > DBL_MAX || douleNum < DBL_MIN {
            return false
        }
        return true
    }
}
