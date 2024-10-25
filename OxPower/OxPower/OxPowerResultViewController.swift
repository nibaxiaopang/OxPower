//
//  ResultVC.swift
//  OxPower
//
//  Created by jin fu on 2024/10/25.
//

import UIKit

class OxPowerResultViewController: UIViewController {

    //MARK: - IBOutlet
    
    @IBOutlet weak var lblAns: UILabel!
    
    var strAns = ""
    //MARK: - Variables
    
    //MARK: - Viewlife Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.isHidden = true
        self.lblAns.text = self.strAns
        
    }
    
    //MARK: - Function
    
    //MARK: - TableView Delegate & DataSource
    
    //MARK: - Collectionview Delegate & DataSource
    
    //MARK: - IBActions
    @IBAction func Back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func Copy(_ sender: Any) {
        UIPasteboard.general.string = self.strAns
        self.view.makeToast("copied!")
    }
    @IBAction func Share(_ sender: Any) {
        let objectsToShare = [self.strAns]
        let activityVController = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
        activityVController.popoverPresentationController?.sourceView = self.view
        activityVController.popoverPresentationController?.sourceRect = CGRect(x: 100, y: 200, width: 300, height: 300)
        self.present(activityVController, animated: true, completion: nil)
    }
    
}
