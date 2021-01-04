//
//  TodayViewController.swift
//  Current Weather
//
//  Created by Makzan on 18/12/2020.
//

import UIKit

class TodayViewController: UIViewController {
    
    var weather:Weather = Weather()

    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var windLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var todayLabel: UILabel!
    @IBOutlet weak var detailButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
                
        detailButton.layer.cornerRadius = 5
        
        NotificationCenter.default.addObserver(self, selector: #selector(fetchButtonTapped), name: UIApplication.didBecomeActiveNotification, object: nil)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchWeather()
    }
    
    @IBAction func fetchButtonTapped(_ sender: Any) {
        fetchWeather()
    }
    
    func fetchWeather() {        
        WeatherService().fetchCurrentWeather { (weather) in
            self.weather = weather
            print("Weather data fetched")
            
            DispatchQueue.main.async {
                self.updateView()
            }
        }
    }
    
    func updateView() {
        temperatureLabel.text = "\(weather.temperature)℃"
        windLabel.text = "風力：\(weather.windDescription) \(weather.windSpeed) km/hr"
        dateLabel.text = weather.date
        todayLabel.text = weather.today
                
        let weatherSymbol = StatusCode.symbolFor(statusCode: weather.statusCode)
        weatherIcon.image = UIImage(systemName: weatherSymbol)
        
        
    }
    
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        let vc = segue.destination as! DetailViewController
        vc.weather = self.weather
    }
    


}



