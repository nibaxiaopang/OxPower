//
//  MilkVC.swift
//  OxPower
//
//  Created by OxPower on 2024/10/25.
//

import UIKit

class OxPowerMilkVewController: UIViewController {

    //MARK: - IBOutlet
    
    @IBOutlet weak var segment2: UISegmentedControl!
    @IBOutlet weak var segment1: UISegmentedControl!
    //MARK: - Variables
    
    //MARK: - Viewlife Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.isHidden = true
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    //MARK: - Function
    
    //MARK: - TableView Delegate & DataSource
    
    //MARK: - Collectionview Delegate & DataSource
    
    //MARK: - IBActions
    @IBAction func segment1Tapped(_ sender: Any) {
    }
    @IBAction func segment2Tapped(_ sender: Any) {
    }
    
    @IBAction func Vack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func Clear(_ sender: Any) {
        self.segment1.selectedSegmentIndex = 0
        self.segment2.selectedSegmentIndex = 0
    }
    
    @IBAction func Calcuate(_ sender: Any) {
        
        self.view.endEditing(true)
        
        let baseProduction: Double = 20.0
                
                // Get the breed factor
                let breedFactor: Double
                switch segment1.selectedSegmentIndex {
                case 0:
                    breedFactor = 1.2  // Holstein
                case 1:
                    breedFactor = 1.0  // Jersey
                case 2:
                    breedFactor = 0.9  // Other
                default:
                    breedFactor = 1.0
                }
                
                // Get the lactation stage factor
                let lactationFactor: Double
                switch segment2.selectedSegmentIndex {
                case 0:
                    lactationFactor = 1.2  // Early lactation
                case 1:
                    lactationFactor = 1.0  // Mid lactation
                case 2:
                    lactationFactor = 0.8  // Late lactation
                default:
                    lactationFactor = 1.0
                }
                
                // Calculate the daily, weekly, and monthly milk production
                let dailyProduction = baseProduction * breedFactor * lactationFactor
                let weeklyProduction = dailyProduction * 7
                let monthlyProduction = dailyProduction * 30
                
                // Display the results
        
        let resultVC = self.storyboard?.instantiateViewController(withIdentifier: "ResultVC") as! OxPowerResultViewController
        resultVC.strAns = String(format: "Daily Production: %.2f liters\nWeekly Production: %.2f liters\nMonthly Production: %.2f liters", dailyProduction, weeklyProduction, monthlyProduction)
        self.navigationController?.pushViewController(resultVC, animated: true)

    }
}
