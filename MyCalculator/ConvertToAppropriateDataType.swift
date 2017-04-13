//
//  ConvertToAppropriateDataType.swift
//  MyCalculator
//
//  Created by shareAccount on 2017/03/10.
//  Copyright © 2017年 shareAccount. All rights reserved.
//

import Foundation

class ConvertToAppropriateDataType {
    private var outWithInt = 0
    private var outWithDouble = 0.0
    private var initApproString: String = ""
    private var textString: String
    private let consTextString: String
    private var inPutTextString: String
    private var (intString, dot, doubleString) = ("", "", "")
    private var isMinus = false
    
    init(textString: String) {
        self.textString = textString
        self.consTextString = textString
        self.inPutTextString = textString
    }
    
    private func errorMessageProcesser(_ textString: String) -> String {//ローカル エラーの場合0に戻る
        for char in textString.characters {
            if char == "エ" {
                return "0"
            }
        }
        return textString
    }
    
    private func initString(_ textString: inout String) { //ローカル 文字列最初または最後にドットがあれば削除
        for _ in 0..<2 {
            if textString.hasPrefix(".") {
                textString.remove(at: textString.startIndex)
            }
            if textString.hasPrefix("-"){
                isMinus = true
                textString.remove(at: textString.startIndex)
            }
        }
        //textString = isMinus ? "-"+textString : textString
        /*let stringTrueLastIndex = textString.index(before: textString.endIndex)
        if textString.hasSuffix(".") {
            textString.remove(at: stringTrueLastIndex)
        }*/
    }
    
    private func isHasE(_ textString: String) -> Bool {//ローカル　9e-8のような形の場合かどうかを判断
        for everyChar in textString.characters {
            if everyChar == "e" || everyChar == "E" {
                return true
            }
        }
        return false
    }
    
