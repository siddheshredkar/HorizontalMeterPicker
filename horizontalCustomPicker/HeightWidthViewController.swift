//
//  HeightWidthViewController.swift
//  horizontalCustomPicker
//
//  Created by Siddhesh Redkar on 27/08/20.
//  Copyright © 2020 Siddhesh Redkar. All rights reserved.
//

import UIKit

class HeightWidthViewController: UIViewController {
    
    
    @IBOutlet weak var heightPickerView: UICollectionView!
    @IBOutlet weak var heightLbl: UILabel!
    
    var heightMeasure = CGFloat()
    let oneInch:CGFloat = 15
    var middleMeasure = CGFloat()
    weak var delegate:setMeasure?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        setupCollectionView()
        setupCollectionViewLayout()
        calculculateMiddleMeasure()
        
    }
    
    
    private func calculculateMiddleMeasure(){
        let screenWidthHalf = self.heightPickerView.frame.width/2
        let numberOfBlocks = screenWidthHalf / oneInch
        middleMeasure = (numberOfBlocks/10) - 0.2
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

extension HeightWidthViewController:UICollectionViewDataSource,UICollectionViewDelegate{
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 100
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "heightCollectionViewCell", for: indexPath) as! heightCollectionViewCell
        let center = self.view.convert(collectionView.center, to: collectionView)
        let index = collectionView.indexPathForItem(at: center)
        print(index)
        
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
        if indexPath.row == 5{
            cell.mView.isHidden = true
            cell.mmView.isHidden = true
            cell.pointFiveMmView.isHidden = false
             cell.HeightLbl.text = ""
        }
        
        return cell
    }
     
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset.x
        heightMeasure = offset/150 + middleMeasure
        
        let str = String(format: "%.1f", heightMeasure)
        let array = str.components(separatedBy: ".")
        print("\(array[0]) ,\(array[1])")
        heightLbl.text = "\(array[0])' \(array[1])''"
        
        print("currentPage \(heightMeasure.description)")
    }
    
  
      
}
