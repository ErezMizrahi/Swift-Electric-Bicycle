//
//  QuestionTableViewCell.swift
//  ElectronicBeycleA3
//
//  Created by hackeru on 09/03/2019.
//  Copyright © 2019 hackeru. All rights reserved.
//

import UIKit

class QuestionTableViewCell: UITableViewCell {


    @IBOutlet weak var questionTitle: UILabel!
    
    var item: QuestionsFromXml? {
        didSet{
//            questionTitle.text = item?.question
        }
    }
}
