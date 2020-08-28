//
//  setViewController.swift
//  horizontalCustomPicker
//
//  Created by Siddhesh Redkar on 28/08/20.
//  Copyright © 2020 Siddhesh Redkar. All rights reserved.
//

import UIKit

protocol setMeasure:AnyObject {
    func displayHeight(height:CGFloat)
}

class setViewController: UIViewController {

    @IBOutlet weak var heightLbl: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    
    @IBAction func setHWPress(_ sender: Any) {
        let vc = UIStoryboard.init(name: "Main", bundle:nil).instantiateViewController(withIdentifier: "HeightWidthViewController") as! HeightWidthViewController
        vc.delegate = self
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
}

extension setViewController:setMeasure{
    
    func displayHeight(height:CGFloat) {
        heightLbl.text = "HEIGHT : " + String(format: "%.1f", height)
    }
    
    
}
