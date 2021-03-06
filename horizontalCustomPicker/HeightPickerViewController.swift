//
//  HeightPickerViewController.swift
//  horizontalCustomPicker
//
//  Created by Siddhesh Redkar on 23/09/20.
//  Copyright © 2020 Siddhesh Redkar. All rights reserved.
//

import UIKit

class HeightPickerViewController: UIViewController {
    
    @IBOutlet weak var heightPickerView: UICollectionView!
    @IBOutlet weak var heightLbl: UILabel!

    var heightMeasure = CGFloat()
        let oneInch:CGFloat = 15
        var middleMeasure = CGFloat()
        weak var delegate:setMeasure?
        
        override func viewDidLoad() {
            super.viewDidLoad()
            self.navigationController?.navigationBar.isHidden = true
            print(self.heightPickerView.frame.width)
            setupCollectionView()
            setupCollectionViewLayout()
            calculculateMiddleMeasure()
            
        }
        
        
        private func calculculateMiddleMeasure(){
            let screenWidthHalf = self.view.frame.width/2
            let numberOfBlocks = screenWidthHalf / oneInch
            middleMeasure = (numberOfBlocks/12) - 0.05
            print(middleMeasure)
            heightMeasure = middleMeasure
            
            let str = String(format: "%.1f", middleMeasure)
            let array = str.components(separatedBy: ".")
            print("\(array[0]) ,\(array[1])")
            heightLbl.text = "\(array[0])' \(array[1])''"
        }
        
        private func setupCollectionView(){
            self.heightPickerView.dataSource = self
            self.heightPickerView.delegate = self
        }
        
        private func setupCollectionViewLayout(){
            let flowLayout = UICollectionViewFlowLayout()
            flowLayout.scrollDirection = .horizontal
            flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            flowLayout.itemSize = CGSize(width: oneInch, height: 120)
            flowLayout.minimumInteritemSpacing = 0
            flowLayout.minimumLineSpacing = 0
            self.heightPickerView.collectionViewLayout = flowLayout
        }
        
        
        
        //Actions
        
        
        @IBAction func backPress(_ sender: Any) {
            self.delegate?.displayHeight(height: heightMeasure)
            self.navigationController?.popViewController(animated: true)
        }
        
        
        @IBAction func donePress(_ sender: Any) {
            self.delegate?.displayHeight(height: heightMeasure)
            self.navigationController?.popViewController(animated: true)
        }
        

    }

    extension HeightPickerViewController:UICollectionViewDataSource,UICollectionViewDelegate{
        
        
        func numberOfSections(in collectionView: UICollectionView) -> Int {
            return 20        }
        
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return 12
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
           
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "heightCollectionViewCell", for: indexPath) as! heightCollectionViewCell
            let center = self.view.convert(collectionView.center, to: collectionView)
            let index = collectionView.indexPathForItem(at: center)
          //  print(index)
            
            cell.mView.isHidden = true
            cell.pointFiveMmView.isHidden = true
            cell.mmView.isHidden = false
            cell.HeightLbl.text = ""
            
            if indexPath.row == 0{
                cell.mmView.isHidden = true
                cell.pointFiveMmView.isHidden = true
                cell.mView.isHidden = false
               cell.HeightLbl.text = "\(indexPath.section)"
            }
            if indexPath.row == 6{
                cell.mView.isHidden = true
                cell.mmView.isHidden = true
                cell.pointFiveMmView.isHidden = false
                 cell.HeightLbl.text = ""
            }
            
            return cell
        }
         
        func scrollViewDidScroll(_ scrollView: UIScrollView) {
            let offset = scrollView.contentOffset.x + (self.view.frame.width/2) - 7.5
            print(offset)
            heightMeasure = (offset/(oneInch * 12))
            print(heightMeasure)
            let deci = heightMeasure.fraction
            print(deci)
            
            let jinay = deci * 12
            let jinayRound = String(format: "%.0f", jinay)
            print(jinayRound)
           // let inch = heightMeasure -
           
            let middlevalue = heightMeasure
            print(middlevalue)
            let midWhole = String(format: "%.0f", heightMeasure)
            
            let str = String(format: "%.1f", middlevalue)
            let array = str.components(separatedBy: ".")
            print("\(array[0]) ,\(array[1])")
            heightLbl.text = "\(array[0])' \(array[1])''"
            
            if jinayRound == "12"{
                heightLbl.text = "\(array[0])' \(11) ' '"
            }else{
                heightLbl.text = "\(array[0])' \(jinayRound) ' '"
            }
            
            
            
           // print("currentPage \(heightMeasure.description)")
        }
      

}



