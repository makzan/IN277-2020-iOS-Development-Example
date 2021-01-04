//
//  ViewController.swift
//  Quote Today
//
//  Created by Makzan on 14/12/2020.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var quoteLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        quoteLabel.text = "I want to put a ding in the universe. — Steve Jobs"
    }
}

