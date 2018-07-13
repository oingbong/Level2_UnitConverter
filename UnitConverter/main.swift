//
//  main.swift
//  UnitConverter
//
//  Created by oingbong on 2018. 7. 9..
//  Copyright © 2018년 oingbong. All rights reserved.
//

/*
 완료된 작업 내용
 1. 함수 로직 수정 : 줄줄이 이어지는 -> 하나의 작업 후 리턴
 2. 단위별 Default 값 설정
 3. 입력 반복
 4. 종료키
 5. enum 사용
 6. CharacterSet 응용하여 함수 만듬
 7. 문자열 나누는 함수 & 단위 구하는 함수 통합 -> divideUnit
 9. compareUnit 함수 더 줄이는 방법?
*/

import Foundation

// 인치 길이 변환과 예외 처리

typealias UnitTuple = (first: String, last: String, value: Double)

// 값 받기
func main() -> Bool {
    
    print("값을 입력하세요 ex : 18cm inch // 종료는 q 혹은 quit")
    let inputValue = readLine()
    
    // 종료하기
    if inputValue == "q" || inputValue == "quit" {
        return false
    }
    
    if let input = inputValue {
        let extract: UnitTuple = divideUnit(input: input)
        compareUnit(UnitTuple: extract)
    }

    return true
}

enum LengthUnit:Double{
    case Cm = 1
    case M = 100
    case Inch = 2.54
    case Yard = 91.44
}

enum WeightUnit:Double{
    case G = 1
    case Kg = 1000
    case Oz = 28.34952
    case Lb = 453.59237
}

func divideUnit(input:String) -> UnitTuple {
    let separatorStr = input.split(separator: " ")
    let firstStr:String = String(separatorStr.first!)
    let lastStr:String = String(separatorStr.last!)
    
    let characterSet:String = "abcdefghijklmnopqrstuvwxyz"
    
    var valueString:String = ""
    var firstUnit:String = ""
    for char in firstStr {
        if !characterSet.contains(char){
            valueString.append(char)
        }else{
            firstUnit.append(char)
        }
    }
    
    // TypeCasting : String -> Double
    let value:Double = Double(valueString)!
    
    // 두 번째 Unit 구하기 : 두번째 값이 입력받지 않은 경우 firstUnit으로 세팅합니다.
    let lastUnit:String = firstStr == lastStr ? firstUnit : lastStr
    
    let result:UnitTuple = (firstUnit, lastUnit, value)
    return result
}

func calculateUnit(unit: String, value: Double, isDefault: Bool) -> Double {
    let number:Double = settingValueOfDivide(str: unit)
    return calculation(value: value, number: number, isTrue: isDefault)
}

func settingValueOfDivide(str:String) -> Double{
    var result:Double = 0
    switch str {
    case "g": result = WeightUnit.G.rawValue
    case "kg": result = WeightUnit.Kg.rawValue
    case "oz": result = WeightUnit.Oz.rawValue
    case "lb": result = WeightUnit.Lb.rawValue
        
    case "cm": result = LengthUnit.Cm.rawValue
    case "m": result = LengthUnit.M.rawValue
    case "inch": result = LengthUnit.Inch.rawValue
    case "yard": result = LengthUnit.Yard.rawValue
        
    default: result = 1
    }
        
    return result
}

func calculation(value:Double, number:Double, isTrue:Bool) -> Double {
    if isTrue {
        return value * number
    }else {
        return value / number
    }
}

// Unit 비교
func compareUnit(UnitTuple:UnitTuple){
    let firstUnit = UnitTuple.first
    var lastUnit = UnitTuple.last
    let value = UnitTuple.value
    
    var result:Double = 0
    
    // 1. Default Calculate : length -> cm / weight -> g
    result = calculateUnit(unit: firstUnit, value: value, isDefault: true)
    
    let length:String = "mcminchyard"
    let weight:String = "gkgozlb"
    
    // 2. want to change : -> ?
    if firstUnit == lastUnit {
        if length.contains(firstUnit) && firstUnit == "m" {
            lastUnit = "cm"
        }else if length.contains(firstUnit) && firstUnit != "m" {
            result = calculateUnit(unit: "m", value: result, isDefault: false)
            lastUnit = "m"
        }else if weight.contains(firstUnit) && firstUnit == "kg" {
            lastUnit = "g"
        }else if weight.contains(firstUnit) && firstUnit != "kg" {
            result = calculateUnit(unit: "kg", value: result, isDefault: false)
            lastUnit = "kg"
        }
    } else {
        result = calculateUnit(unit: lastUnit, value: result, isDefault: false)
    }
    
    print("\(result)\(lastUnit)")
}

// 실행
var play:Bool = true
while(play){
    play = main()
}
