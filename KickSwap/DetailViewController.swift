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

class DetailViewController: UIViewController, UIScrollViewDelegate {

    //@IBOutlet var shoeDetailImage: UIImageView!
    private var chart: Chart? // arc
    
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
    @IBOutlet var averagePriceLabel: UILabel!
    @IBOutlet var thanksLabel: UILabel!
    @IBOutlet var lineView: UIView!
    @IBOutlet var lineView2: UIView!
    @IBOutlet var lineView3: UIView!
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
        
        self.backgroundView.backgroundColor = detailBackgroundColor
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
        last5ValuesLabel.textColor = textColor
        last5ValuesLabel.font = RobotoFont.medium
        thanksLabel.textColor = textColor
        thanksLabel.font = RobotoFont.medium
        lineView.backgroundColor = palletteView1Color
        lineView2.backgroundColor = palletteView1Color
        lineView3.backgroundColor = palletteView1Color
    }
    
    
    
    func instantiateChart() {
        //let labelSettings = ChartLabelSettings(font: ExamplesDefaults.labelFont)
        
        //let chartPoints: [ChartPoint] = [(5, 105), (2, 110), (3, 95), (4, 90), (1, 80)].map{ChartPoint(x: ChartAxisValueDouble($0.0, labelSettings: labelSettings), y: ChartAxisValueDouble($0.1))}
        
        //let xValues = chartPoints.map{$0.x}
        //let yValues = ChartAxisValuesGenerator.generateYAxisValuesWithChartPoints(chartPoints, minSegmentCount: 10, maxSegmentCount: 20, multiple: 10, axisValueGenerator: {ChartAxisValueDouble($0, labelSettings: labelSettings)}, addPaddingSegmentIfEdge: false)
        
        //let lineModel = ChartLineModel(chartPoints: chartPoints, lineColor: palletteView2Color!, animDuration: 1, animDelay: 0)
        
        //let trendLineModel = ChartLineModel(chartPoints: TrendlineGenerator.trendline(chartPoints), lineColor: palletteView4Color!, animDuration: 0.5, animDelay: 1)
        
        //let xModel = ChartAxisModel(axisValues: xValues, axisTitleLabel: ChartAxisLabel(text: "Last 5 Values", settings: labelSettings))
        //let yModel = ChartAxisModel(axisValues: yValues, axisTitleLabel: ChartAxisLabel(text: "Value", settings: labelSettings.defaultVertical()))
        //let chartFrame = ExamplesDefaults.chartFrame(self.chartView.bounds)
        //let coordsSpace = ChartCoordsSpaceLeftBottomSingleAxis(chartSettings: ExamplesDefaults.chartSettings, chartFrame: chartFrame, xModel: xModel, yModel: yModel)
        //let (xAxis, yAxis, innerFrame) = (coordsSpace.xAxis, coordsSpace.yAxis, coordsSpace.chartInnerFrame)
        
        //let chartPointsLineLayer = ChartPointsLineLayer(xAxis: xAxis, yAxis: yAxis, innerFrame: innerFrame, lineModels: [lineModel])
        
        //let trendLineLayer = ChartPointsLineLayer(xAxis: xAxis, yAxis: yAxis, innerFrame: innerFrame, lineModels: [trendLineModel])
        
        //let settings = ChartGuideLinesDottedLayerSettings(linesColor: UIColor.blackColor(), linesWidth: ExamplesDefaults.guidelinesWidth)
        //let guidelinesLayer = ChartGuideLinesDottedLayer(xAxis: xAxis, yAxis: yAxis, innerFrame: innerFrame, settings: settings)
        
//        let chart = Chart(
//            frame: chartFrame,
//            layers: [
//                xAxis,
//                yAxis,
//                guidelinesLayer,
//                chartPointsLineLayer,
//                trendLineLayer
//            ]
//        )
        
        //self.chart = chart
        //self.chartSubview = chart.view
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
            setChart(Array(shoeValues.suffix(shoeBids.count)), values: newArray)
            animateChartView()
            animateChart = false
        }
    }
    
    func scrollViewDidScrollToTop(scrollView: UIScrollView) {
        
    }
    
    func animateChartView() {
//        UIView.animateWithDuration(2, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: [], animations: { () -> Void in
//            self.chartView.alpha = 1
//            }, completion: { (completed) -> Void in
//        })
        // Setup the animation
        //chartView.animationType = "SqueezeInLeft"
//        chartView.delay = 0.5
//        chartView.damping = 0.5
//        chartView.velocity = 2
//        chartView.force = 1
//        
//        self.chartView.addSubview(chartSubview!)
//        chartView.squeezeInRight()
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
        
        chartDataSet.colors = [UIColor(red: 230/255, green: 126/255, blue: 34/255, alpha: 1)]
        
        chartDataSet.colors = ChartColorTemplates.colorful()
        
        chartView.xAxis.labelPosition = .Bottom
        
        chartView.backgroundColor = UIColor(red: 189/255, green: 195/255, blue: 199/255, alpha: 1)
        
        chartView.animate(xAxisDuration: 2.0, yAxisDuration: 2.0)
        
        chartDataSet.circleRadius = 10
        
        chartDataSet.valueFont = chartDataSet.valueFont.fontWithSize(15)
        
        chartDataSet.valueFormatter?.currencySymbol
        chartDataSet.valueFormatter?.numberStyle = .CurrencyStyle
        chartView.drawGridBackgroundEnabled = false
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

