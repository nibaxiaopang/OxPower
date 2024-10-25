//
//  FeedVC.swift
//  OxPower
//
//  Created by OxPower on 2024/10/25.
//

import UIKit

class OxPowerFeedViewController: UIViewController {

    //MARK: - IBOutlet
    
    @IBOutlet weak var segment: UISegmentedControl!
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

    @IBAction func segmentTapped(_ sender: Any) {
    }
    @IBAction func Back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func Clear(_ sender: Any) {
        self.txtWeight.text = ""
        self.segment.selectedSegmentIndex = 0
    }
    
    @IBAction func Calculate(_ sender: Any) {
        
        self.view.endEditing(true)
        
        guard let weightText = txtWeight.text, let weight = Double(weightText) else {
            self.view.makeToast("Please enter a valid weight.")
                    return
                }
                
                let feedRequirementFactor: Double
                
                // Set the feed requirement factor based on the selected activity level
                switch segment.selectedSegmentIndex {
                case 0:
                    feedRequirementFactor = 0.02  // Low activity
                case 1:
                    feedRequirementFactor = 0.025 // Moderate activity
                case 2:
                    feedRequirementFactor = 0.03  // High activity
                default:
                    feedRequirementFactor = 0.02
                }
                
                let dailyFeed = weight * feedRequirementFactor
        
        let resultVC = self.storyboard?.instantiateViewController(withIdentifier: "ResultVC") as! OxPowerResultViewController
        resultVC.strAns = String(format: "Daily Feed Requirement: %.2f kg", dailyFeed)
        self.navigationController?.pushViewController(resultVC, animated: true)
        
    }
}
