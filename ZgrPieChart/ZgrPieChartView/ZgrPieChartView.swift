//
//  ZgrPieChartView.swift
//  ZgrPieChart
//
//  Created by Mac on 20.09.2020.
//

import Foundation
import UIKit



class ZgrPieChartView: UIView {
    override init(frame: CGRect) {super.init(frame: frame)}
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
    
    var pieChartItems : [ZgrPieChartItem]? = nil{
        didSet{
            self.calculateTotalValue()
            self.calculateAngles()
        }
    }
    var isFillColor : Bool = true
    var isRotateAnimate : Bool = false
    
    private var totalValue : CGFloat = 0.0
    
    private var currentAngle : CGFloat = -90.0
    private var angles : [CGFloat] = []
    
    private var timer : Timer?
    private var current_value : CGFloat = 0.0
    
    private var collectionViewFlowLayout : UICollectionViewFlowLayout!
    private var collectionView : UICollectionView!
    private var collectionIdentifier = "collectionViewCell"
    
    private var isDraw = false
    
    override func draw(_ rect: CGRect) {
        for item in self.angles.enumerated(){
            createChartItem(angle: item.element , color: self.pieChartItems![item.offset].color!)
            self.currentAngle += item.element
        }
        if !self.isDraw {
            self.setCollectionView()
            self.isDraw = true
        }
    }
    private func calculateTotalValue(){
        self.pieChartItems?.forEach({ (item) in
            self.totalValue += item.itemValue
        })
    }
    private func calculateAngles(){
        self.pieChartItems?.forEach({ (item) in
            let angle = (item.itemValue * 360) / self.totalValue
            self.angles.append(angle)
        })
    }
    
    private func createChartItem(angle : CGFloat , color : UIColor){
        let center = CGPoint(x: (self.bounds.width / 2.0) - 30, y: (self.bounds.height / 2.0))
        let _r = (self.bounds.width / 2.0) - 100
        let startAngle = (self.currentAngle / 180) * .pi
        let endAngle = ((angle + self.currentAngle) / 180) * .pi
        
        let bezierPath = UIBezierPath()
        bezierPath.move(to: center)
        bezierPath.addArc(withCenter: center, radius: _r, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        color.setFill()
        bezierPath.fill()
        bezierPath.close()
    }
    func drawChart(){
        self.draw(.zero)
        if self.isRotateAnimate == true {
            self.setAnimation()
        }
    }
    
    private func setCollectionView(){
        self.collectionViewFlowLayout = UICollectionViewFlowLayout()
        self.collectionViewFlowLayout.itemSize = CGSize(width: 130, height: 30)
        self.collectionViewFlowLayout.scrollDirection = .vertical
        self.collectionView = UICollectionView(frame: .zero, collectionViewLayout: self.collectionViewFlowLayout)
        self.collectionView.backgroundColor = .clear
        self.collectionView.register(ZGRPieChartCell.self, forCellWithReuseIdentifier: self.collectionIdentifier)
        self.collectionView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.collectionView)
        
        self.collectionView.rightAnchor.constraint(equalTo: self.rightAnchor , constant: -25).isActive = true
        self.collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        self.collectionView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        self.collectionView.heightAnchor.constraint(equalToConstant: CGFloat((self.pieChartItems!.count + 1)  * 35)).isActive = true
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
    }
    private func setAnimation(){
        self.rotation()
        self.scaleDown()
    }
    private func rotation(){
        let animation = CABasicAnimation(keyPath: "transform.rotation.z")
        animation.duration = 1.0
        animation.toValue = CGFloat.pi * 2.0
        animation.repeatCount = 1
        self.layer.add(animation, forKey: "rotationAnimation")
    }
    private func scaleDown(){
        let transformScale = CABasicAnimation(keyPath: "transform.scale")
        transformScale.fromValue = 0.5
        transformScale.toValue = 1.0
         transformScale.fillMode = CAMediaTimingFillMode.forwards
        transformScale.duration = 1.0
        self.layer.add(transformScale , forKey: "scaleAnimation")
    }
}
extension ZgrPieChartView : UICollectionViewDelegate , UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.pieChartItems!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.collectionIdentifier, for: indexPath) as? ZGRPieChartCell else {fatalError()}
        cell.setData(self.pieChartItems![indexPath.row].itemName, color: self.pieChartItems![indexPath.row].color!)
        return cell
    }
}

