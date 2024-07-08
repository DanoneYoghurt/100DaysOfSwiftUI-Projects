//
//  ContentView.swift
//  MultiplicationTableGame
//
//  Created by Антон Баскаков on 12.05.2024.
//

import SwiftUI

struct ContentView: View {
    
    let numberOfQuestions = [5, 10, 20]
    
    @State private var selectedNumberOfQuestions = 5
    @State private var answer = 0
    @State private var firstNumber = 2
    @State private var secondNumber = Int.random(in: 2...12)
    @State private var questionNumber = 0
    @State private var showAlert = false
    
    @State private var question = [String]()
    @State private var playerAnswer = [Int]()
    @State private var secondNumbers = [Int]()
    
    var body: some View {
        
        NavigationStack {
            ZStack {
                Color.yellow
                    .ignoresSafeArea()
                VStack {
                    Spacer()
                    Text("Умножение просто!")
                        .font(.largeTitle)
                        .foregroundStyle(.white)
                    HStack {
                        Spacer()
                        Image("parrot")
                        Spacer()
                        Image("penguin")
                        Spacer()
                    }
                    Spacer()
                    NavigationLink("Начать игру") {
                        ZStack {
                            Color.yellow.ignoresSafeArea()
                            VStack {
                                Spacer()
                                HStack {
                                    Image("bear")
                                    Image("owl")
                                }
                                HStack {
                                    Image("bear")
                                    Image("owl")
                                }
                                HStack {
                                    Image("bear")
                                    Image("owl")
                                }
                                HStack {
                                    Image("pig")
                                    Image("rabbit")
                                }
                                Spacer()
                                
                            }
                            Rectangle()
                                .foregroundStyle(.ultraThinMaterial)
                                .frame(maxWidth: .infinity,maxHeight: .infinity)
                                .ignoresSafeArea()
                            VStack {
                                
                                Text("Сколько будет \(firstNumber) x \(secondNumber)?")
                                    .foregroundStyle(.primary)
                                    .font(.title)
                                TextField("Введите ответ", value: $answer, format: .number)
                                    .frame(width: 100, height: 50)
                                    .textFieldStyle(.roundedBorder)
                                    .multilineTextAlignment(.center)
                                    .foregroundStyle(.primary)
                                    .font(.title)
                                    .keyboardType(.numberPad)
                                Button("Ввести число", action: {
                                    if questionNumber != selectedNumberOfQuestions {
                                        question.append("\(firstNumber) x \(secondNumber) = \(firstNumber * secondNumber), ваш ответ: \(answer)")
                                        secondNumber = Int.random(in: 2...12)
                                        questionNumber += 1
                                        
                                    } else {
                                        questionNumber = 0
                                        showAlert = true
                                    }
                                })
                                .frame(width: 100, height: 50)
                                .background(.white)
                                .clipShape(.rect(cornerRadius: 20))
                                .foregroundStyle(.black)
                        
                                
//                                    .onSubmit {
//                                        if questionNumber != selectedNumberOfQuestions {
//                                            if answer == firstNumber * secondNumber {
//                                                playerAnsweredCorrectly.append(true)
//                                            } else {
//                                                playerAnsweredCorrectly.append(false)
//                                            }
//                                            question.append("\(firstNumber) x \(secondNumber) = \(firstNumber * secondNumber), ваш ответ: \(answer)")
//                                            secondNumber = Int.random(in: 2...12)
//                                            questionNumber += 1
//                                            
//                                        } else {
//                                            questionNumber = 0
//                                            showAlert = true
//                                        }
//                                    }
                            }
                        }
                    }
                    .frame(width: 175, height: 100)
                    .background(.white)
                    .clipShape(.rect(cornerRadius: 20))
                    .foregroundStyle(.black)
                    .font(.system(size: 25))
                    .padding(.bottom)
                    .alert("Игра завершена", isPresented: $showAlert) {
                        Button("Заново") {
                            secondNumber = Int.random(in: 2...12)
                            playerAnswer = [Int]()
                            question = [String]()
                            questionNumber = 0
                        }
                    } message: {
                        Text("\(question.joined(separator: "\n"))")
                    }
                    NavigationLink("Настройки") {
                        NavigationStack {
                            Form {
                                Section("Таблица умножения для") {
                                    Stepper(String(firstNumber), value: $firstNumber, in: 2...12)
                                }
                                
                                Picker("Количество вопросов", selection: $selectedNumberOfQuestions) {
                                    ForEach(numberOfQuestions, id: \.self) {
                                        Text($0, format: .number)
                                    }
                                }
                                .pickerStyle(.inline)
                            }
                        }
                    }
                    .frame(width: 175, height: 100)
                    .background(.white)
                    .clipShape(.rect(cornerRadius: 20))
                    .foregroundStyle(.black)
                    .font(.system(size: 25))
                    Spacer()
                    HStack {
                        Spacer()
                        Image("hippo")
                        Spacer()
                        Image("frog")
                        Spacer()
                    }
                    Spacer()
                }
            }
        }
    }
}



#Preview {
    ContentView()
}