    private func isDouble (_ textString: inout String) -> Bool {//ローカル 整数にした方が良いかを判断
        //-----------------------------------------------------
        //2017/03/12 
        //頭のドットがinitString(:inout String)に削除されたから、
        //ドットがあれば浮動小数点数とみなせる
        //-----------------------------------------------------
        var isDouble = false
        for everyChar in textString.characters {
            if everyChar == "." {
                isDouble = true
                break
            }
        }
        return isDouble
        //var startToProcess = false
        /*var isDouble = false
        var hasDot = false
        //var nowPosition = textString.startIndex
        var count = 0 //123. のような場合を判断するため
        for everyChar in textString.characters {
            count += 1
            if hasDot {
                if everyChar != "0" {
                    isDouble = true
                    break
                }
            }
            if everyChar == "." {// 123.0000 123.0001   123.のように場合分け
                hasDot = true

            }
            //nowPosition = textString.index(after: nowPosition)
        }
        if !isDouble {//整数の時、小数点以下を削除
            if hasDot {// abc.00000の場合
                while !textString.hasSuffix(".") {
                    if textString.hasSuffix("0") {
                        textString.remove(at: textString.index(before: textString.endIndex))
                    }
                }
                if textString.hasSuffix(".") {
                    textString.remove(at: textString.index(before: textString.endIndex))
                }
            }
            //abcd.000
            //let intValueTemp = Int(textString) ?? 0
            //textString = String(describing: intValueTemp)
            /*var isProcessStart = false
            var nowPosition = textString.startIndex
            var startProcess = 0
            for everyChar in textString.characters {
                if everyChar == "." {
                    isProcessStart = true
                }
                if isProcessStart {
                    textString.remove(at: nowPosition)
                }
                if startProcess < textString.characters.count {
                    nowPosition = textString.index(after: nowPosition)
                }
                startProcess += 1
                
            }*/
        }
        return isDouble*/
    }
    
    private func insertCommaInOutString(_ textString: inout String) -> String {//ローカル　文字列にカンマを入れる ....abcd(|.|efgh...)
        
        //let lengthOfString = textString.characters.count
        if !isDouble(&textString) {
            let lengthOfString = textString.characters.count
            let remainOfString = lengthOfString % 3
            insertCommaIntervalThree(&textString, remainOfString)
            return textString
        }else {
            var intString: String = ""
            var doubleString: String = ""
            let dot: String = "."
            var isAfteDecimalPoint = false
            var doubleStringCount = 0
            for everyChar in textString.characters {
                //------------流れ------------------
                //123123123      .     123
                //   ⬇️         ⬇️     ⬇️
                //intString     dot    doubleString
                //---------------------------------
                if everyChar == "." {
                    isAfteDecimalPoint = true
                    //continue    //continueをなるべく使わないようにする
                    //代わりにそれ以外の場合をelseに
                }else {
                    if isAfteDecimalPoint {
                        doubleStringCount += 1
                        /*if doubleStringCount <= 8{
                            doubleString.append(everyChar)
                        }*/
                        doubleString.append(everyChar)
                    }else {
                        intString.append(everyChar)
                    }
                }
            }
            let lengthOfString = intString.characters.count
            let remainOfString = lengthOfString % 3
            insertCommaIntervalThree(&intString ,remainOfString)
            //万が一ここに123456.00のような整数を混ざった時の処理、
            //isDouble()->Boolを改善したため、不要になった
            /*if Double(doubleString) == 0 {
                textString = intString
            }else {
                textString = intString + dot + doubleString
            }*/
            if doubleString.characters.count != 0 {
                textString = intString + dot + doubleString
            }else{//1213. のような場合
                textString = intString + dot
            }
            /*self.intString = intString
            self.dot = dot
            self.doubleString = doubleString*/
        }
        return textString
    }
    
    @discardableResult
    private func insertCommaIntervalThree(_ textString: inout String, _ offSetBy: Int) -> Bool{//ローカル　カンマを3を間隔に文字列に入れる
        //remain = 0 : 123,456,789
        //remain = 1 : 1,234,567
        //remain = 2 : 12,345,678
        var nowPosion = textString.startIndex
        var count = 0
        let lengthOfString = textString.characters.count
        if lengthOfString < 4 {//カンマがいらない場合　1  12  123
            return false
        }
        if offSetBy > 0 {
            for _ in 0..<offSetBy {
                nowPosion = textString.index(after: nowPosion)
            }
            textString.insert(",", at: nowPosion)
            nowPosion = textString.index(after: nowPosion)
        }
        if lengthOfString - offSetBy < 4 { // カンマが一つだけの場合 1,1  1,12 1,123
            return true
        }
        var progressRateCount = 0
        for _ in 0 ..< lengthOfString + (lengthOfString/3 - 1) - 3{//-offSetBy {// 12,123,123,123,123
            // 123|123|123
            count += 1
            progressRateCount += 1
            //nowPosion = textString.index(after: nowPosion)
            if progressRateCount == 4 {
                textString.insert(",", at: nowPosion)
                count += 1
                //nowPosion = textString.index(after: nowPosion)
                progressRateCount = 0
            }
            if progressRateCount == 4 {
                progressRateCount = 0
            }
            nowPosion = textString.index(after: nowPosion)
            /*if count < lengthOfString-2 {
                nowPosion = textString.index(after: nowPosion)
            }else {
                //return true
            }*/
        }
        return true
        
    }
    
    private func putNumAtLast(nowNumString: String , lastNumEleOfString: String, _ isDouble: Bool) -> String {
        //ローカル　文字列の最後に新しく入力された文字を追加
        if isDouble {
            return nowNumString + lastNumEleOfString
        }else {
            return nowNumString + lastNumEleOfString
        }
    }
    private func functionButtonProcesser(nowNumString: inout String , functionMessage: String) -> String {
        //ローカル　. C PM % 機能を実装
        //var returnString: String = ""
        switch functionMessage {
        case ".":
            //すでにドットがある場合無視
            for char in nowNumString.characters {
                if char == "." {
                    return nowNumString
                }
            }
            //ドットがない場合
            return isMinus ? "-"+nowNumString+".":nowNumString+"."
        case "C":
            return "0"
        case "PM":
            if nowNumString.hasPrefix("-"){
                nowNumString.remove(at: inPutTextString.startIndex)
            }else {
                nowNumString.insert("-", at: inPutTextString.startIndex)
            }
            return nowNumString
            /*case "%":
             break*/
        default:
            break
        }
        return ""
    }
    /*private func operatorFunctionButtonProcesser(nowNumString: String , functionMessage: String) -> String {
     //ローカル　+ - * / = 機能を実装
     return ""
     }*/

    func outWithAppropriateDataType() -> String {//グローバル カンマありの文字列を返す 出力文字
        //1234.01234???
        //textString = getInputAppropriateFormat(commandString: textString)
        if isHasE(textString) { //E eがあるかどうかを調べる
            return textString
        }
        initString(&textString) //文字列最初にドットがあれば削除
        
        return isMinus ? "-"+insertCommaInOutString(&textString) : insertCommaInOutString(&textString)
        
    }
    func outWithAppropriateDataTypeByEqual() -> String {//グローバル カンマありの計算結果文字列を返す 出力文字
        //整数であれば整数として出力
        //浮動小数点数であれば有効数字まで出力
        //演算結果に関する処理
        // 1234.0000の場合整数にする
        //123.10000の場合有効数字だけ残す
        var isTrulyInt = false
        var isBadDouble = false
        var maybeDouble = false
        var outString = outWithAppropriateDataType()
        for char in outString.characters {
            if char == "." {
                maybeDouble = true
                continue
            }
            if maybeDouble {
                if char != "0" {
                    isBadDouble = true
                }
            }
        }
        if !isBadDouble && maybeDouble {
            isTrulyInt = true
        }
        if isTrulyInt {//6.0
            while !textString.hasSuffix("."){
                textString.remove(at: textString.index(before: textString.endIndex))
            }
            textString.remove(at: textString.index(before: textString.endIndex))
        }else if isBadDouble {//6.100
            while textString.hasSuffix("0"){
                textString.remove(at: textString.index(before: textString.endIndex))
            }
        }
        return isMinus ? "-"+textString:textString
        
    }
    func getInitAppropriateStringNoComma() -> String {//グローバル　カンマなしの文字列を返す　出力文字
        if isHasE(textString) {
            return textString
        }
        initApproString = consTextString
        initString(&initApproString)
        return initApproString
    }
    func getInputAppropriateFormat(commandString cS: String) -> String {//グローバル　カンマありの文字列を適当に処理する　入力文字
        var isDouble = false
        var isMinus = false
        inPutTextString = errorMessageProcesser(inPutTextString)
        for _ in 0..<2 {
            if inPutTextString.hasPrefix("-") {//マイナスの場合いったん"-"を削除
                isMinus = true
                inPutTextString.remove(at: inPutTextString.startIndex)
            }
            if inPutTextString.hasPrefix(".") {//最初のドットを削除
                inPutTextString.remove(at: inPutTextString.startIndex)
            }
        }
        var nowPosition = inPutTextString.startIndex
        for everyChar in inPutTextString.characters {//カンマ削除
            if everyChar == "," {
                inPutTextString.remove(at: nowPosition)
                nowPosition = inPutTextString.index(before: nowPosition)
                //123,123 ---- 123 123
            }
            if everyChar == "." {
                // a.0000000のような場合も浮動小数点数とみなす
                //頭じゃないところにドットがある場合、浮動小数点数と見なす
                isDouble = true
            }
            if nowPosition < inPutTextString.endIndex {
                nowPosition = inPutTextString.index(after: nowPosition)
            }
        }
        if inPutTextString.hasPrefix("0") {//頭の０の処理
            // 0+n     0.+n    01+n 三つの場合
            // 0+n の場合　０を削除
            // 0.の場合も何もしなくていい  OK
            // 01+nの場合は0を削除
            if !inPutTextString.hasPrefix("0.") && inPutTextString != "0" {
                //0の場合は含まれない
                //0121212の場合0を削除
                inPutTextString.remove(at: inPutTextString.startIndex)
            }
            if inPutTextString == "0" {
                if Int(cS) != nil/*let stringValue = Int(cS)*/ {
                    //０の時、cSが数字の場合に０を削除
                    inPutTextString.remove(at: inPutTextString.startIndex)
                    
                }
            }
        }
        if inPutTextString.characters.count == 8 {
            //return "123123123123123123.123"
            //return ".520."
        }
        inPutTextString = isMinus ? "-"+inPutTextString : inPutTextString
        switch cS {
        case "0", "1", "2", "3", "4", "5", "6", "7", "8", "9":
            if isHasE(inPutTextString) {
                inPutTextString = ""
            }
            inPutTextString = putNumAtLast(nowNumString: inPutTextString, lastNumEleOfString: cS, isDouble)
        case "%":
            inPutTextString = putNumAtLast(nowNumString: inPutTextString, lastNumEleOfString: "", isDouble)
        case "PM":
            inPutTextString = functionButtonProcesser(nowNumString: &inPutTextString, functionMessage: cS)
        case ".", "C":
            inPutTextString = functionButtonProcesser(nowNumString: &inPutTextString, functionMessage: cS)
        /*case "+", "-", "*", "/", "=":
            inPutTextString = functionButtonProcesser(nowNumString: &inPutTextString, functionMessage: cS)*/
        default:
            inPutTextString = putNumAtLast(nowNumString: inPutTextString, lastNumEleOfString: "", isDouble)
        }
        /*if isDouble {
            if inPutTextString.hasPrefix("0") {//整数の場合、最初の0を削除
                inPutTextString.remove(at: inPutTextString.startIndex)
            }
        }*/
        return inPutTextString
    }
}
