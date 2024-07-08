//
//  ContentView.swift
//  MultiplicationTableGameNew
//
//  Created by Антон Баскаков on 22.05.2024.
//

import SwiftUI


struct ContentView: View {
    
    @State private var firstNumber = 2
    @State private var secondNumber = 2
    @State private var answer = 0
    @State private var numberOfQuestions = 5
    @State private var questionNumber = 0
    @State private var questions = ["N/A"]
    @State private var correctAnswers = [Int]()
    @State private var score = 0
    
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showAlert = false
    
    var body: some View {
            VStack {
                Text("Счет: \(score) \\ \(numberOfQuestions)")
                Text(questions[questionNumber])
                TextField("Ответ", value: $answer, format: .number)
                    .keyboardType(.numberPad)
                    .multilineTextAlignment(.center)
                    .onSubmit() {
                        checkResult()
                    }
                    
            }
            .onAppear(perform: generateQuestions)
        .alert(alertTitle, isPresented: $showAlert) {
            
        } message: {
            Text(alertMessage)
        }


    }
    
    func generateQuestions() {
        questions = []
        while correctAnswers.count != numberOfQuestions {
            secondNumber = Int.random(in: 2...12)
            if !correctAnswers.contains(secondNumber) {
                correctAnswers.append(firstNumber * secondNumber)
                questions.append("\(firstNumber) x \(secondNumber)?")
            }
        }
        print(questions)
        print(correctAnswers)
    }
    func checkResult() {
        if questionNumber != 4  {
            if score != numberOfQuestions {
                if answer == correctAnswers[questionNumber] {
                    score += 1
                    questionNumber += 1
                    alertTitle = "Верно!"
                    alertMessage = "Ваш счет: \(score)"
                    showAlert = true
                } else {
                    if score != 0 {
                        score -= 1
                    }
                    questionNumber += 1
                    alertTitle = "Не верно!"
                    alertMessage = "Ваш счет: \(score)"
                    showAlert = true
                }
                
            }
        } else {
            alertTitle = "Игра завершена!"
            alertMessage = "Ваш счет: \(score)"
            showAlert = true
            resetGame()
        }
    }
    func  resetGame() {
        score = 0
        questionNumber = 0
        generateQuestions()
    }
    
}



#Preview {
    ContentView()
}

