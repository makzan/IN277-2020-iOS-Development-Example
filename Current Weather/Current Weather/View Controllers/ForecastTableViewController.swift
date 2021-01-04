//
//  ForecastTableViewController.swift
//  Current Weather
//
//  Created by Makzan on 28/12/2020.
//

import UIKit

class ForecastTableViewController: UITableViewController {
    
    let WEATHER_ICON_TAG = 1001
    let DATE_TAG = 2001
    let DESCRIPTION_TAG = 2002
    let TEMP_TAG = 2003
    
    var forecasts:[ForecastDay] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchWeatherForecast()
        
//        let appearance = UINavigationBarAppearance()
//        appearance.configureWithOpaqueBackground()
//        appearance.
//        appearance.largeTitleTextAttributes
        
//        navigationItem.standardAppearance = appearance
//        navigationItem.scrollEdgeAppearance = appearance
                
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    func fetchWeatherForecast() {
        guard let url = URL(string: "https://dev.makzan.net/weather.json") else { return }

        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            
            if error != nil {
                print(error!)
                return
            }
            
            do {
                let json = try JSONDecoder().decode(Forecast.self, from: data)
                self.forecasts = json.forecasts
                
                print(self.forecasts)
                
                // we need this to update UI View.
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                
            } catch let error{
                print("Fetch error.")
                print(error)
            }
        }.resume()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return forecasts.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section >= forecasts.count {
            return ""
        }
        let forecastDay = forecasts[section]
        return forecastDay.date
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherCell", for: indexPath)

        if indexPath.section >= forecasts.count {
            return cell
        }
        
        // Data
        let forecastDay = forecasts[indexPath.section]
        
        // Configure the cell...
        let tempLabel = cell.viewWithTag(TEMP_TAG) as? UILabel
        tempLabel?.text = "\(forecastDay.temperatureLow)℃—\(forecastDay.temperatureHigh)℃"
        
        let dateLabel = cell.viewWithTag(DATE_TAG) as? UILabel
        dateLabel?.text = forecastDay.date
        
        let descriptionLabel = cell.viewWithTag(DESCRIPTION_TAG) as? UILabel
        descriptionLabel?.text = forecastDay.description
        
        let weatherSymbol = StatusCode.symbolFor(statusCode: forecastDay.statusCode)
        print(weatherSymbol)
        let weatherIcon = cell.viewWithTag(WEATHER_ICON_TAG) as? UIImageView
        weatherIcon?.image = UIImage(systemName: weatherSymbol)
        

        return cell
    }
    
    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
