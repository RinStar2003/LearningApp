//
//  RectangleCard.swift
//  LearningApp
//
//  Created by мас on 12.01.2022.
//

import SwiftUI

struct RectangleCard: View {
    
    var color = Color.white
    
    var body: some View {
        
        Rectangle()
            .foregroundColor(color)
            .cornerRadius(10)
            .shadow(radius: 5)
            .padding(.horizontal)
        
    }
}

struct RectangleCard_Previews: PreviewProvider {
    static var previews: some View {
        RectangleCard()
    }
}
