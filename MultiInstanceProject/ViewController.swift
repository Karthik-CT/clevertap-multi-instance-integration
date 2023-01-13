//
//  ViewController.swift
//  MultiInstanceProject
//
//  Created by Karthik Iyer on 11/01/23.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func goToKuwaitScreen(_ sender: Any) {
        let namestoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = namestoryboard.instantiateViewController(withIdentifier: "KuwaitScreenViewController") as! KuwaitScreenViewController
        self.navigationController!.pushViewController(vc, animated: true)
    }
    
    @IBAction func gotToOmanScreen(_ sender: Any) {
        let namestoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = namestoryboard.instantiateViewController(withIdentifier: "OmanScreenViewController") as! OmanScreenViewController
        self.navigationController!.pushViewController(vc, animated: true)
    }
    
}

