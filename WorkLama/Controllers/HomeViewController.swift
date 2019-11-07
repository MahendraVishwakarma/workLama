//
//  ViewController.swift
//  WorkLama
//
//  Created by Mahendra Vishwakarma on 06/11/19.
//  Copyright © 2019 Mahendra Vishwakarma. All rights reserved.
//

import UIKit
import MapKit

class HomeViewController: UIViewController {

    @IBOutlet weak var loader: UIActivityIndicatorView!
    let listView = CityCollectionView()
    var weatherInfo: CityWeather?
    var searchCon:UISearchController!
    var annotation = MKPointAnnotation()
    @IBOutlet weak var mapview: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
    }


}

