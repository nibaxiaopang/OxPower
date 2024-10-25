//
//  WeightVC.swift
//  OxPower
//
//  Created by OxPower on 2024/10/25.
//

import UIKit

class OxPowerWeightViewController: UIViewController {
    
    //MARK: - IBOutlet
    
    @IBOutlet weak var txtLength: UITextField!
    @IBOutlet weak var txtGirth: UITextField!
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
        self.txtGirth.text = ""
        self.txtLength.text = ""
    }
    @IBAction func Claculate(_ sender: Any) {
        
        self.view.endEditing(true)
        
        guard let girthText = txtGirth.text, let girth = Double(girthText),
              let lengthText = txtLength.text, let length = Double(lengthText) else {
            self.view.makeToast("Please enter valid measurements.")
            return
        }
        
        let weight = (pow(girth, 2) * length) / 300
        
        let resultVC = self.storyboard?.instantiateViewController(withIdentifier: "ResultVC") as! OxPowerResultViewController
        resultVC.strAns = String(format: "Estimated Ox Weight: %.2f kg", weight)
        self.navigationController?.pushViewController(resultVC, animated: true)
    }
    
}
