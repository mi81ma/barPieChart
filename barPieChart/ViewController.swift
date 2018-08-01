//
//  ViewController.swift
//  barPieChart
//
//  Created by masato on 31/7/2018.
//  Copyright © 2018 masato. All rights reserved.
//

import UIKit
import Charts

class ViewController: UIViewController, ChartViewDelegate {
    
    weak var axisFormatDelegate: IAxisValueFormatter?
    
    @IBOutlet weak var lineChartView: LineChartView!
    @IBOutlet weak var pieChartView: PieChartView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        setChart()
        
    }
    

    
    func setChart() {
        
        
        // Input Data
        let months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun"]
        let unitsSold = [20.0, 4.0, 6.0, 3.0, 12.0, 16.0]
        
        
        // LineChart
        var lineChartEntries: [ChartDataEntry] = Array()
        
        for i in 0..<months.count {
            let lineChartEntry = ChartDataEntry(x: Double(i), y: unitsSold[i])
            lineChartEntries.append(lineChartEntry)
        }
        
        
        let lineChartDataSet = LineChartDataSet(values: lineChartEntries, label: "Units Sold")

        let lineChartData = LineChartData(dataSet: lineChartDataSet)
        lineChartView.data = lineChartData
        
        let xAxisValue = lineChartView.xAxis
        xAxisValue.valueFormatter = axisFormatDelegate
        
        // PieChart
        var pieEntries: [PieChartDataEntry] = Array()
        
        for i in 0..<months.count {
            let pieEntry = PieChartDataEntry(value: unitsSold[i], label: months[i])
            pieEntries.append(pieEntry)
        }
        
        
        let pieChartDataSet = PieChartDataSet(values: pieEntries, label: "\(months)")
        
        let pieChartData = PieChartData(dataSet: pieChartDataSet)
        pieChartView.data = pieChartData
        
        
        // PieChartColor
        var colors: [UIColor] = []
        
        for _ in 0..<months.count {
            let red = Double(arc4random_uniform(256))
            let green = Double(arc4random_uniform(256))
            let blue = Double(arc4random_uniform(256))
            
            let color = UIColor(red: CGFloat(red/255), green: CGFloat(green/255), blue: CGFloat(blue/255), alpha: 1)
            colors.append(color)
        }
        
        pieChartDataSet.colors = colors
        
    }
    
}

