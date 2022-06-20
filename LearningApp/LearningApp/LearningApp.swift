//
//  LearningAppApp.swift
//  LearningApp
//
//  Created by мас on 01.01.2022.
//

import SwiftUI

@main
struct LearningApp: App {
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(ContentModel())
        }
    }
}
