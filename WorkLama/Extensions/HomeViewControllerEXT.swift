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
        listView.delegatePass = self
        self.view.addSubview(listView)
    }
    
//MARK:search bar setup(UI & settings)
    func searchbarSetup() {
        
        self.title = "Weather Point"
        navigationController?.navigationBar.prefersLargeTitles = true
        let searchCon = UISearchController(searchResultsController: nil)
        searchCon.searchBar.delegate = self
        searchCon.searchBar.tintColor = .white
        searchCon.searchBar.enablesReturnKeyAutomatically = true
        searchCon.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = searchCon
        navigationItem.largeTitleDisplayMode = .never
        definesPresentationContext = true
        let yOrigin = (self.navigationController?.navigationBar.frame.size.height ?? 0) + UIApplication.shared.statusBarFrame.height + searchCon.searchBar.frame.height
        self.listView.frame = CGRect(x: 0, y: yOrigin, width: self.view.frame.width, height: 0)
        
    }
    
    func dismissListView(yOrigin:CGFloat) {
        UIView.animate(withDuration: 0.4, animations: {
          self.listView.frame = CGRect(x: 0, y: yOrigin, width: self.view.frame.width, height: 0)
            self.listView.layoutIfNeeded()
        })
    }
    
    func setListViewHeight(height:CGFloat, yOrigin:CGFloat) {
        UIView.animate(withDuration: 0.4, animations: {
            self.listView.frame = CGRect(x: 0, y: yOrigin, width: self.view.frame.width, height: height)
            self.listView.layoutIfNeeded()
        })
    }
}

extension HomeViewController:PassData {
    func passData(city: City) {
        fetchWeatherInfo(cityID: city.id)
    }
    
    func fetchWeatherInfo(cityID:Int) {
        let url = String(format: AppUtility.weatherURL, cityID)
        WebServices.requestHttp(urlString: url, method: .Get, param: nil, decode: { (json) -> CityWeather? in
            guard let response = json as? CityWeather else{
                return nil
            }
            
            return response
            
        }) { (result) in
            switch result {
            case .success(let cityData) :
                self.weatherInfo = cityData
                self.addAnnotation()
                break
            case .failure(let error) :
                self.showToast(message: error.localizedDescription)
                break
            }
        }
    }
    
    func addAnnotation() {
        let coordinate = CLLocationCoordinate2D(latitude: self.weatherInfo?.coord.lat ?? 12.9716, longitude: self.weatherInfo?.coord.lon ?? 77.5946)
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        annotation.title = ""
        annotation.subtitle = ""
        self.mapview.addAnnotation(annotation)
    }
    
}

//MARK: searchbar delegate implementation
extension HomeViewController:UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        let yOrigin = (self.navigationController?.navigationBar.frame.size.height ?? 0) + UIApplication.shared.statusBarFrame.height + searchBar.frame.height
        dismissListView(yOrigin: yOrigin)
    }
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        let yOrigin = (searchBar.frame.size.height ) + UIApplication.shared.statusBarFrame.height
        findCitiesBy(keyword: "a", yOrigin: yOrigin)
        
        return true
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let yOrigin = (searchBar.frame.size.height ) + UIApplication.shared.statusBarFrame.height
        if(searchText.count > 0) {
            findCitiesBy(keyword: searchText, yOrigin: yOrigin)
        }else {
            
            dismissListView(yOrigin: yOrigin)
        }
    }
    
    func findCitiesBy(keyword:String, yOrigin:CGFloat) {
        let filteredCities:Cities = AppUtility.citiesList?.filter({$0.name.contains(keyword)}) ?? []
        listView.cities = filteredCities
        let height = 47*filteredCities.count + 18
        let calculatedHeight = height >= 390 ? 390 : height
        setListViewHeight(height: CGFloat(calculatedHeight), yOrigin: yOrigin)
        listView.reloadData()
    }
}

//MARK: mapview delegates
extension HomeViewController:MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            return nil
        }
        
        let identifier = "MyCustomAnnotation"
        
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true
        } else {
            annotationView!.annotation = annotation
        }
        
        configureDetailView(annotationView: annotationView!)
        
        return annotationView
    }
    
    func configureDetailView(annotationView: MKAnnotationView) {
        let width = 300
        let height = 190
        
        let snapshotView = UIView()
        let views = ["snapshotView": snapshotView]
        snapshotView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:[snapshotView(300)]", options: [], metrics: nil, views: views))
        snapshotView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[snapshotView(190)]", options: [], metrics: nil, views: views))
        
        let options = MKMapSnapshotter.Options()
        options.size = CGSize(width: width, height: height)
        options.mapType = .satelliteFlyover
        options.camera = MKMapCamera(lookingAtCenter: annotationView.annotation!.coordinate, fromDistance: 250, pitch: 65, heading: 0)
        
        let snapshotter = MKMapSnapshotter(options: options)
        snapshotter.start { snapshot, error in
            if snapshot != nil {
                
                let cityNameLabel = UILabel(frame: CGRect(x: 0, y: 8, width: width, height: 21))
                let tempLabel = UILabel(frame: CGRect(x: 0, y: Int(cityNameLabel.frame.maxY + 16), width: width, height: 21))
                let weatherlabel = UILabel(frame: CGRect(x: 0, y: Int(tempLabel.frame.maxY + 16), width: width, height: 21))
                let wingSpeedLabel = UILabel(frame: CGRect(x: 0, y: Int(weatherlabel.frame.maxY + 16), width: width, height: 21))
                let humanityLabel = UILabel(frame: CGRect(x: 0, y: Int(wingSpeedLabel.frame.maxY + 16), width: width, height: 21))
                
                cityNameLabel.text = "Bangalore"
                cityNameLabel.textAlignment = .center
                tempLabel.text = "temp"
                weatherlabel.text = "weather"
                wingSpeedLabel.text = "wing speed"
                humanityLabel.text = "humanity"
                
                snapshotView.addSubview(cityNameLabel)
                snapshotView.addSubview(tempLabel)
                snapshotView.addSubview(weatherlabel)
                snapshotView.addSubview(wingSpeedLabel)
                snapshotView.addSubview(humanityLabel)
                
                
            }
        }
        let regionRadius: CLLocationDistance = 1000
        let coordinate = CLLocationCoordinate2D(latitude: self.weatherInfo?.coord.lat ?? 12.9716, longitude: self.weatherInfo?.coord.lon ?? 77.5946)
        let coordinateRegion = MKCoordinateRegion(center: coordinate,latitudinalMeters: regionRadius * 2.0, longitudinalMeters: regionRadius * 2.0)
        mapview.setRegion(coordinateRegion, animated: true)
        annotationView.detailCalloutAccessoryView = snapshotView
    }
}
