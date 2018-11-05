//
//  ViewController.swift
//  barPieChart
//
//  Created by masato on 31/7/2018.
//  Copyright © 2018 masato. All rights reserved.
//

import UIKit
import Charts

class ViewController: UIViewController {
    
    @IBOutlet weak var lineChartView: LineChartView!
    @IBOutlet weak var pieChartView: PieChartView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        let x = ["Jan", "Feb", "Mar", "Apr", "May", "Jun"]
        let y = [20.0, 4.0, 6.0, 3.0, 12.0, 16.0]
        
        setChart(month: x, Sold: y)
        
    }
    

    
    func setChart(month: Array<String>, Sold: Array<Double>) {
        
        
        // Input Data
        let unitsSold = Sold
        let months = month
        
        
        // LineChart
        var lineChartEntries: [ChartDataEntry] = Array()
        
        for i in 0..<months.count {
            let lineChartEntry = ChartDataEntry(x: Double(i), y: unitsSold[i])
            lineChartEntries.append(lineChartEntry)
        }
        
        
        let lineChartDataSet = LineChartDataSet(values: lineChartEntries, label: "Units Sold")

        let lineChartData = LineChartData(dataSet: lineChartDataSet)
        lineChartView.data = lineChartData
        
        
        // LineChartFormatterのインスタンスをつくる
        var foramtter = LineChartFormatter()
        // X軸の値をformatterのプロパティにセット
        foramtter.xAxisStringArray = month
        
        lineChartView.xAxis.valueFormatter = foramtter
    
        
        // x軸のラベルをボトムに表示
        lineChartView.xAxis.labelPosition = .bottom
        
        // LineChartの背景色
        lineChartView.backgroundColor = UIColor(red: 189/255, green: 195/255, blue: 199/255, alpha: 1)
        
        // PieChart
        var pieEntries: [PieChartDataEntry] = Array()
        
        for i in 0..<months.count {
            let pieEntry = PieChartDataEntry(value: unitsSold[i], label: months[i])
            pieEntries.append(pieEntry)
        }
        
        
        let pieChartDataSet = PieChartDataSet(values: pieEntries, label: "\(months)")
        
        let pieChartData = PieChartData(dataSet: pieChartDataSet)
        pieChartView.data = pieChartData
        
        
//// PieChartを真ん中まで塗りつぶす。Defaultではtrue
//   pieChartView.drawHoleEnabled = false
        
        // グラフの中央にテキストを表示
        pieChartView.centerText = "2018/4/1"
        
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
    
    class LineChartFormatter: NSObject, IAxisValueFormatter{
        // x軸のラベルの値を受け取るプロパティつくる。initializeされたときはnilがはいるようにオプショナル型にしておく
        var xAxisStringArray: [String]!
        
        // value[Double]で受け取る数値を、StringArrayでmappingするメソッド
        func stringForValue(_ value: Double, axis: AxisBase?) -> String {
            // 0 -> Jan, 1 -> Feb...
            return xAxisStringArray[Int(value)]
        }
    }
}

