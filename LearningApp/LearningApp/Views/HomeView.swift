//
//  ContentView.swift
//  LearningApp
//
//  Created by мас on 01.01.2022.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var model: ContentModel
    
    var body: some View {
                
       
    NavigationView {
    
        VStack(alignment: .leading) {
            Text("What do you want to do today?").padding(.leading, 20.0)
        
            ScrollView {
        
                LazyVStack {
                
                ForEach(model.modules) { m in
                
                VStack(spacing: 20) {
            
                    // Learning Card
                    
                        NavigationLink(destination:
                                        ContentView()
                                        .onAppear(perform: {
                            model.beginModule(m.id)
                        } ),
                                       tag: m.id,
                                       selection: $model.currentContentSelected,
                                       label: {
                        HomeViewRow(image: m.content.image, title: "Learn \(m.category)", description: m.content.description, count: "\(m.content.lessons.count)", time: m.content.time)
                    })
                    .buttonStyle(PlainButtonStyle())
                    
                    
                    
                   // Test Card
                
                    NavigationLink(
                        destination:
                            TestView()
                                .onAppear(perform: {
                                model.beginTest(m.id)
                            }),
                        tag: m.id,
                        selection: $model.currentTestSelected) {
                        
                        // Test Card
                        HomeViewRow(image: m.test.image, title: "\(m.category) Test", description: m.test.description, count: "\(m.test.questions.count)", time: m.test.time)
                    }
                        .buttonStyle(PlainButtonStyle())
                }
            }
                .padding(/*@START_MENU_TOKEN@*/[.top, .leading, .trailing], 15.0/*@END_MENU_TOKEN@*/)
                    }
                }
            }.navigationTitle("Get started")
        }
    .navigationViewStyle(.stack)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView().environmentObject(ContentModel())
    }
}
