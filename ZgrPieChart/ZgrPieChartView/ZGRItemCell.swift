//
//  ZGRItemCell.swift
//  ZgrPieChart
//
//  Created by Mac on 23.09.2020.
//

import Foundation
import UIKit
class ZGRPieChartCell: UICollectionViewCell {
    private var colorView : UIView!
    private var chartName : UILabel!
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
        self.setColorView()
        self.setChartLabel()
    }
    private func setColorView(){
        self.colorView = UIView()
        self.colorView.backgroundColor = .clear
        
        self.addSubview(self.colorView)
        
        self.colorView.translatesAutoresizingMaskIntoConstraints = false
        self.colorView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        self.colorView.leftAnchor.constraint(equalTo: self.leftAnchor , constant: 5).isActive = true
        self.colorView.heightAnchor.constraint(equalTo: self.heightAnchor , multiplier: 0.8).isActive = true
        self.colorView.widthAnchor.constraint(equalTo: self.widthAnchor , multiplier: 0.2).isActive = true
    }
    private func setChartLabel(){
        self.chartName = UILabel()
        self.chartName.backgroundColor = .clear
        self.chartName.textColor = .black
        self.chartName.textAlignment = .left
        self.addSubview(self.chartName)
        
        self.chartName.translatesAutoresizingMaskIntoConstraints = false
        self.chartName.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        self.chartName.leftAnchor.constraint(equalTo: self.colorView.rightAnchor , constant: 5).isActive = true
        self.chartName.heightAnchor.constraint(equalTo: self.heightAnchor , multiplier: 1.0).isActive = true
        self.chartName.widthAnchor.constraint(equalTo: self.widthAnchor , multiplier: 0.8).isActive = true
    }
    func setData(_ text : String , color : UIColor){
        self.chartName.text = text
        self.colorView.backgroundColor = color
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
