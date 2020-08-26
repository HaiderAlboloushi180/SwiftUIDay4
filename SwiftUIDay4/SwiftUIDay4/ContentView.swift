//
//  ContentView.swift
//  SwiftUIDay4
//
//  Created by Haider Alboloushi on 8/26/20.
//  Copyright © 2020 Haider. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State var weight: String = ""
    @State var height: String = ""
    @State var bmi: String = "0.0"
    @State var bmiStatus: String = "-"
    var body: some View {
        ZStack{
            BG()
            VStack{
                Text("Welcome to BMI Calculator")
                    .font(.title)
                    .bold()
                TextField("height in (m)", text: $height)
                TextField("weight in (kg)", text: $weight)
                
                Button(action: {
                    self.calculateBmiAndUpdateView()
                }) {
                    Text("Calculate")
                        .foregroundColor(.white)
                        .frame(width: 250)
                        .padding(.vertical, 10)
                        .background(Color.blue)
                        .clipShape(Capsule())
                }
                
                VStack{
                    Text("BMI")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    Text(bmi)
                        .font(.system(size: 70))
                        .fontWeight(.bold)
                    Text("Status")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    Text(bmiStatus)
                        .font(.system(size: 60))
                        .fontWeight(.heavy)
                        .padding()
                }
            }
            .padding(.all)
            

            
        }
    }
    
    func calculateBmiAndUpdateView() {
        let weight = Double(self.weight)!
        let height = Double(self.height)!
        let bmi = calculateBMI(weight: weight, height: height)
        let bmiStatus = self.bmiStatus(bmi: bmi)
        self.bmi = String(format: "%.1f", bmi)
        self.bmiStatus = bmiStatus
    }
    
    func calculateBMI(weight: Double, height: Double) -> Double {
        return weight / (height*height)
    }
    
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
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct BG: View {
    var body: some View {
        ZStack {
            Image("BG")
                .resizable()
                .edgesIgnoringSafeArea(.all)
                .opacity(0.5)
        }
    }
}
