//
//  ContentView.swift
//  X-O
//
//  Created by Haider Alboloushi on 8/27/20.
//  Copyright © 2020 Haider. All rights reserved.
//

import SwiftUI

enum Choice {
    case X, O, none
    var title: String{
        switch self {
        case .X: return "X"
        case .O: return "O"
        case .none: return ""
        }
    }
    
    mutating func toggle() {
        switch self{
        case .X: self = .O
        case .O: self = .X
        case .none: self = .none
        }
    }
}

struct Player {
    var enabled: Bool
    var title: Choice
}

class Env: ObservableObject{
    @Published var currentPlayer: Choice = .X
    @Published var fields: [[Player]] = Array<Array<Player>>(repeating: Array<Player>(repeating: Player(enabled: true, title: .none), count: 3), count: 3)
    @Published var winner: Choice = .none
    @Published var thereIsWinner: Bool = false
    
    private func checkWinner(choice: Choice) -> Choice {
        let r1 = fields[0][0].title == choice && fields[0][1].title == choice && fields[0][2].title == choice
        let r2 = fields[1][0].title == choice && fields[1][1].title == choice && fields[1][2].title == choice
        let r3 = fields[2][0].title == choice && fields[2][1].title == choice && fields[2][2].title == choice
        
        let c1 = fields[0][0].title == choice && fields[1][0].title == choice && fields[2][0].title == choice
        let c2 = fields[0][1].title == choice && fields[1][1].title == choice && fields[2][1].title == choice
        let c3 = fields[0][2].title == choice && fields[1][2].title == choice && fields[2][2].title == choice
        
        let d1 = fields[0][0].title == choice && fields[1][1].title == choice && fields[2][2].title == choice
        let d2 = fields[0][2].title == choice && fields[1][1].title == choice && fields[2][0].title == choice
        
        if r1 || r2 || r3 || c1 || c2 || c3 || d1 || d2 {
            return choice
        }
        else {
            return .none
        }
    }
    
    func checkWinner() {
        winner = checkWinner(choice: currentPlayer)
        
        if winner != .none {
            thereIsWinner = true
        }
    }
    
}

struct ContentView: View {
    @EnvironmentObject var env: Env
    var body: some View {
        ZStack {
            BG()
            VStack {
                Text("\(self.env.currentPlayer.title) Turn")
                    .font(.largeTitle)
                    .bold()
                    .padding()
                    .foregroundColor(Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)))
                XOGrid()
            }.alert(isPresented: $env.thereIsWinner) { () -> Alert in
                Alert(title: Text("\(self.env.winner.title) WOOOOON!!!!🥳"), message: Text("Reset to play again😼"), dismissButton: .default(Text("Restart"), action: {
                    self.env.fields = Array<Array<Player>>(repeating: Array<Player>(repeating: Player(enabled: true, title: .none), count: 3), count: 3)
                    self.env.winner = .none
                    self.env.currentPlayer = .X
                    self.env.thereIsWinner = false
                }))
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(Env())
    }
}

struct XOGrid: View {
    @EnvironmentObject var env: Env
    var body: some View {
        VStack(spacing: 10){
            ForEach(0..<3, id: \.self) { r in
                HStack {
                    ForEach(0..<3, id: \.self) { c in
                        XOButton(c: c, r: r)
                    }
                }
            }
        }
    }
}

struct XOButton: View {
    @EnvironmentObject var env: Env
    @State var c: Int
    @State var r: Int
    var body: some View {
        Text(env.fields[c][r].title.title)
            .bold()
            .foregroundColor(.white)
            .font(.largeTitle)
            .frame(width: 80, height: 80)
            .background(Color(#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 0.5)))
            .cornerRadius(10)
            .onTapGesture {
                if self.env.fields[self.c][self.r].enabled {
                    self.env.fields[self.c][self.r].title = self.env.currentPlayer
                    self.env.checkWinner()
                    self.env.currentPlayer.toggle()
                    self.env.fields[self.c][self.r].enabled = false
                }
        }
    }
}

struct BG: View {
    var body: some View {
        ZStack{
            Image("BACKGROUND")
                .resizable()
                .opacity(0.75)
        }
        .edgesIgnoringSafeArea(.all)
    }
}
