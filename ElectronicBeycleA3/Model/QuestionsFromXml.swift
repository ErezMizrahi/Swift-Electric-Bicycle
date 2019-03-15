//
//  Questions.swift
//  ElectronicBeycleA3
//
//  Created by hackeru on 08/03/2019.
//  Copyright © 2019 hackeru. All rights reserved.
//

import Foundation
struct QuestionsFromXml {
     var question : Question
     var answers : [AnswersCollection]
}

struct Question {
    var image : String?
    var q : String
    
    init(q : String, image : String) {
        self.q = q
        self.image = image
    }
    
}

class AnswersCollection {
    var first_answer : Answer
    var sec_answer : Answer
    var third_answer : Answer
    var fourth_answer : Answer
    
    init(first : Answer, sec :  Answer, thrid : Answer, forth : Answer) {
        self.first_answer = first
        self.sec_answer = sec
        self.third_answer = thrid
        self.fourth_answer = forth
    }
    
    
    }


struct Answer{
    var answerString : String
    var isCorrect : Bool
    
    init(string : String, isCorrect :Bool) {
        self.answerString = string
        self.isCorrect = isCorrect
    }
}

class AnswerFormater {
 
    var formatedAnswer : String?
    var correctAnswer : Bool?

    init(answer : String) {
        if answer.contains("id="){
            correctAnswer = true
        }else{
            correctAnswer = false
        }
        self.formatedAnswer = formate(str: answer)
        
}
    private func formate(str: String) -> String {
   
            let string = String(htmlEncodedString: str)
        if let encodedString = string {
        return encodedString
        }
        return ""
    }
    
 
}

extension String {
    
    init?(htmlEncodedString: String) {
        
        guard let data = htmlEncodedString.data(using: .utf8) else {
            return nil
        }
        
        let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue
        ]
        
        guard let attributedString = try? NSAttributedString(data: data, options: options, documentAttributes: nil) else {
            return nil
        }
        
        self.init(attributedString.string)
    }
    
}
