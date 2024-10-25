//
//  OxFactVC.swift
//  OxPower
//
//  Created by jin fu on 2024/10/25.
//

import UIKit

class OxPowerOxFactViewController: UIViewController {
    
    //MARK: - IBOutlet
    
    //MARK: - Variables
    @IBOutlet weak var txtVal: UITextView!
    
    //MARK: - Viewlife Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.isHidden = true
        
    }
    
    func generateQRCode(from string: String) -> UIImage? {
        let data = string.data(using: String.Encoding.ascii)
        
        if let filter = CIFilter(name: "CIQRCodeGenerator") {
            filter.setValue(data, forKey: "inputMessage")
            let transform = CGAffineTransform(scaleX: 3, y: 3)
            
            if let output = filter.outputImage?.transformed(by: transform) {
                return UIImage(ciImage: output)
            }
        }
        
        return nil
    }
    
    //MARK: - Function
    
    //MARK: - TableView Delegate & DataSource
    
    //MARK: - Collectionview Delegate & DataSource
    
    //MARK: - IBActions
    
    @IBAction func Back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func Share(_ sender: Any) {
        let objectsToShare = [self.txtVal.text ?? ""]
        let activityVController = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
        activityVController.popoverPresentationController?.sourceView = self.view
        activityVController.popoverPresentationController?.sourceRect = CGRect(x: 100, y: 200, width: 300, height: 300)
        self.present(activityVController, animated: true, completion: nil)
    }
    
    @IBAction func Copy(_ sender: Any) {
        UIPasteboard.general.string = self.txtVal.text ?? ""
        self.view.makeToast("ox facts details copied!")
    }
    
    //QR
    @IBAction func Fact(_ sender: Any) {
        let img = self.generateQRCode(from: self.txtVal.text ?? "")
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "OxFactQRVC") as! OxFactQRVC
        vc.imageQR = img!
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
