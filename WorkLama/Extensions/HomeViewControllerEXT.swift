//
//  HomeViewControllerEXT.swift
//  WorkLama
//
//  Created by Mahendra Vishwakarma on 06/11/19.
//  Copyright © 2019 Mahendra Vishwakarma. All rights reserved.
//

import Foundation
import UIKit

extension HomeViewController{
    
    func initialSetup() {
        searchbarSetup()
    }
    
    func searchbarSetup() {
        self.title = "Weather Point"
        navigationController?.navigationBar.prefersLargeTitles = true
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.tintColor = .white
        searchController.searchBar.enablesReturnKeyAutomatically = true
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = searchController
        navigationItem.largeTitleDisplayMode = .never
        
    }
}
