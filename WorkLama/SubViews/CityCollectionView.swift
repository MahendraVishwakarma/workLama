//
//  CityCollectionView.swift
//  WorkLama
//
//  Created by Mahendra Vishwakarma on 06/11/19.
//  Copyright © 2019 Mahendra Vishwakarma. All rights reserved.
//

import UIKit

class CityCollectionView: UIView {

    @IBOutlet var containerView: UIView!
    @IBOutlet weak var tableview: UITableView!
    var productsName:Array<String>!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialization()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialization()
    }
    
    func initialization() {
        
        Bundle.main.loadNibNamed(AppUtility.cityCollectionXIBName, owner: self, options: nil)
        containerView.setFrameInView(self)
        tableview.register(UINib(nibName: "CityCell", bundle: nil), forCellReuseIdentifier: "cityCell")
        self.layer.borderColor = UIColor.blue.cgColor
        self.layer.borderWidth = 0.5
        
    }
    

}
