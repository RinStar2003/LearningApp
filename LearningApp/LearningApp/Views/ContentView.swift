//
//  ContentView.swift
//  LearningApp
//
//  Created by мас on 05.01.2022.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var model: ContentModel
    
    var body: some View {
        
        
        ScrollView {
            
            LazyVStack {
                
                if model.currentModule != nil {
                    ForEach(0..<model.currentModule!.content.lessons.count) { i in
                    
                        
                        NavigationLink(
                            destination: {
                                ContentDetailView()
                                    .onAppear(perform: {
                                        model.beginLesson(i)
                                    })
                            },
                            label: {
                                ContentViewRow(i: i)
                            })
                            .buttonStyle(PlainButtonStyle())
                    }
                }
            }
            .padding(.all, 10.0)
            .navigationBarTitle("Learn \(model.currentModule?.category ?? " ")")
            
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
