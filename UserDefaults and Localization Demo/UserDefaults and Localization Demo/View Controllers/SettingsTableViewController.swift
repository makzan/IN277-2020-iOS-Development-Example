//
//  SettingsTableViewController.swift
//  UserDefaults and Localization Demo
//
//  Created by Makzan on 4/1/2021.
//

import UIKit

class SettingsTableViewController: UITableViewController {
    
    let units = [
        NSLocalizedString("Celsius", comment: ""),
        NSLocalizedString("Fahrenheit", comment: "")
    ]
    var selectedUnitIndex = 0
    
    let rowCount = [2,1]
    let headerStrings = [
        NSLocalizedString("Weather Units", comment: ""),
        "\(NSLocalizedString("App Language", comment: "")): \(Bundle.main.preferredLocalizations.first!)"
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        selectedUnitIndex = UserDefaults().integer(forKey: "Selected Unit Index")

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rowCount[section]
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Basic", for: indexPath)
        
        if indexPath.section == 0 {
            cell.textLabel?.text = units[indexPath.row]
            
            if selectedUnitIndex == indexPath.row {
                cell.accessoryType = .checkmark
            } else {
                cell.accessoryType = .none
            }
        }
        if indexPath.section == 1 {
            cell.textLabel?.text = NSLocalizedString("Configure App Language", comment: "")
            cell.accessoryType = .none
        }

        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return headerStrings[section]
    }
    
    // MARK: - Table view delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            selectedUnitIndex = indexPath.row
            UserDefaults().setValue(selectedUnitIndex, forKey: "Selected Unit Index")
            tableView.reloadData()
        }
        if indexPath.section == 1 {
            tableView.deselectRow(at: indexPath, animated: true)
            guard let url = URL(string: UIApplication.openSettingsURLString) else {return}
            UIApplication.shared.open(url)
        }
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
