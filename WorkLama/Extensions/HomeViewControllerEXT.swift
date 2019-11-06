//
//  HomeViewControllerEXT.swift
//  WorkLama
//
//  Created by Mahendra Vishwakarma on 06/11/19.
//  Copyright © 2019 Mahendra Vishwakarma. All rights reserved.
//

import Foundation
import UIKit
import MapKit

extension HomeViewController{
    
    // basic common setup
    func initialSetup() {
        searchbarSetup()
    }
    

//MARK:search bar setup(UI & settings)
    
    func searchbarSetup() {
        
        self.title = "Weather Point"
        navigationController?.navigationBar.prefersLargeTitles = true
        let searchCon = UISearchController(searchResultsController: nil)
        searchCon.searchBar.tintColor = .white
        searchCon.searchBar.enablesReturnKeyAutomatically = true
        searchCon.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = searchCon
        navigationItem.largeTitleDisplayMode = .never
        
    }
}
