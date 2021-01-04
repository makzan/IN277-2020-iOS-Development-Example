//
//  CitiesViewController.swift
//  Current Weather
//
//  Created by Makzan on 4/1/2021.
//

import UIKit
import MapKit

class CitiesViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    
    var cities: [CityWeather] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let coordinate = CLLocationCoordinate2DMake(29.920106623769094, 115.67896590791965)
                
        let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 50*1000*100, longitudinalMeters: 30*1000*100)
        mapView.setRegion(region, animated: false)
        
        WeatherService().fetchCitiesWeather { (cities) in
            self.cities = cities
            DispatchQueue.main.async {
                self.renderCities()
            }
        }
    }
    
    func renderCities() {
        var annotations: [MKAnnotation] = []
        for city in cities {
            let annotation = MKPointAnnotation()
            annotation.coordinate = CLLocationCoordinate2D(latitude: city.coordinate.latitude, longitude: city.coordinate.longitude)
            annotation.title = city.cityName
            annotation.subtitle = "\(city.temperatureLow)—\(city.temperatureHigh) \(city.description)"
            annotations.append(annotation)
        }
        
        mapView.addAnnotations(annotations)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
