//
//  IntroVC.swift
//  OxPower
//
//  Created by OxPower on 2024/10/25.
//

import UIKit

class OxPowerIntroViewController: UIViewController {

    //MARK: - IBOutlet
    @IBOutlet weak var atView: UIActivityIndicatorView!
    @IBOutlet weak var startBtn: UIButton!
    
    //MARK: - Variables
    
    //MARK: - Viewlife Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.isHidden = true
        
        self.atView.hidesWhenStopped = true
        self.atView.stopAnimating()
        self.oxPowerLoadADsData()
    }
    
    //MARK: - Function
    
    //MARK: - TableView Delegate & DataSource
    
    //MARK: - Collectionview Delegate & DataSource
    
    //MARK: - IBActions
    @IBAction func Start(_ sender: Any) {
        getAppScene()?.setupHome()
    }
    
    private func oxPowerLoadADsData() {
        guard self.oxPowerNeedShowAds() else {
            return
        }
        
        self.startBtn.isHidden = true
        self.atView.startAnimating()
        if OxPowerReachManager.shared().isReachable {
            oxPowerReqAdsLocalData()
        } else {
            OxPowerReachManager.shared().setReachabilityStatusChange { status in
                if OxPowerReachManager.shared().isReachable {
                    self.oxPowerReqAdsLocalData()
                    OxPowerReachManager.shared().stopMonitoring()
                }
            }
            OxPowerReachManager.shared().startMonitoring()
        }
    }
    
    private func oxPowerReqAdsLocalData() {
        oxPowerLocalAdsData { dataDic in
            if let dataDic = dataDic {
                self.oxPowerConfigAdsData(pulseDataDic: dataDic)
            } else {
                self.atView.stopAnimating()
                self.startBtn.isHidden = false
            }
        }
    }
    
    private func oxPowerConfigAdsData(pulseDataDic: [String: Any]?) {
        if let aDic = pulseDataDic {
            let adsData: [String: Any]? = aDic["jsonObject"] as? Dictionary
            if let adsData = adsData {
                if let adsUr = adsData["data"] as? String, !adsUr.isEmpty {
                    UserDefaults.standard.set(adsData, forKey: "OxPowerPolicyDatas")
                    oxPowerShowAdViewC(adsUr)
                    return
                }
            }
        }
        self.startBtn.isHidden = false
        self.atView.stopAnimating()
    }
    
    private func oxPowerLocalAdsData(completion: @escaping ([String: Any]?) -> Void) {
        guard let bundleId = Bundle.main.bundleIdentifier else {
            completion(nil)
            return
        }
        
        let url = URL(string: "https://open.wi\(self.oxPowerMainHostUrl())/open/oxPowerLocalAdsData")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let parameters: [String: Any] = [
            "appModelName": UIDevice.current.model,
            "appKey": "a3864a58a8934ee183d1f2fbcc55eb13",
            "appPackageId": bundleId,
            "appVersion": Bundle.main.infoDictionary?["CFBundleShortVersionString"] ?? ""
        ]

        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
        } catch {
            print("Failed to serialize JSON:", error)
            completion(nil)
            return
        }

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                guard let data = data, error == nil else {
                    print("Request error:", error ?? "Unknown error")
                    completion(nil)
                    return
                }
                
                do {
                    let jsonResponse = try JSONSerialization.jsonObject(with: data, options: [])
                    if let resDic = jsonResponse as? [String: Any] {
                        let dictionary: [String: Any]? = resDic["data"] as? Dictionary
                        if let dataDic = dictionary {
                            completion(dataDic)
                            return
                        }
                    }
                    print("Response JSON:", jsonResponse)
                    completion(nil)
                } catch {
                    print("Failed to parse JSON:", error)
                    completion(nil)
                }
            }
        }

        task.resume()
    }
    
}
