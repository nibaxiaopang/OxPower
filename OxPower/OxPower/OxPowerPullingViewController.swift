//
//  PullingVC.swift
//  OxPower
//
//  Created by OxPower on 2024/10/25.
//

import UIKit

class OxPowerPullingViewController: UIViewController {

    //MARK: - IBOutlet
    
    @IBOutlet weak var segment2: UISegmentedControl!
    @IBOutlet weak var segment1: UISegmentedControl!
    @IBOutlet weak var txtWeight: UITextField!
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
    @IBAction func segmentTapped2(_ sender: Any) {
    }
    
    @IBAction func segmentTapped1(_ sender: Any) {
    }
    @IBAction func Back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func Clear(_ sender: Any) {
        self.txtWeight.text = ""
        self.segment1.selectedSegmentIndex = 0
        self.segment2.selectedSegmentIndex = 0
    }
    
    @IBAction func Calculate(_ sender: Any) {
        
        self.view.endEditing(true)
        
        guard let weightText = txtWeight.text, let weight = Double(weightText) else {
            self.view.makeToast("Please enter a valid weight.")
                    return
                }
                
                let pullingEfficiencyFactor: Double
                let terrainFactor: Double
                
                // Set the pulling efficiency factor based on the breed
                switch segment1.selectedSegmentIndex {
                case 0:
                    pullingEfficiencyFactor = 0.10  // Weaker breed
                case 1:
                    pullingEfficiencyFactor = 0.15  // Stronger breed
                default:
                    pullingEfficiencyFactor = 0.10
                }
                
                // Set the terrain factor based on the selected terrain type
                switch segment2.selectedSegmentIndex {
                case 0:
                    terrainFactor = 1.0  // Flat terrain
                case 1:
                    terrainFactor = 0.8  // Rough terrain
                case 2:
                    terrainFactor = 0.6  // Steep terrain
                default:
                    terrainFactor = 1.0
                }
                
                let pullingPower = weight * pullingEfficiencyFactor * terrainFactor
        
        let resultVC = self.storyboard?.instantiateViewController(withIdentifier: "ResultVC") as! OxPowerResultViewController
        resultVC.strAns = String(format: "Estimated Pulling Power: %.2f kg", pullingPower)
        self.navigationController?.pushViewController(resultVC, animated: true)

    }
}
