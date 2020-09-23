//
//  MainMeasureViewController.swift
//  horizontalCustomPicker
//
//  Created by Siddhesh Redkar on 23/09/20.
//  Copyright © 2020 Siddhesh Redkar. All rights reserved.
//

import UIKit

enum Segue{
    static let toHeightFeet = "feet"
    static let toHeightCm = "cm"
}

class MainMeasureViewController: UIViewController,CmDelegate {
    
    
    func cmChanged(height: Int) {
        print(height)
    }
    

    @IBOutlet weak var UnitSegmentContol: UISegmentedControl!
    
     
    @IBOutlet weak var firstRuler: UIView!
    @IBOutlet weak var secondRuler: UIView!
    
     override func viewDidLoad() {
         super.viewDidLoad()
        
         firstRuler.isHidden = false
         secondRuler.isHidden = true
         // Do any additional setup after loading the view.
     }
     
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Segue.toHeightFeet{
            let destVC = segue.destination as! HeightPickerViewController
            destVC.view.backgroundColor = UIColor.orange
            
        }
        
        if segue.identifier == Segue.toHeightCm{
                  let destVC = segue.destination as! HeightCmViewController
                  destVC.view.backgroundColor = UIColor.red
            destVC.delegate = self
              }
        
    }
     
     @IBAction func indexChanged(sender: UISegmentedControl) {
         switch UnitSegmentContol.selectedSegmentIndex
         {
         case 0:
             NSLog("Popular selected")
             firstRuler.isHidden = false
             secondRuler.isHidden = true
             //show popular view
         case 1:
             NSLog("History selected")
             firstRuler.isHidden = true
             secondRuler.isHidden = false
             //show history view
         default:
             break;
         }
     }

}
