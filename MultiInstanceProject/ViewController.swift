//
//  ViewController.swift
//  MultiInstanceProject
//
//  Created by Karthik Iyer on 11/01/23.
//

import UIKit

class ViewController: UIViewController {
    
    var countryFlag = ""
    let defaults = UserDefaults(suiteName: "group.clevertapTest")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        let getFlagValue = defaults?.value(forKey: "countryFlagSelected") as? String
        if(getFlagValue == "KWT") {
            let namestoryboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = namestoryboard.instantiateViewController(withIdentifier: "KuwaitScreenViewController") as! KuwaitScreenViewController
            self.navigationController!.pushViewController(vc, animated: true)
        } else if(getFlagValue == "OMN") {
            let namestoryboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = namestoryboard.instantiateViewController(withIdentifier: "OmanScreenViewController") as! OmanScreenViewController
            self.navigationController!.pushViewController(vc, animated: true)
        }
    }
    
    
    @IBAction func goToKuwaitScreen(_ sender: Any) {
        countryFlag = "KWT"
        defaults!.set(countryFlag, forKey: "countryFlagSelected")
        
        let namestoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = namestoryboard.instantiateViewController(withIdentifier: "KuwaitScreenViewController") as! KuwaitScreenViewController
        self.navigationController!.pushViewController(vc, animated: true)
        
    }
    
    @IBAction func gotToOmanScreen(_ sender: Any) {
        countryFlag = "OMN"
        defaults!.set(countryFlag, forKey: "countryFlagSelected")
        
        let namestoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = namestoryboard.instantiateViewController(withIdentifier: "OmanScreenViewController") as! OmanScreenViewController
        self.navigationController!.pushViewController(vc, animated: true)
        
    }
    
}

