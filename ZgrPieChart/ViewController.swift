//
//  ViewController.swift
//  ZgrPieChart
//
//  Created by Mac on 20.09.2020.
//

import UIKit

class ViewController: UIViewController {

    private var pieChart : ZgrPieChartView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.pieChart = ZgrPieChartView()
        self.view.addSubview(self.pieChart)
        
        self.pieChart.translatesAutoresizingMaskIntoConstraints = false
        self.pieChart.backgroundColor = .clear
        self.pieChart.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        self.pieChart.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.pieChart.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        self.pieChart.heightAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        
        self.pieChart.isRotateAnimate = true
        self.pieChart.pieChartItems = [
            ZgrPieChartItem(itemName: "Özgür", itemValue: 60 ,color: .red),
            ZgrPieChartItem(itemName: "Enes", itemValue: 40, color: .yellow),
            ZgrPieChartItem(itemName: "Other", itemValue: 20, color: .brown),
            ZgrPieChartItem(itemName: "Other_2", itemValue: 25, color: .blue)
        ]

        self.pieChart.drawChart()
    }


}

