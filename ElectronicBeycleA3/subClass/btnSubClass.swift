//
//  btnSubClass.swift
//  ElectronicBeycleA3
//
//  Created by hackeru on 15/03/2019.
//  Copyright © 2019 hackeru. All rights reserved.
//

import UIKit

class btnSubClass: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        initBtn()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initBtn()
    }

    func initBtn(){
            layer.borderWidth = 2.0
            layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            layer.cornerRadius = frame.size.height/2
        titleLabel?.numberOfLines = 0
        titleLabel?.lineBreakMode = .byWordWrapping
    }
}
