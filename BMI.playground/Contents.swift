import UIKit

let weight = 50.0
let height = 1.71

let bmi = weight / (height*height)

func calculateBMI(weight: Double, height: Double) -> Double {
    return weight / (height*height)
}

let myBmi = calculateBMI(weight: 59.0, height: 1.71)

func bmiStatus(bmi: Double) -> String {
    if bmi < 20 {
        return "ضعيف"
    }
    else if bmi < 25 {
        return "جيد"
    }
    else {
        return "سمين"
    }
}

bmiStatus(bmi: myBmi)

func bmiStatus2(bmi: Double) -> String {
    switch bmi{
    case ..<20:     return "ضعيف"
    case 20..<25:   return "جيد"
    case 25...:     return "سمين"
    default:        return "خطأ"
    }
}

bmiStatus2(bmi: myBmi)
