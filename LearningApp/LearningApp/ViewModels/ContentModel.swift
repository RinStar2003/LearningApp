//
//  ContentModel.swift
//  LearningApp
//
//  Created by мас on 03.01.2022.
//

import Foundation


class ContentModel: ObservableObject {
    
    
    //list of modules
    @Published var modules = [Module]()
    
    //Current ,odele
    
    @Published var currentModule: Module?
    var currentModuleIndex = 0
    
    @Published var currentLesson: Lesson?
    var currentLessonIndex = 0
    
    
    @Published var currentQuestion: Question?
    var currentQuestionIndex = 0
    
    
    @Published var codeText = NSAttributedString()
    var styleData: Data?
    
    // Current selected content and test
    @Published var currentContentSelected:Int?
    @Published var currentTestSelected: Int?
    
    init() {
        
        // Parse local included JSON data, download remote JSON data
        
        getLocalData()
        
        getRemoteData()
    }
    
    


    // MARK - Data methods

    func getLocalData() {
    
    let jsonUrl = Bundle.main.url(forResource: "data", withExtension: "json")
    
    do {
        
        let jsonData = try Data(contentsOf: jsonUrl!)
        
        let jsonDecoder = JSONDecoder()
        let modules = try jsonDecoder.decode([Module].self, from: jsonData)
        
        self.modules = modules
    }
    catch {
        print("ERROR: Couldn't parse local data")
    }
    
    let styleUrl = Bundle.main.url(forResource: "style", withExtension: "html")
    
    do {
        let styleData = try Data(contentsOf: styleUrl!)
        
        self.styleData = styleData
    }
    catch {
        print("Error")
    }
}
    
    func getRemoteData() {
        
        let urlString = "https://rinstar2003.github.io/learningapp-data/data2.json"
        
        // New URL object
        let url = URL(string: urlString)
    
        guard url != nil else {
            // Couldn't create url
            return
        }
        // Create a URLRequest object
        let request = URLRequest(url: url!)
        
        // Get the session and kick off the task
        let session = URLSession.shared
        
        let dataTask = session.dataTask(with: request) { (data, response, error) in
            
            // Check if there's an error
            guard error == nil else {
                // There was an error
                return
            }
            
            // Handle the response
            
            do {
            // Create json decoder
            let decoder = JSONDecoder()
            
            // Decode
            
                let modules = try decoder.decode([Module].self, from: data!)
                
                self.modules += modules
            
            } catch {
                // Couldn't parse json
                print("Error")
            }
        }
        dataTask.resume()
}

    
    // MARK: - Module navigation methods
    
    func beginModule(_ moduleid: Int) {
        
        // Find the index for this module id
        for index in 0..<modules.count {
            if modules[index].id == moduleid {
                // Found the matching module
                currentModuleIndex = index
                break
            }
        }
        
        //Ser the current module
        currentModule = modules[currentModuleIndex]
}

    func beginLesson(_ lessonIndex: Int) {
        
        if lessonIndex < currentModule!.content.lessons.count {
            currentLessonIndex = lessonIndex
            }
        else {
            currentLessonIndex = 0
        }
        
        currentLesson = currentModule!.content.lessons[currentLessonIndex]
        codeText = addStyling(currentLesson!.explanation)
}
    
    func nextQuestion() {
        
        // Advance the question index
        
        currentQuestionIndex += 1
        
        
        // Check that it's within the range of questions
        
        
        if currentQuestionIndex < currentModule!.test.questions.count {
            
        
            // Set current question
            currentQuestion = currentModule!.test.questions[currentQuestionIndex]
            codeText = addStyling(currentQuestion!.content)
        }
        else {
            
            currentQuestionIndex = 0
            currentQuestion = nil
        }
}
    
    
    
    func nextLesson() {
        
        currentLessonIndex += 1
        
        if currentLessonIndex < currentModule!.content.lessons.count {
            
            
            currentLesson = currentModule!.content.lessons[currentLessonIndex]
            codeText = addStyling(currentLesson!.explanation)
        } else {
            
            currentLesson = nil
            currentLessonIndex = 0
            
        }
        
}
    
    
    func hasItNextLesson() -> Bool {
        
        if currentLessonIndex + 1 < currentModule!.content.lessons.count {
            return true
            
        } else {
            
            return false
        
    }
}
    
    
    func beginTest(_ moduleId:Int) {
        
        
        beginModule(moduleId)
        
        
        currentQuestionIndex = 0
        
        
        if currentModule?.test.questions.count ?? 0 > 0 {
            currentQuestion = currentModule?.test.questions[currentQuestionIndex]
            
            // Set the question content
            codeText = addStyling(currentQuestion!.content)
        }
}
    
    
    private func addStyling(_ htmlString: String) -> NSAttributedString {
        
        var resultString = NSAttributedString()
        var data = Data()
        
        if styleData != nil {
         
            data.append(self.styleData!)
        
        }
        
        data.append(Data(htmlString.utf8))

            
            if let attributedString = try? NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil) {
                
                resultString = attributedString
            }
                return resultString
        
}
}
