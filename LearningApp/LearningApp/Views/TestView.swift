//
//  TestView.swift
//  LearningApp
//
//  Created by мас on 14.01.2022.
//

import SwiftUI

struct TestView: View {
   
    @EnvironmentObject var model: ContentModel
    @State var selectedAnswerIndex: Int?
    @State var submitted = false
    
    @State var numCorrect = 0
    
    var body: some View {
   
        
    if model.currentQuestion != nil {
        
        VStack(alignment: .leading) {
            
            // Question Number
            Text("Question \(model.currentQuestionIndex + 1) of \(model.currentModule?.test.questions.count ?? 0)")
                .padding(.leading, 20)
            
            // Question
            
            CodeTextView()
                .padding(/*@START_MENU_TOKEN@*/.horizontal, 20.0/*@END_MENU_TOKEN@*/)
            
            
            // Answers
            
        ScrollView {
            
            VStack {
                ForEach(0..<model.currentQuestion!.answers.count, id: \.self) { index in
                    
                    Button {
                        // Track the selected index
                        selectedAnswerIndex = index
                    } label: {
                        
                        ZStack {
                            // УПРОСТИТЬ
                        if submitted == false {
                        RectangleCard(color: index == selectedAnswerIndex ? .gray : .white)
                            .frame(height: 48)
                            }
                            else {
                                
                                if index == selectedAnswerIndex &&
                                    index == model.currentQuestion!.correctIndex {
                                    RectangleCard(color: Color.green)
                                        .frame(height: 48)
                                }
                                else if index == selectedAnswerIndex &&
                                        index != model.currentQuestion!.correctIndex {
                                    RectangleCard(color: Color.red)
                                        .frame(height: 48)
                                }
                                else if index == model.currentQuestion!.correctIndex {
                                    
                                    RectangleCard(color: Color.green)
                                        .frame(height: 48)
                                    
                                } else {
                                    RectangleCard(color: .white)
                                        .frame(height: 48)
                                }
                            }
                            
                            Text(model.currentQuestion!.answers[index])
                        }
                        
                        
                    }.disabled(submitted)

                
                }
                
            }
            .accentColor(.black)
            .padding()
}
            // Button
            Button {
                
                
                // Check if answer has been submitted
                
                if submitted == true {
                    
                    model.nextQuestion()
                    
                    // Reset properties
                    submitted = false
                    selectedAnswerIndex = nil
                }
                else {
                    
                    // Submit the answer
                    submitted = true
                    
                    // Check the answer and increment the counter if correct
                    if selectedAnswerIndex == model.currentQuestion!.correctIndex {
                        numCorrect += 1
                    }
                }
            } label: {
                
                ZStack {
                    RectangleCard(color: .green).frame(height: 48)
                    Text(buttonText)
                        .bold()
                        .foregroundColor(Color.white)
    

                }
                .padding()
            }
            .disabled(selectedAnswerIndex == nil    )
            .buttonStyle(PlainButtonStyle())

        }
        .navigationBarTitle("\(model.currentModule?.category ?? "01") Test")
        
}
        
        else {

            TestResultView(numCorrect: numCorrect)
            
        }
        
    }
    
    
    var buttonText: String {
        
        // Check if answer has been submited
        if submitted == true {
            if model.currentQuestionIndex + 1 == model.currentModule!.test.questions.count {
                
                // This is the last question
                
                return "Finish"
                
            }
            return "Next"
        }
        else {
            return "Submit"
        }
        
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
