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

 피드백
 WantToChange 구조체는 살짝 아쉽습니다.
 데이터를 위주로 한 묶음인지, 핵심 로직을 구성하기 위해서 한 묶음인지 애매합니다.
 특히 남아있는 다른 함수들까지 포괄하도록 만들지 못한것도 아쉽습니다.
*/

import Foundation

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

enum LengthUnit:String {
    case cm
    case m
    case inch
    case yard
    
    static let allCase = [cm,m,inch,yard]
    static let `default` = "cm"
    
    var str: String {
        switch self {
        case .cm    : return "cm"
        case .m     : return "m"
        case .inch  : return "inch"
        case .yard  : return "yard"
        }
    }
    
    var value: Double {
        switch self {
        case .cm    : return 1
        case .m     : return 100
        case .inch  : return 2.54
        case .yard  : return 91.44
        }
    }
    
}

enum WeightUnit:String{
    case g
    case kg
    case oz
    case lb
    
    static let allCase = [g,kg,oz,lb]
    static let `default` = "g"
    
    var str: String {
        switch self {
        case .g : return "g"
        case .kg: return "kg"
        case .oz: return "oz"
        case .lb: return "lb"
        }
    }
    
    var value: Double {
        switch self {
        case .g : return 1
        case .kg: return 1000
        case .oz: return 28.34952
        case .lb: return 453.59237
        }
    }
    
}

func divideUnit(input:String) -> UnitTuple {
    let separatorStr = input.split(separator: " ")
    let firstStr:String = String(separatorStr.first!)
    let lastStr:String = String(separatorStr.last!)
    
    let characterSet:String = "abcdefghijklmnopqrstuvwxyz"
    
    // 첫번째 글자에서 숫자와 단위 구하기
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

func calculateUnit(unit: String, value: Double, isFirst: Bool) -> Double {
    let numberForDivide:Double = settingValueOfDivide(forUnit: unit)
    return calculation(value: value, numberForDivide: numberForDivide, isFirst: isFirst)
}

func settingValueOfDivide(forUnit:String) -> Double{
    var result:Double = 0
    switch forUnit {
    case "g"    : result = WeightUnit.g.value
    case "kg"   : result = WeightUnit.kg.value
    case "oz"   : result = WeightUnit.oz.value
    case "lb"   : result = WeightUnit.lb.value
        
    case "cm"   : result = LengthUnit.cm.value
    case "m"    : result = LengthUnit.m.value
    case "inch" : result = LengthUnit.inch.value
    case "yard" : result = LengthUnit.yard.value
        
    default: result = 1
    }
        
    return result
}

func calculation(value:Double, numberForDivide:Double, isFirst:Bool) -> Double {
    if isFirst {
        return value * numberForDivide
    }else {
        return value / numberForDivide
    }
}

struct WantToChange {
    var beforeUnit:String
    var afterUnit:String
    var value:Double
    
    init(beforeUnit:String, afterUnit:String, value:Double) {
        self.beforeUnit = beforeUnit
        self.afterUnit = afterUnit
        self.value = value
    }
    
    func firstValue() -> Double {
        return calculateUnit(unit: self.beforeUnit, value: self.value, isFirst: true)
    }
    
    func secondValue(defaultValue:Double) {
        
        if beforeUnit == afterUnit {
            // 길이 전부 출력
            if LengthUnit.init(rawValue: self.beforeUnit) != nil {
                for unit in LengthUnit.allCase {
                    let result = calculateUnit(unit: unit.str, value: defaultValue, isFirst: false)
                    print("\(result)\(unit.str)")
                }
            }
            // 무게 전부 출력
            if WeightUnit.init(rawValue: self.beforeUnit) != nil {
                for unit in WeightUnit.allCase {
                    let result = calculateUnit(unit: unit.str, value: defaultValue, isFirst: false)
                    print("\(result)\(unit.str)")
                }
            }
            
        }else {
            // 쉼표 기준으로 자르기
            if afterUnit.contains(",") {
                let units = afterUnit.split(separator: ",")
                for unit in units {
                    let result = calculateUnit(unit: String(unit), value: defaultValue, isFirst: false)
                    print("\(result)\(unit)")
                }
            }else {
                let result = calculateUnit(unit: self.afterUnit, value: defaultValue, isFirst: false)
                print("\(result)\(self.afterUnit)")
            }
        }
    }
}

// Unit 비교
func compareUnit(UnitTuple:UnitTuple){
    let firstUnit = UnitTuple.first
    let lastUnit = UnitTuple.last
    let value = UnitTuple.value
    
    let wantToChange = WantToChange.init(beforeUnit: firstUnit, afterUnit: lastUnit, value: value)
    
    // 1. Default Calculate : length -> cm / weight -> g
    let defaultValue = wantToChange.firstValue()
    // 2. want to change : -> ?
    wantToChange.secondValue(defaultValue: defaultValue)
}

// 실행
var play:Bool = true
while(play){
    play = main()
}
