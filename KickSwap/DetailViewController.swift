//
//  DetailViewController.swift
//  KickSwap
//
//  Created by Brandon Sanchez on 3/13/16.
//  Copyright © 2016 Hugh A. Miles II. All rights reserved.
//

import UIKit
import SwiftCharts
import IBAnimatable
import Charts
import Material
import ChameleonFramework

class DetailViewController: UIViewController, UIScrollViewDelegate, ChartViewDelegate {

    //@IBOutlet var shoeDetailImage: UIImageView!
    //private var chart: Chart? // arc
    
    @IBOutlet var chartViewCardViewBackground: CardView!
    @IBOutlet var shoeImageCardView: CardView!
    @IBOutlet var shoeDetailsCardView: CardView!
    @IBOutlet var chartView: LineChartView!
    @IBOutlet var scrollView: UIScrollView!
    var animateChart: Bool = true
    var chartSubview: UIView? = nil
    @IBOutlet var shoeNameLabel: UILabel!
    @IBOutlet var shoeImage: UIImageView!
    @IBOutlet var shoeSizeLabel: UILabel!
    @IBOutlet var shoeConditionLabel: UILabel!
    @IBOutlet var conditionPlaceholderLabel: UILabel!
    @IBOutlet var sizePlaceholderLabel: UILabel!
    @IBOutlet var averagePlaceholderLabel: UILabel!
    @IBOutlet var last5ValuesLabel: UILabel!
    @IBOutlet var averagePriceLabel: AnimatableLabel!
    @IBOutlet var thanksLabel: UILabel!
    @IBOutlet var backgroundView: AnimatableView!
    
    @IBOutlet var noDataLabel: UILabel!
    var visibleShoe: Shoe?
    var visibleUser: User?
    var shoeBids = [Double]()
    let shoeValues = ["5", "4", "3", "2", "1"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        scrollView.delegate = self
        scrollView.bounces = false
//        shoeNameLabel.layer.cornerRadius = 4
//        shoeNameLabel.layer.shadowOffset = CGSize(width: 3, height: 10)
//        shoeNameLabel.layer.shadowColor = UIColor.flatBlackColor().CGColor
//        shoeNameLabel.layer.shadowOpacity = 1
        //layoutView()
        //instantiateChart()
        
        
        //animateChart = true
      
        
    //chartView.setTranslatesAutoresizingMaskIntoConstraints(false)
//        chartSubview.addConstraint(NSLayoutConstraint(item: chartView, attribute: .Top, relatedBy: .Equal, toItem: view, attribute: .Top, multiplier: 1.0, constant: 0.0))
//        chartSubview.addConstraint(NSLayoutConstraint(item: chartView, attribute: .Leading, relatedBy: .Equal, toItem: view, attribute: .Leading, multiplier: 1.0, constant: 0.0))
//        chartSubview.addConstraint(NSLayoutConstraint(item: self, attribute: .Bottom, relatedBy: .Equal, toItem: chartView, attribute: .Bottom, multiplier: 1.0, constant: 0.0))
//        chartSubview.addConstraint(NSLayoutConstraint(item: chartView, attribute: .Trailing, relatedBy: .Equal, toItem: chartView, attribute: .Trailing, multiplier: 1.0, constant: 0.0))
        //self.chartView.addSubview(chartSubview)
        
        //self.chartView.alpha = 0
//        if animateChart == true {
//            animateChartView()
//        }
        
    }
    
