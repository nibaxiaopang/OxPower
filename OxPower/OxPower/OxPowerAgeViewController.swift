//
//  AgeVC.swift
//  OxPower
//
//  Created by OxPower on 2024/10/25.
//

import UIKit

class OxPowerAgeViewController: UIViewController {

    //MARK: - IBOutlet
    
    @IBOutlet weak var txtAge: UITextField!
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
    @IBAction func Back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func Clear(_ sender: Any) {
        self.txtAge.text = ""
    }
    
    @IBAction func Calculate(_ sender: Any) {
        
        self.view.endEditing(true)
        
        guard let humanAgeText = txtAge.text, let humanAge = Int(humanAgeText) else {
            self.view.makeToast("Please enter a valid age.")
            return
        }
        
        let oxAge = humanAge * 4 // Example conversion factor
        let resultVC = self.storyboard?.instantiateViewController(withIdentifier: "ResultVC") as! OxPowerResultViewController
        resultVC.strAns = "In Ox years, you are \(oxAge) years old."
        self.navigationController?.pushViewController(resultVC, animated: true)
    }
    
}
