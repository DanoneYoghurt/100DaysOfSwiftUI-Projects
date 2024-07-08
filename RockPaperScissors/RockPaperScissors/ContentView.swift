//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Антон Баскаков on 26.04.2024.
//

import SwiftUI

struct ContentView: View {
    
    @State private var moves = ["Камень", "Ножницы", "Бумага"]
    @State private var shouldWin = Bool.random()
    @State private var move = Int.random(in: 0...2)
    @State private var score = 0
    @State private var winAlert = ""
    @State private var moveCounter = 0
    @State private var showScore = false
    @State private var showFinalScore = false
    @State private var showHelp = false
    
    var body: some View {
        ZStack {
            Color.indigo
                .ignoresSafeArea()
            VStack {
                Spacer()
                Text("""
                Счет: \(score)
                Ход оппонента: \(moves[move])
                Условие: \(shouldWin ? "Победа" : "Поражение")
                """)
                .multilineTextAlignment(.center)
                .shadow(radius: 10)
                .padding()
                .font(.title2)
                .foregroundStyle(.black)
                .background(.white)
                .clipShape(RoundedRectangle(cornerRadius: 40.0))
                .shadow(radius: 10)
                .padding()
                
                Button(action: {
                    buttonAction(cpuMove: "Ножницы")
                }, label: {
                    Text("🗿")
                })
                .font(.system(size: 100))
                .shadow(radius: 10)
                .frame(width: 200, height: 130)
                .background(.white)
                .shadow(radius: 10)
                .clipShape(RoundedRectangle(cornerRadius: 40.0))
                .padding()
                Button(action: {
                    buttonAction(cpuMove: "Бумага")
                }, label: {
                    Text("✂️")
                })
                .font(.system(size: 100))
                .shadow(radius: 10)
                .frame(width: 200, height: 130)
                .background(.white)
                .shadow(radius: 10)
                .clipShape(RoundedRectangle(cornerRadius: 40.0))
                .padding()
                Button(action: {
                    buttonAction(cpuMove: "Камень")
                }, label: {
                    Text("📄")
                })
                .font(.system(size: 100))
                .shadow(radius: 10)
                .frame(width: 200, height: 130)
                .background(.white)
                .shadow(radius: 10)
                .clipShape(RoundedRectangle(cornerRadius: 40.0))
                .padding()
                Spacer()
                Button(action: {
                    showHelp = true
                }, label: {
                    Text("Как играть?")
                })
                .shadow(radius: 10)
                .padding()
                .font(.title2)
                .foregroundStyle(.black)
                .background(.white)
                .clipShape(RoundedRectangle(cornerRadius: 40.0))
                .shadow(radius: 10)
                .padding()
                Spacer()
            }
            .alert("\(winAlert)", isPresented: $showScore) {
                Button("Продолжить", action: askQuestion)
            } message: {
                Text("Счет: \(score)")
            }
            .alert("Игра завершена", isPresented: $showFinalScore) {
                Button("Начать заново", action: resetGame)
            } message: {
                Text("Финальный cчет: \(score)")
            }
            .alert("Как играть в игру?", isPresented: $showHelp) { }
        message: {
            Text("Данная игра состоит из 10 ходов. Каждый ход игрок противостоит оппоненту в игре \"Камень, ножницы, бумага\", однако есть условие: игроку нужно либо выйграть, либо проиграть оппоненту")
        }
            
        }
    }
    func buttonAction(cpuMove: String) {
        if moveCounter == 10 {
            showFinalScore = true
        }
        if shouldWin && moves[move] == cpuMove {
            winAlert = "Верно"
            score += 1
        } else if shouldWin == false && moves[move] != cpuMove {
            winAlert = "Верно"
            score += 1
        } else {
            if score != 0 {
                score -= 1
            }
            winAlert = "Не верно"
        }
        moveCounter += 1
        showScore = true
    }
    func askQuestion() {
        shouldWin.toggle()
        moves.shuffle()
        
    }
    func resetGame() {
        showScore = false
        score = 0
        moveCounter = 0
        shouldWin.toggle()
        moves.shuffle()
    }
}

#Preview {
    ContentView()
}
