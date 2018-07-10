//
//  main.swift
//  UnitConverter
//
//  Created by oingbong on 2018. 7. 9..
//  Copyright © 2018년 oingbong. All rights reserved.
//

import Foundation

// 길이 변환 및 출력

// cm -> m
var cm = "120cm"
func convertCmToM(cm:String){
    let indexEndOfText = cm.index(cm.endIndex, offsetBy: -2)
    let num = cm[..<indexEndOfText]
    let m:Double = Double(num)! / 100
    print("Double : \(m)m")
}
convertCmToM(cm: cm)

// m -> cm
var m = "1.86m"
func convertMToCm(m:String){
    let indexEndOfText = m.index(m.endIndex, offsetBy: -1)
    let num = m[..<indexEndOfText]
    let cmDouble:Double = Double(num)!
    let cm:Int = Int(cmDouble * 100)
    print("\(cm)cm")
}
convertMToCm(m: m)


// 길이 단위 변환 함수

var input = "1.8m"
func convertUnit(number:String){
    if number.contains("cm"){
        let indexEndOfText = number.index(number.endIndex, offsetBy: -2)
        let num = number[..<indexEndOfText]
        let m:Double = Double(num)! / 100
        print("Double : \(m)m")
    }else if(number.contains("m")){
        let indexEndOfText = number.index(number.endIndex, offsetBy: -1)
        let num = number[..<indexEndOfText]
        let cmDouble:Double = Double(num)!
        let cm:Int = Int(cmDouble * 100)
        print("\(cm)cm")
    }
}

convertUnit(number: input)


// 길이 값 입력 및 조건문

func compareUnit(){
    let inputValue = readLine()
    if let value = inputValue {
        convertUnit(number: value)
    }
}
compareUnit()