    func layoutView() {
        
        let text = UIColor.flatWhiteColorDark()
        
        self.backgroundView.backgroundColor = palletteView5Color
        self.shoeNameLabel.textColor = textColor
        self.shoeNameLabel.font = RobotoFont.medium
        shoeImage.clipsToBounds = true
        shoeImage.layer.borderWidth = 5
        shoeImage.layer.cornerRadius = 4
        shoeImage.layer.borderColor = UIColor.flatBlackColorDark().CGColor
        shoeSizeLabel.textColor = textColor
        shoeSizeLabel.font = RobotoFont.medium
        shoeConditionLabel.textColor = textColor
        shoeConditionLabel.font = RobotoFont.medium
        conditionPlaceholderLabel.textColor = textColor
        conditionPlaceholderLabel.font = RobotoFont.medium
        sizePlaceholderLabel.textColor = textColor
        sizePlaceholderLabel.font = RobotoFont.medium
        averagePriceLabel.textColor = textColor
        averagePriceLabel.font = RobotoFont.medium
        averagePriceLabel.alpha = 0
        averagePlaceholderLabel.font = RobotoFont.medium
        averagePlaceholderLabel.textColor = textColor
        last5ValuesLabel.textColor = textColor
        last5ValuesLabel.font = RobotoFont.medium
        thanksLabel.textColor = textColor
        thanksLabel.font = RobotoFont.medium
        chartView.layer.cornerRadius = 4
        shoeImageCardView.backgroundColor = GradientColor(UIGradientStyle.TopToBottom, frame: shoeImageCardView.frame, colors: [palletteView1Color!, palletteView2Color!])//palletteView2Color
        shoeDetailsCardView.backgroundColor = palletteView1Color//GradientColor(UIGradientStyle.TopToBottom, frame: shoeDetailsCardView.frame, colors: [palletteView2Color!, palletteView1Color!])//palletteView1Color
        chartViewCardViewBackground.backgroundColor = GradientColor(UIGradientStyle.TopToBottom, frame: chartViewCardViewBackground.frame, colors: [palletteView2Color!, palletteView1Color!])//detailBackgroundColor
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        layoutView()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func KSTimeline() -> KSTimelineViewController {
        let pagingmenucontroller = self.parentViewController
        //print(pagingmenucontroller?.parentViewController)
        let kstimeline = pagingmenucontroller?.parentViewController as! KSTimelineViewController
        return kstimeline
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    let chartConfig = ChartConfigXY(
//        xAxisConfig: ChartAxisConfig(from: 2, to: 14, by: 2),
//        yAxisConfig: ChartAxisConfig(from: 0, to: 14, by: 2)
//    )
//    
//    let chart = LineChart(
//        frame: CGRectMake(0, 70, 300, 500),
//        chartConfig: chartConfig,
//        xTitle: "X axis",
//        yTitle: "Y axis",
//        lines: [
//            (chartPoints: [(2.0, 10.6), (4.2, 5.1), (7.3, 3.0), (8.1, 5.5), (14.0, 8.0)], color: UIColor.redColor()),
//            (chartPoints: [(2.0, 2.6), (4.2, 4.1), (7.3, 1.0), (8.1, 11.5), (14.0, 3.0)], color: UIColor.blueColor())
//        ]
//    )
//    
//    self.view.addSubview(chart.view)

    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
    }

    func scrollViewWillBeginDecelerating(scrollView: UIScrollView) {
        if (scrollView.contentOffset.y + scrollView.frame.size.height) >= self.view.frame.height / 2{
            
//            let newArray = (visibleShoe?.bids)! as [Double]
//            
//            if animateChart == true {
//                setChart(Array(shoeValues.suffix(newArray.count)), values: newArray)
//                animateChartView()
//                animateChart = false
//            }
        }
        
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
        // needed to add to shoebids
        let newArray = (visibleShoe?.bids)! as [Double]
        shoeBids += newArray
        
        print(newArray)
        if animateChart == true {
            print(String((visibleShoe?.bids?.average)!))
            
            // Calculatin & Printing Average Bids
            let formatter = NSNumberFormatter()
            formatter.numberStyle = .CurrencyStyle
            let averagePrice = formatter.stringFromNumber((visibleShoe?.bids?.average)!)
            averagePriceLabel.text = averagePrice
            averagePriceLabel.alpha = 0
            averagePriceLabel.squeezeInRight()
            
            //Setting Chart
            setChart(Array(shoeValues.suffix(shoeBids.count)), values: newArray)
            animateChart = false
        }
    }
    
    func scrollViewDidScrollToTop(scrollView: UIScrollView) {
        
    }
    
    func loadPage() {
       
        if let indexPath = KSTimeline().mainCollectionViewCellIndexPath?.row {
        visibleShoe = KSTimeline().shoeTimeline![indexPath]
        shoeNameLabel.text = visibleShoe!.name
        shoeImage.image = KSTimeline().shoeTimeline![indexPath].shoeImage
        shoeSizeLabel.text = KSTimeline().shoeTimeline![indexPath].size
        shoeConditionLabel.text = KSTimeline().shoeTimeline![indexPath].condition
        } else {
            visibleShoe = KSTimeline().shoeTimeline![0]
            shoeNameLabel.text = visibleShoe!.name
            shoeImage.image = KSTimeline().shoeTimeline![0].shoeImage
            shoeSizeLabel.text = KSTimeline().shoeTimeline![0].size
            shoeConditionLabel.text = KSTimeline().shoeTimeline![0].condition
        }
        
        visibleShoe?.getBids() //set user bid object for graphs
    }
    
    func setChart(dataPoints: [String], values: [Double]) {
        
        var dataEntries: [ChartDataEntry] = []
        
        for i in 0..<dataPoints.count {
            let dataEntry = ChartDataEntry(value: values[i], xIndex: i)
            dataEntries.append(dataEntry)
        }
        
        let chartDataSet = LineChartDataSet(yVals: dataEntries, label: "Values")
        let chartData = LineChartData(xVals: shoeValues, dataSet: chartDataSet)
        chartView.data = chartData
        
        //Placeholder text if data is nil
        if chartView.data == nil {
            chartView.noDataText = ""
            noDataLabel.text = "No one's gotten around to valuing these kicks. Be a nice guy and value them."
            noDataLabel.textAlignment = .Center
            noDataLabel.textColor = UIColor.orangeColor()
        } else {
            noDataLabel.text = ""
            noDataLabel.backgroundColor = UIColor.clearColor()
        }
        
        //Description of chart
        chartView.descriptionText = "Shoe Value"
        
        chartDataSet.colors = [UIColor.redColor()]//Style.chartTheme() //[UIColor(red: 230/255, green: 126/255, blue: 34/255, alpha: 1)]
        
        chartDataSet.colors = Style.chartTheme()
        
        chartView.xAxis.labelPosition = .Bottom
        
        chartView.backgroundColor = palletteView5Color //UIColor(red: 189/255, green: 195/255, blue: 199/255, alpha: 1)
        
        chartView.animate(xAxisDuration: 2.0, yAxisDuration: 2.0)
        
        chartDataSet.circleRadius = 10
        chartDataSet.circleColors = [palletteView2Color!]
        chartDataSet.circleHoleColor = palletteView1Color!
        chartDataSet.valueTextColor = palletteView1Color!
        
        chartDataSet.valueFont = chartDataSet.valueFont.fontWithSize(15)
        
        chartDataSet.valueFormatter?.currencySymbol
        chartDataSet.valueFormatter?.numberStyle = .CurrencyStyle
        chartView.drawGridBackgroundEnabled = false
        chartView.pinchZoomEnabled = false
        chartView.legend.enabled = false
        chartView.layer.cornerRadius = 4
        //chartView.gridBackgroundColor = UIColor.clearColor()
        chartView.xAxis.labelFont.fontWithSize(15)
        chartView.chartYMax.advancedBy(100)
        chartView.leftAxis.calcMinMax(min: shoeBids.minElement()! - 20, max: shoeBids.maxElement()! + 50)
        
        //chartDataSet.drawVerticalHighlightIndicatorEnabled = false
    }




    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension _ArrayType where Generator.Element == Double {
    var total: Double {
        guard !isEmpty else { return 0 }
        return  reduce(0, combine: +)
    }
    var average: Double {
        guard !isEmpty else { return 0 }
        return  total / Double(count)
    }
}

