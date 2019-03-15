//
//  A3ViewController.swift
//  ElectronicBeycleA3
//
//  Created by hackeru on 09/03/2019.
//  Copyright © 2019 hackeru. All rights reserved.
//

import UIKit

class A3ViewController: UIViewController {
    private var questionArray : [QuestionsFromXml]?
    private let url : String = "https://data.gov.il/dataset/7fa2032a-eca9-48ba-a85b-cdd5a6bafbfa/resource/c99e857c-902d-4539-97b9-2df5c9d5f64c/download/tqa3.xml"

    @IBOutlet weak var tableOutlat: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableOutlat.delegate = self
        getData()
  
    }
    
    func getData(){
        let parser = QuestionsParser()
        parser.parseFeedBack(url: url) { (questionArray) in
            self.questionArray = questionArray
            OperationQueue.main.addOperation {
                self.tableOutlat.reloadSections(IndexSet(integer: 0), with: .left)
                print(questionArray.count)
        }
        }
    }
    
}


extension A3ViewController :  UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let questionArray = questionArray else {
            return 0
        }
        return questionArray.count
    }
    
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableOutlat.dequeueReusableCell(withIdentifier: "cell") as! QuestionTableViewCell
        if let item = questionArray?[indexPath.item]{
            cell.item = item
        }
        return cell
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    

}
