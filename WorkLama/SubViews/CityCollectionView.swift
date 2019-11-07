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
    var cities = Cities()
    weak var delegatePass:PassData?
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialization()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialization()
    }
    deinit {
        delegatePass = nil
    }
    
   private func initialization() {
        Bundle.main.loadNibNamed(AppUtility.cityCollectionXIBName, owner: self, options: nil)
        containerView.setFrameInView(self)
        tableview.register(UINib(nibName: "CityCell", bundle: nil), forCellReuseIdentifier: "cityCell")
        tableview.layer.cornerRadius = 10
        self.layer.shadowColor = UIColor(red: 54.0/255.0, green: 149.0/255.0, blue: 215.0/255.0, alpha: 1).cgColor
        self.layer.shadowOpacity = 1
        self.layer.shadowOffset = CGSize.zero
        self.layer.shadowRadius = 5
    }
    
    func reloadData() {
        tableview.reloadData()
    }
    
}
//MARK: TableView Datasource & Delegate
extension CityCollectionView:UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cities.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cityCell", for: indexPath) as? CityCell else{
            return CityCell()
        }
        cell.setdata(city: cities[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegatePass?.passData(city: cities[indexPath.row])
    }
    
}
