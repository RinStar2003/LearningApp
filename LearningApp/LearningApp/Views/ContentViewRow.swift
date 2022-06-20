//
//  ContentViewRow.swift
//  LearningApp
//
//  Created by мас on 05.01.2022.
//

import SwiftUI

struct ContentViewRow: View {
    
    @EnvironmentObject var model: ContentModel
    var i: Int
    
    
    var body: some View {
        
        let lesson = model.currentModule!.content.lessons[i]
   
        ZStack (alignment: .leading) {
        
        Rectangle().foregroundColor(.white).cornerRadius(10).shadow(radius: 5).frame(height: 66)
        
        
        HStack(spacing: 30) {
            
            Text("\(i + 1)")
                .bold()
                .padding(.leading, 15.0)
                
            
            VStack(alignment: .leading) {
                Text(lesson.title)
                    .bold()
                Text("Video - \(lesson.duration)")
                    
                }
            }
        }
        .padding(.bottom, 10.0)
        
        
    }
}

