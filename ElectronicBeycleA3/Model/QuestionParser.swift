//
//  QuestionParser.swift
//  ElectronicBeycleA3
//
//  Created by hackeru on 08/03/2019.
//  Copyright © 2019 hackeru. All rights reserved.
//

import Foundation

class QuestionsParser: NSObject {
    private var questionsArray : [QuestionsFromXml] = []
    //can delete
    private var answers : [AnswersCollection] = []
    private var image = ""
    private var currentElement = ""
    private var currentTitle = "" {
        didSet {
            currentTitle = currentTitle.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        }
    }
    private var currentDescription = ""{
        didSet {
            currentDescription = currentDescription.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        }
    }
    private var parserCompletionHandler : (([QuestionsFromXml])->Void)?
    
    func parseFeedBack (url : String , completionHandler : @escaping (([QuestionsFromXml])->Void)){
        self.parserCompletionHandler = completionHandler
        let request = URLRequest(url: URL(string: url)!)
        let urlSession = URLSession.shared
        let task = urlSession.dataTask(with: request) { (data, respone, error) in
            guard let data = data else {
                if let error = error {
                    print (error.localizedDescription)
                }
                return
            }
            let parser = XMLParser(data: data)
            parser.delegate = self
            parser.parse()
        }
        task.resume()
    }
}

extension QuestionsParser :XMLParserDelegate {
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        currentElement = elementName
        if currentElement == "item" {
            currentTitle = ""
            currentDescription = ""
        }
    }
    
    func parser(_ parser : XMLParser, foundCharacters string : String){
        switch currentElement {
        case "title":
            currentTitle += string
        case "description":
            currentDescription += string
        default: break
            
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "item"{
            let q = Question(q: currentTitle.replacingOccurrences(of: ".00", with: ""), image: image)
            let question = QuestionsFromXml(question : q, answers : answers)
            self.questionsArray.append(question)
        }
    }
    // can be deleted!
    func parser(_ parser: XMLParser, foundCDATA CDATABlock: Data) {
        switch currentElement {
        case "description":
            let str = String(data: CDATABlock, encoding: .utf8)
            var arrWithHTML:[String] = []
            var formatedAnswers : [Answer] = []
            var images : [String] = []
            
            if str!.contains("</span>"){
                if str!.contains("<img src=") {
                    images = str!.components(separatedBy: "<img src=")
                    let stringImage = String(htmlEncodedString: images[1])
                    images = stringImage!.components(separatedBy: "border")
                    image = images[0].replacingOccurrences(of: "\"", with: "")
                }
                 arrWithHTML = str!.components(separatedBy: "</span>")
                for number in arrWithHTML.indices {
                    let answer = AnswerFormater(answer: arrWithHTML[number])
                    let formated = answer.formatedAnswer
                    let answerBool = answer.correctAnswer
                    let a : Answer = Answer(string: formated!, isCorrect: answerBool!)
                    formatedAnswers.append(a)

                }

                answers.append(AnswersCollection(first: formatedAnswers[0], sec: formatedAnswers[1], thrid: formatedAnswers[2], forth: formatedAnswers[3]))
                
            }
            
        default:
            break
        }
    }
    
    func parserDidEndDocument(_ parser: XMLParser) {
        parserCompletionHandler?(questionsArray)
    }
    
    func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {
        print(parseError.localizedDescription)
    }
}

