//
//  HeightCmViewController.swift
//  horizontalCustomPicker
//
//  Created by Siddhesh Redkar on 23/09/20.
//  Copyright © 2020 Siddhesh Redkar. All rights reserved.
//

import UIKit

protocol CmDelegate:class{
    func cmChanged(height:Int)
}

class HeightCmViewController: UIViewController {
    
    @IBOutlet weak var heightPickerView: UICollectionView!
    @IBOutlet weak var heightLbl: UILabel!
    
    weak var delegate:CmDelegate?

    var heightMeasure = CGFloat()
        let oneInch:CGFloat = 40
        var middleMeasure = CGFloat()
       
        
        override func viewDidLoad() {
            super.viewDidLoad()
            self.navigationController?.navigationBar.isHidden = true
            setupCollectionView()
            setupCollectionViewLayout()
            calculculateMiddleMeasure()
           // let indexPath = IndexPath(item: 0, section: 12)
           // self.heightPickerView.scrollToItem(at:indexPath, at: .centeredHorizontally, animated: true)
            
        }
        
        
        private func calculculateMiddleMeasure(){
            let screenWidthHalf = (self.view.frame.width/2) - (oneInch/2)//one view size in storynoad is 15
            let numberOfBlocks = screenWidthHalf / oneInch
            middleMeasure = (numberOfBlocks/2)
          //  print(middleMeasure)
            heightMeasure = middleMeasure
            
            let str = String(format: "%.1f", middleMeasure)
            let array = str.components(separatedBy: ".")
           // print("\(array[0]) ,\(array[1])")
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
        


    }

    extension HeightCmViewController:UICollectionViewDataSource,UICollectionViewDelegate{
        
        
        func numberOfSections(in collectionView: UICollectionView) -> Int {
            return 300
            
        }
        
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return 2        }
        
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
//            if indexPath.row == 5{
//                cell.mView.isHidden = true
//                cell.mmView.isHidden = true
//                cell.pointFiveMmView.isHidden = false
//                 cell.HeightLbl.text = ""
//            }
            
            return cell
        }
         
        func scrollViewDidScroll(_ scrollView: UIScrollView) {
            let offset = scrollView.contentOffset.x
            heightMeasure = (offset/(oneInch * 2) + middleMeasure)
            
            let str = String(format: "%.1f", heightMeasure)
            let array = str.components(separatedBy: ".")
           // print("\(array[0]) ,\(array[1])")
            heightLbl.text = "\(array[0])' \(array[1])''"
            
           // print("currentPage \(heightMeasure.description)")
            delegate?.cmChanged(height: Int(heightMeasure))
        }
      
        func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
            //delegate?.cmChanged(height: Int(heightMeasure))
        }

        
        
}

