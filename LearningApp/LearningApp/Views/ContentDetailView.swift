//
//  ContentDetailView.swift
//  LearningApp
//
//  Created by мас on 08.01.2022.
//

import SwiftUI
import AVKit


struct ContentDetailView: View {

    @EnvironmentObject var model: ContentModel
    
    var body: some View {
        
        
        let lesson = model.currentLesson
        let text = lesson?.title ?? ""
        let url = URL(string: Constants.videoHostUrl + (lesson?.video ?? ""))
        
        
        VStack {
        
        // Video
        if url != nil {
            VideoPlayer(player: AVPlayer(url: url!))
                .cornerRadius(10)
        }
        
        // Description
        CodeTextView()
        // Next lesson button
            if model.hasItNextLesson() {
            Button(action: {
                model.nextLesson()
            }, label: {
                ZStack {
                    
                    RectangleCard(color: .green).frame(height: 48)
                    
                    Text("Next lesson: \(model.currentModule!.content.lessons[model.currentLessonIndex + 1].title)")
                        .foregroundColor(.white)
                        .bold()
                }
            })
                    .buttonStyle(PlainButtonStyle())
            }
            else {
                Button(action: {
                    
                    model.currentContentSelected = nil
                    
                }, label: {
                    ZStack {
                        
                        RectangleCard(color: .green).frame(height: 48)
                        
                        Text("Complete and return")
                            .foregroundColor(.white)
                            .bold()
                    }
                })
                        .buttonStyle(PlainButtonStyle())
            }
        }.padding()
            .navigationBarTitle(text)
    }
}

struct ContentDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ContentDetailView()
    }
}
