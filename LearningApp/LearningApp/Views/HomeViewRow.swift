//
//  HomeViewRow.swift
//  LearningApp
//
//  Created by мас on 05.01.2022.
//

import SwiftUI

struct HomeViewRow: View {
    
    var image: String
    var title: String
    var description: String
    var count: String
    var time: String
    
    var body: some View {
        
        ZStack {
            Rectangle()
                .aspectRatio(CGSize(width: /*@START_MENU_TOKEN@*/335.0/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/175.0/*@END_MENU_TOKEN@*/), contentMode: .fit)
                .foregroundColor(.white)
                .cornerRadius(10)
                .shadow(radius: 5)
            
            HStack {
                Image(image)
                    .resizable()
                    .frame(width: 116, height: 116)
                    .clipShape(Circle())
                
                Spacer()
                
                VStack(alignment: .leading, spacing: 10) {
                    
                    Text("\(title)")
                    .bold()
                    
                    Text(description)
                        .font(.caption)
                        .multilineTextAlignment(.leading)
                        .padding(.bottom, 20.0)
            
                    HStack {
                        
                        
                        Image(systemName: "text.book.closed").resizable().frame(width: 15, height: 15)
                        Text("\(count) lessons").font(.caption)
                        Spacer()
                        Image(systemName: "clock").resizable().frame(width: 15, height: 15)
                        Text(time).font(.caption)
                        
                    }.font(.caption)
                    
                }.padding(.leading, 20)
                    
            }
            .padding(.horizontal, 20)
            
        }
        .padding(.bottom)
        
        
    }
}

struct HomeViewRow_Previews: PreviewProvider {
    static var previews: some View {
        HomeViewRow(image: "swift", title: "Swift", description: "smg", count: "10 lessons", time: "2 hours")
    }
}
