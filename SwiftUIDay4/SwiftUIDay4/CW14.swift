//
//  CW14.swift
//  SwiftUIDay4
//
//  Created by Haider Alboloushi on 8/26/20.
//  Copyright © 2020 Haider. All rights reserved.
//

import SwiftUI

struct CW14: View {
    @State var counter = 0
    var body: some View {
        ZStack{
            BACKGROUND()
            
            VStack{
                Text("ستحتاج إلى" + " \(counter * 20) " + "عدداً من الصفحات تقرأها يومياً").modifier(ThekrModifier())
                
                Stepper("كم ختمة تريد أن تختم هذا الشهر؟", value: $counter, in: 0...100)
                    .foregroundColor(.white)
                    .padding()
                
                HStack{
                    Text(plural5atma(counter).0)
                        .foregroundColor(.white)
                        .padding()
                        .font(.largeTitle)
                    Text(plural5atma(counter).1)
                        .foregroundColor(.white)
                        .padding()
                        .font(.largeTitle)
                }
            }
            
        }
    }
    
    func plural5atma(_ counter: Int) -> (String, String) {
        switch counter {
        case 1: return ("ختمة واحدة", "")
        case 2: return ("ختمتان", "")
        case 3...10: return ("ختمات", "\(counter)")
        default: return ("ختمة", "\(counter)")
        }
    }
    
}

struct CW14_Previews: PreviewProvider {
    static var previews: some View {
        CW14()
    }
}

struct BACKGROUND: View {
    var body: some View {
        ZStack{
            Image("BACKGROUND")
                .resizable()
            VStack{
                Image("Header")
                    .resizable()
                    .scaledToFit()
                Spacer()
                Image("Mosque")
                    .resizable()
                    .scaledToFit()
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct ThekrModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
        .font(.custom("Cairo-Regular", size: 25))
        .foregroundColor(.white)
        .multilineTextAlignment(.center)
        .padding()
        .animation(.interactiveSpring())
    }
}
