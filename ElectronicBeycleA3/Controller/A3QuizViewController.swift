//
//  A3QuizViewController.swift
//  ElectronicBeycleA3
//
//  Created by hackeru on 09/03/2019.
//  Copyright © 2019 hackeru. All rights reserved.
//

import UIKit

class A3QuizViewController: UIViewController {
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var progressLabel: UILabel!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet var btns: [UIButton]!
    
    private var questionArray : [QuestionsFromXml]?
    private let url : String = "https://data.gov.il/dataset/7fa2032a-eca9-48ba-a85b-cdd5a6bafbfa/resource/c99e857c-902d-4539-97b9-2df5c9d5f64c/download/tqa3.xml"
   
    private var number = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
    }
   
    func getData(){
        let parser = QuestionsParser()
        parser.parseFeedBack(url: url) { [weak self] (questionArray) in
            self?.questionArray = questionArray

            OperationQueue.main.addOperation {
                self?.updateUI()
            }
        }
    }
    
    private func setImage(with urlImage:URL){
        do {
            let data = try Data(contentsOf: urlImage)
            
            img.image = UIImage(data: data)
        }
        catch let err {
            print(err.localizedDescription)
        }
    }
    
    private func updateUI(){
        questionLabel.text = questionArray?[number].question.q
           img.image = nil
        btns.forEach { (btn) in
            btn.layer.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        }
        guard let answer = questionArray?[number].answers[number] else {
            return
        }
        
        guard let imageView = questionArray?[number].question.image else {
            return
        }
        if let urlImage = URL(string: imageView.trimmingCharacters(in: .whitespacesAndNewlines)){
           
                setImage(with: urlImage)
            
        }
        btns[0].setTitle(answer.first_answer.answerString, for: .normal)
        btns[1].setTitle(answer.sec_answer.answerString, for: .normal)
        btns[2].setTitle(answer.third_answer.answerString, for: .normal)
        btns[3].setTitle(answer.fourth_answer.answerString, for: .normal)
        
        guard let count = questionArray?.count else {
            return
        }
        progressLabel.text = "\(number) - \(count)"
        

    }
    
    @IBAction func answerClicked(_ sender: UIButton) {
        guard let answer = questionArray?[number].answers[number] else {
            return
        }
        
        switch sender.tag {
        case 1:
            if (answer.first_answer.isCorrect){
                nextQ()

            }    else {
                sender.layer.backgroundColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
            }

            break
            
        case 2:
            if (answer.sec_answer.isCorrect){
                nextQ()

            }    else {
                sender.layer.backgroundColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
            }
            
            break
        case 3:
            if (answer.third_answer.isCorrect){
                nextQ()

            }    else {
                sender.layer.backgroundColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
            }

            break
        case 4:
            if (answer.fourth_answer.isCorrect){
                nextQ()

            }
            else {
                sender.layer.backgroundColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
            }

            break
        default:
                break}
    }
    
   
    @IBAction func reStart(_ sender: Any) {
        number = 0
        updateUI()
    }
    @IBAction func next(_ sender: Any) {
        nextQ()
    }
    fileprivate func nextQ () {
        number += 1
        updateUI()
    }
    
}
