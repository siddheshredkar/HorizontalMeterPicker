//
//  MultiRulerViewController.swift
//  horizontalCustomPicker
//
//  Created by Siddhesh Redkar on 24/09/20.
//  Copyright © 2020 Siddhesh Redkar. All rights reserved.
//

import UIKit

class MultiRulerViewController: UIViewController {
    
    
    
    
    @IBOutlet weak var rulerCollectionView: UICollectionView!
    @IBOutlet weak var heightLbl: UILabel!
    
    var numberOfSection = Int()
    var numberOfRow = Int()
    var rowWidth = CGFloat()
    var indexNumber = Int()
    var sectionNumber = Int()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        numberOfRow = 12
        numberOfSection = 40
        rowWidth = 20
        setupCollectionView()
        setupCollectionViewLayout()
        calculculateMiddleMeasure()
        
        indexNumber = 4
        sectionNumber = 4
        self.rulerCollectionView.scrollToItem(at:IndexPath(item: indexNumber, section: sectionNumber), at: .right, animated: true)
        
        // Do any additional setup after loading the view.
    }
    
    private func calculculateMiddleMeasure(){
        let offsetX = 0
        let rulerW = self.rulerCollectionView.frame.width
        
        
        let halfRulerW = rulerW/2
        let halfRowW = rowWidth/2
        let middleOffsetvalue = halfRulerW + halfRowW //to calculate scaleMiddle measurement on screen ,substarcting halfRowW because staring part of scale
        
       // let requiredOffSetX = offsetX + middleOffsetvalue
        
        let totalWidthOfOneSection = rowWidth * CGFloat(numberOfRow)
        
        let measurement = middleOffsetvalue/totalWidthOfOneSection
        
        let measurementRound = String(format: "%.1f", measurement)
        
        let array = measurementRound.components(separatedBy: ".")
        
        let valueAfterDecimalPoint = measurement.fraction
        let pointMeasurement = valueAfterDecimalPoint * CGFloat(numberOfRow)
        
        let pointMeasurementRound = String(format: "%.0f", pointMeasurement)
        
        if pointMeasurementRound == "\(numberOfRow)"{
             heightLbl.text = "\(array[0])' \(11) ' '"
         }else{
             heightLbl.text = "\(array[0])' \(pointMeasurementRound) ' '"
         }
    }
    
    private func setupCollectionView(){
        self.rulerCollectionView.dataSource = self
        self.rulerCollectionView.delegate = self
    }
    
    private func setupCollectionViewLayout(){
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        flowLayout.itemSize = CGSize(width: rowWidth, height: 120)
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.minimumLineSpacing = 0
        self.rulerCollectionView.collectionViewLayout = flowLayout
    }
    
}


extension MultiRulerViewController:UICollectionViewDataSource,UICollectionViewDelegate{
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return numberOfSection
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberOfRow
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "heightCollectionViewCell", for: indexPath) as! heightCollectionViewCell
        
        switch indexPath.row {
        case 0:
            cell.mmView.isHidden = true
            cell.pointFiveMmView.isHidden = true
            cell.mView.isHidden = false
            cell.HeightLbl.text = "\(indexPath.section)"
        case numberOfRow/2:
            cell.mView.isHidden = true
            cell.mmView.isHidden = true
            cell.pointFiveMmView.isHidden = false
            cell.HeightLbl.text = ""
        default:
            cell.mView.isHidden = true
            cell.pointFiveMmView.isHidden = true
            cell.mmView.isHidden = false
            cell.HeightLbl.text = ""
        }
        
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let offsetX = scrollView.contentOffset.x
        let rulerW = self.rulerCollectionView.frame.width
        
        
        let halfRulerW = rulerW/2
        let halfRowW = rowWidth/2
        let middleOffsetvalue = halfRulerW - halfRowW //to calculate scaleMiddle measurement on screen ,substarcting halfRowW because staring part of scale
        
        let requiredOffSetX = offsetX + middleOffsetvalue
        
        let totalWidthOfOneSection = rowWidth * CGFloat(numberOfRow)
        
        let measurement = requiredOffSetX/totalWidthOfOneSection
        
        let measurementRound = String(format: "%.1f", measurement)
        
        let array = measurementRound.components(separatedBy: ".")
        
        let valueAfterDecimalPoint = measurement.fraction
        let pointMeasurement = valueAfterDecimalPoint * CGFloat(numberOfRow)
        
        let pointMeasurementRound = String(format: "%.0f", pointMeasurement)
        
        if pointMeasurementRound == "\(numberOfRow)"{
             heightLbl.text = "\(array[0])' \(11) ' '"
         }else{
             heightLbl.text = "\(array[0])' \(pointMeasurementRound) ' '"
         }

        
        // print("currentPage \(heightMeasure.description)")
    }
    
    
}



extension Decimal {
    func rounded(_ roundingMode: NSDecimalNumber.RoundingMode = .bankers) -> Decimal {
        var result = Decimal()
        var number = self
        NSDecimalRound(&result, &number, 0, roundingMode)
        return result
    }
    var whole: Decimal { self < 0 ? rounded(.up) : rounded(.down) }
    var fraction: Decimal { self - whole }
}

extension FloatingPoint {
    var whole: Self { modf(self).0 }
    var fraction: Self { modf(self).1 }
}
