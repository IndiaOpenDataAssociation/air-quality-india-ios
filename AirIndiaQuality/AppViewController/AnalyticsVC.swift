//
//  AnalyticsVC.swift
//  AirIndiaQuality
//
//  Created by Shivang Dave on 25/08/16.
//  Copyright © 2016 Shivang Dave. All rights reserved.
//

import UIKit

class AnalyticsCell : UICollectionViewCell
{
    @IBOutlet weak var lblValue : UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblSubTitle: UILabel!
    @IBOutlet weak var viewProgress: RPCircularProgress!
    
    @IBOutlet weak var backView : LetsView!
}

class AnalyticsVC: UIViewController,ChartViewDelegate, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var lblCityName : UILabel!

    @IBOutlet weak var chartView: BarChartView!
    @IBOutlet weak var lineChartView: LineChartView!
    @IBOutlet weak var controlSwitch: UISegmentedControl!
    
    @IBOutlet weak var lblAverageAQI : UILabel!
    @IBOutlet weak var collevtionView : UICollectionView!
    
    @IBOutlet var valueLabel: UILabel!
    @IBOutlet var markerView : UIView!
    
    var allDataArray = NSMutableArray()
    var dataArray = NSMutableArray()
    var monthArray = NSMutableArray()
    
    var bottomData = NSDictionary()
    
    var valueArray = NSMutableArray()
    var dictionary = NSDictionary()
    var switchFlag = false
    
    override func viewWillAppear(animated: Bool) {
        initActivityLoader("Assets All_Loader_Oizom", LableName: "LOADING", color: true)
        markerView.hidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.chartViewProperty(0)
        self.lineChartViewProperty(0)
        
        chartView.hidden = true
        
        lblCityName.text = appDelegate.city
        
        callWeekData()
        calcDays()
        calcHours()
    }
    
    override func viewWillDisappear(animated: Bool) {
        switchFlag = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func controlSegmentChanged(sender: AnyObject) {
        if controlSwitch.selectedSegmentIndex == 1
        {
            self.chartViewProperty(1)
            self.lineChartViewProperty(1)
        }
        else
        {
            self.chartViewProperty(0)
            self.lineChartViewProperty(0)
        }
    }
    
    @IBAction func btnChangeChartClicked(sender: UIButton) {
        
        markerView.hidden = true
        chartView.hidden = true
        lineChartView.hidden = true
        
        
        sender.selected = !sender.selected
        
        if sender.selected
        {
            chartView.hidden = false
        }
        else
        {
            lineChartView.hidden = false
        }
    }
    
    
    func chartViewProperty(x:Int)
    {
        markerView.hidden = true
        chartView.delegate = self;
        chartView.descriptionText = ""
        
        chartView.rightAxis.enabled = false
        chartView.leftAxis.enabled = true
        
        chartView.xAxis.enabled = true
        chartView.xAxis.labelPosition = .Bottom
        
        chartView.leftAxis.drawGridLinesEnabled = false
        chartView.rightAxis.drawGridLinesEnabled = false
        chartView.xAxis.drawGridLinesEnabled = false
        chartView.leftAxis.drawAxisLineEnabled = false
        chartView.xAxis.drawAxisLineEnabled = false
        
        chartView.dragEnabled = false
        chartView.setScaleEnabled(false)
        chartView.pinchZoomEnabled = false;
        chartView.drawBordersEnabled = false
        
        chartView.leftAxis._customAxisMax = true
        chartView.leftAxis._customAxisMin = true
        chartView.leftAxis.axisMinValue = 0
        chartView.leftAxis.axisMaxValue = 500
        
        chartView.legend.enabled = false
        chartView.gridBackgroundColor = UIColor.clearColor()
        chartView.drawGridBackgroundEnabled = false
        chartView.leftAxis.valueFormatter = NSNumberFormatter()
        chartView.leftAxis.valueFormatter?.minimumFractionDigits = 0
        chartView.backgroundColor = UIColor.clearColor()
        chartView.animate(xAxisDuration: 2.0, yAxisDuration: 2.0, easingOption: ChartEasingOption.EaseInOutBounce)
        
        if x != 0
        {
            if self.monthArray.count > 11
            {
                self.dictionary = allDataArray[0]["payload"]!?["d"] as! NSDictionary
                
                if allDataArray.count != 0
                {
                    let obj = NSMutableDictionary(dictionary: allDataArray[0]["payload"]!["d"] as! NSDictionary)
                    obj.removeObjectForKey("t")
                    
                    if obj.valueForKey("hum") != nil
                    {
                        let string : String = nf.stringFromNumber(obj.valueForKey("hum") as! NSNumber)!
                        NSNotificationCenter.defaultCenter().postNotificationName("hum", object: nil, userInfo: ["per":string])
                        obj.removeObjectForKey("hum")
                    }
                    
                    if obj.valueForKey("temp") != nil
                    {
                        let string : String = nf.stringFromNumber(obj.valueForKey("temp") as! NSNumber)!
                        NSNotificationCenter.defaultCenter().postNotificationName("temp", object: nil, userInfo: ["per":string])
                        obj.removeObjectForKey("temp")
                    }
                    
                    if obj.valueForKey("noise") != nil
                    {
                        obj.removeObjectForKey("noise")
                    }
                    
                    self.bottomData = obj
                    self.collevtionView.reloadData()
                }
                
                chartView.xAxis.setLabelsToSkip(0)
                
                self.setChart(calcDays(), values: self.monthArray)
            }
            else
            {
                if switchFlag
                {
                    showAlert("No daily/weekly data available")
                    NSTimer.scheduledTimerWithTimeInterval(2.0, target: self, selector: #selector(AnalyticsVC.goHome), userInfo: nil, repeats: false)
                }
            }
        }
        else
        {
            if self.dataArray.count > 6
            {
                self.dictionary = allDataArray[2]["payload"]!?["d"] as! NSDictionary
                
                if allDataArray.count != 0
                {
                    let obj = NSMutableDictionary(dictionary: allDataArray[2]["payload"]!["d"] as! NSDictionary)
                    obj.removeObjectForKey("t")
                    
                    if obj.valueForKey("hum") != nil
                    {
                        let string : String = nf.stringFromNumber(obj.valueForKey("hum") as! NSNumber)!
                        NSNotificationCenter.defaultCenter().postNotificationName("hum", object: nil, userInfo: ["per":string])
                        obj.removeObjectForKey("hum")
                    }
                    
                    if obj.valueForKey("temp") != nil
                    {
                        let string : String = nf.stringFromNumber(obj.valueForKey("temp") as! NSNumber)!
                        NSNotificationCenter.defaultCenter().postNotificationName("temp", object: nil, userInfo: ["per":string])
                        obj.removeObjectForKey("temp")
                    }
                    
                    if obj.valueForKey("noise") != nil
                    {
                        obj.removeObjectForKey("noise")
                    }
                    
                    self.bottomData = obj
                    self.collevtionView.reloadData()
                }
                
                if DeviceType.IS_IPHONE_5
                {
                    chartView.xAxis.setLabelsToSkip(2)
                }
                else if DeviceType.IS_IPHONE_6
                {
                    chartView.xAxis.setLabelsToSkip(1)
                }
                else if DeviceType.IS_IPHONE_6P
                {
                    chartView.xAxis.setLabelsToSkip(1)
                }
                
                self.setChart(calcHours(), values: self.dataArray)
            }
            else
            {
                if switchFlag
                {
                    showAlert("No daily/weekly data available")
                    NSTimer.scheduledTimerWithTimeInterval(2.0, target: self, selector: #selector(AnalyticsVC.goHome), userInfo: nil, repeats: false)
                }
            }
        }
    }
    
    func goHome()
    {
        appDelegate.goHome()
    }
    
    func lineChartViewProperty(x:Int)
    {
        markerView.hidden = true
        lineChartView.delegate = self;
        lineChartView.descriptionText = ""
        
        lineChartView.rightAxis.enabled = false
        lineChartView.leftAxis.enabled = true
        lineChartView.xAxis.enabled = true
        lineChartView.xAxis.labelPosition = .Bottom
        
        lineChartView.legend.enabled = false
        
        lineChartView.leftAxis.labelPosition = .InsideChart
        
        lineChartView.dragEnabled = true
        lineChartView.setScaleEnabled(false)
        lineChartView.pinchZoomEnabled = false
        
        lineChartView.drawBordersEnabled = false
        lineChartView.borderLineWidth = 2.0
        lineChartView.drawMarkers = false
        
        lineChartView.leftAxis.drawAxisLineEnabled = false
        lineChartView.xAxis.drawAxisLineEnabled = false
        lineChartView.rightAxis.drawGridLinesEnabled = false
        
        lineChartView.leftAxis._customAxisMax = true
        lineChartView.leftAxis._customAxisMin = true
        lineChartView.leftAxis.axisMinValue = 0
        lineChartView.leftAxis.axisMaxValue = 500
        lineChartView.leftAxis.valueFormatter = NSNumberFormatter()
        lineChartView.leftAxis.valueFormatter?.minimumFractionDigits = 0
        
        lineChartView.drawGridBackgroundEnabled = false
        
        lineChartView.leftAxis.drawGridLinesEnabled = true
        lineChartView.xAxis.drawGridLinesEnabled = true
        lineChartView.leftAxis.gridColor = UIColor(red: 170/255, green: 170/255, blue: 170/255, alpha: 0.2)
        lineChartView.xAxis.gridColor = UIColor(red: 170/255, green: 170/255, blue: 170/255, alpha: 0.2)
        
        lineChartView.backgroundColor = UIColor.clearColor()
        lineChartView.animate(xAxisDuration: 2.0, yAxisDuration: 2.0, easingOption: ChartEasingOption.EaseInOutBack)
        
        
        if x != 0
        {
            if self.monthArray.count > 11
            {
                if self.monthArray.count != 0
                {
                    
                    self.dictionary = allDataArray[0]["payload"]!?["d"] as! NSDictionary
                    
                    if allDataArray.count != 0
                    {
                        let obj = NSMutableDictionary(dictionary: allDataArray[0]["payload"]!["d"] as! NSDictionary)
                        obj.removeObjectForKey("t")
                        
                        if obj.valueForKey("hum") != nil
                        {
                            let string : String = nf.stringFromNumber(obj.valueForKey("hum") as! NSNumber)!
                            NSNotificationCenter.defaultCenter().postNotificationName("hum", object: nil, userInfo: ["per":string])
                            obj.removeObjectForKey("hum")
                        }
                        
                        if obj.valueForKey("temp") != nil
                        {
                            let string : String = nf.stringFromNumber(obj.valueForKey("temp") as! NSNumber)!
                            NSNotificationCenter.defaultCenter().postNotificationName("temp", object: nil, userInfo: ["per":string])
                            obj.removeObjectForKey("temp")
                        }
                        
                        if obj.valueForKey("noise") != nil
                        {
                            obj.removeObjectForKey("noise")
                        }
                        
                        self.bottomData = obj
                        self.collevtionView.reloadData()
                    }
                lineChartView.xAxis.setLabelsToSkip(0)
                self.setLineChart(calcDays(), values: self.monthArray)
                }
            }
            else
            {
                if switchFlag
                {
                    showAlert("No daily/weekly data available")
                    NSTimer.scheduledTimerWithTimeInterval(2.0, target: self, selector: #selector(AnalyticsVC.goHome), userInfo: nil, repeats: false)
                }
            }
        }
        else
        {
            if self.dataArray.count > 6
            {
                if self.dataArray.count != 0
                {
                    self.dictionary = allDataArray[2]["payload"]!?["d"] as! NSDictionary
                    
                    if allDataArray.count != 0
                    {
                        let obj = NSMutableDictionary(dictionary: allDataArray[2]["payload"]!["d"] as! NSDictionary)
                        obj.removeObjectForKey("t")
                        
                        if obj.valueForKey("hum") != nil
                        {
                            let string : String = nf.stringFromNumber(obj.valueForKey("hum") as! NSNumber)!
                            NSNotificationCenter.defaultCenter().postNotificationName("hum", object: nil, userInfo: ["per":string])
                            obj.removeObjectForKey("hum")
                        }
                        
                        if obj.valueForKey("temp") != nil
                        {
                            let string : String = nf.stringFromNumber(obj.valueForKey("temp") as! NSNumber)!
                            NSNotificationCenter.defaultCenter().postNotificationName("temp", object: nil, userInfo: ["per":string])
                            obj.removeObjectForKey("temp")
                        }
                        
                        if obj.valueForKey("noise") != nil
                        {
                            obj.removeObjectForKey("noise")
                        }
                        
                        self.bottomData = obj
                        self.collevtionView.reloadData()
                    }
                    
                    if DeviceType.IS_IPHONE_5
                    {
                        lineChartView.xAxis.setLabelsToSkip(2)
                    }
                    else if DeviceType.IS_IPHONE_6
                    {
                        lineChartView.xAxis.setLabelsToSkip(1)
                    }
                    else if DeviceType.IS_IPHONE_6P
                    {
                        lineChartView.xAxis.setLabelsToSkip(1)
                    }
                    
                    self.setLineChart(calcHours(), values: self.dataArray)
                }
            }
            else
            {
                if switchFlag
                {
                    showAlert("No daily/weekly data available")
                    NSTimer.scheduledTimerWithTimeInterval(2.0, target: self, selector: #selector(AnalyticsVC.goHome), userInfo: nil, repeats: false)
                }
            }
        }
        
    }
    
    func setChart(dataPoints: [String], values: NSMutableArray) {
        chartView.noDataText = "No data available at the moment!"
        
        var dataEntries: [BarChartDataEntry] = []
        let avgArray = NSMutableArray()
        
        for i in 0..<dataPoints.count {
            avgArray.addObject(values[i])
            let dataEntry = BarChartDataEntry(value: values[i] as! Double, xIndex: i)
            dataEntries.append(dataEntry)
        }
        
        lblAverageAQI.text = String(format: "%0.0f",average(avgArray))
        
        //let colors: [UIColor] = [UIColor.greenChartColor()]
        let colors = [UIColor(red: 93/255, green: 174/255, blue: 85/255, alpha: 1.0)]
        
        let chartDataSet = BarChartDataSet(yVals: dataEntries, label: "")
        chartDataSet.barSpace = 0.05
        chartDataSet.colors = colors
        chartDataSet.valueTextColor = UIColor.clearColor()
        chartDataSet.highlightLineWidth = 0.0
        
        let chartData = BarChartData(xVals: dataPoints, dataSet: chartDataSet)
        let fnt: UIFont = UIFont(name: "Helvetica", size: 13.0)!
        chartData.setValueFont(fnt)
        chartView.data = chartData
        
    }
    
    func setLineChart(dataPoints: [String], values: NSMutableArray) {
        lineChartView.noDataText = "No data available at the moment!"
        
        var dataEntries: [ChartDataEntry] = []
        let avgArray = NSMutableArray()
        
        for i in 0..<dataPoints.count {
            avgArray.addObject(values[i])
            let dataEntry = ChartDataEntry(value: values[i] as! Double, xIndex: i)
            dataEntries.append(dataEntry)
        }
        
        lblAverageAQI.text = String(format: "%0.0f",average(avgArray))
        
        //let colors: [UIColor] = [UIColor.greenChartColor()]
        let colors = [UIColor(red: 93/255, green: 174/255, blue: 85/255, alpha: 1.0)]
        
        let chartDataSet = LineChartDataSet(yVals: dataEntries, label: "")
        chartDataSet.colors = colors
        chartDataSet.drawCirclesEnabled = false
        chartDataSet.mode = .CubicBezier
        chartDataSet.highlightLineWidth = 0.0
        //chartDataSet.drawCubicEnabled = true
        //        chartDataSet.fillColor = UIColor(red: 93/255, green: 174/255, blue: 85/255, alpha: 1.0)
        //        chartDataSet.fillAlpha = 1.0
        
        let gradColors = [UIColor(red: 93/255, green: 174/255, blue: 85/255, alpha: 0.2).CGColor,UIColor(red: 93/255, green: 174/255, blue: 85/255, alpha: 1.0).CGColor]
        let colorLocations:[CGFloat] = [0.0, 1.0]
        
        if let gradient = CGGradientCreateWithColors(CGColorSpaceCreateDeviceRGB(), gradColors, colorLocations) {
            chartDataSet.fill = ChartFill(linearGradient: gradient, angle: 90.0)
            chartDataSet.drawFilledEnabled = true
            chartDataSet.drawValuesEnabled = false
        }

        
        let chartData = LineChartData(xVals: dataPoints, dataSet: chartDataSet)
        let fnt: UIFont = UIFont(name: "Helvetica", size: 9.0)!
        chartData.setValueFont(fnt)
        lineChartView.data = chartData
        
    }
    
    func chartValueSelected(chartView: ChartViewBase, entry: ChartDataEntry, dataSetIndex: Int, highlight: ChartHighlight) {
        
        let markerPosition = chartView.getMarkerPosition(entry: entry,  highlight: highlight)

        //print(entry.value)
        markerView.hidden = false
        valueLabel.text = String(format:"%0.0f",entry.value)
        markerView.center = CGPointMake(markerPosition.x, markerPosition.y-25)
    }
    
    func chartValueNothingSelected(chartView: ChartViewBase) {
        markerView.hidden = true
    }
    
    func average(nums: NSMutableArray) -> Double {
        
        var total = 0.0
        
        for vote in nums{
            
            total += Double(vote as! NSNumber)
            
        }
        
        let votesTotal = Double(nums.count)
        let average = total/votesTotal
        return average
    }
}


extension AnalyticsVC
{
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var x = 0
        if allDataArray.count != 0
        {
            x = self.bottomData.count
        }
        return x
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell  = collectionView.dequeueReusableCellWithReuseIdentifier("AnalyticsCell", forIndexPath: indexPath) as! AnalyticsCell
        
        let array = bottomData.allKeys as! [String]
        
        cell.viewProgress.clockwiseProgress = true
        cell.viewProgress.progressTintColor = UIColor(red: 93/255, green: 174/255, blue: 85/255, alpha: 1.0)
        if dictionary.valueForKey(array[indexPath.row]) != nil
        {
            let temp = array[indexPath.row]
            switch temp {
            case "co":
                cell.lblTitle.text = "CO"
                cell.lblSubTitle.text = "mg/m3"
                break
            case "no2":
                cell.lblTitle.text = "NO2"
                cell.lblSubTitle.text = "PPM"
                break
            case "pm10":
                cell.lblTitle.text = "PM1.0"
                cell.lblSubTitle.text = "ug/m3"
                break
            case "pm25":
                cell.lblTitle.text = "PM2.5"
                cell.lblSubTitle.text = "ug/m3"
                break
            case "so2":
                cell.lblTitle.text = "SO2"
                cell.lblSubTitle.text = "PPM"
                break
            case "p1":
                cell.lblTitle.text = "PM2.5"
                cell.lblSubTitle.text = "ug/m3"
                break
            case "g1":
                cell.lblTitle.text = "CO2"
                cell.lblSubTitle.text = "PPM"
                break
            case "g4":
                cell.lblTitle.text = "NH3"
                cell.lblSubTitle.text = "ug/m3"
                break
            case "p2":
                cell.lblTitle.text = "PM1.0"
                cell.lblSubTitle.text = "ug/m3"
                break
            case "g3":
                cell.lblTitle.text = "NO2"
                cell.lblSubTitle.text = "ug/m3"
                break
            case "g14":
                cell.lblTitle.text = "aeSO2"
                cell.lblSubTitle.text = "ug/m3"
                break
            case "o3":
                cell.lblTitle.text = "O3"
                cell.lblSubTitle.text = "ug/m3"
                break
            case "g6":
                cell.lblTitle.text = "H2S"
                cell.lblSubTitle.text = "ug/m3"
                break
            case "g2":
                cell.lblTitle.text = "CO"
                cell.lblSubTitle.text = "mg/m3"
                break
            case "g18":
                cell.lblTitle.text = "aeH2S"
                cell.lblSubTitle.text = "ug/m3"
                break
            case "g5":
                cell.lblTitle.text = "O3"
                cell.lblSubTitle.text = "ug/m3"
                break
            case "g15":
                cell.lblTitle.text = "weOX"
                cell.lblSubTitle.text = "ug/m3"
                break
            case "g8":
                cell.lblTitle.text = "SO2"
                cell.lblSubTitle.text = "ug/m3"
                break
            case "g9":
                cell.lblTitle.text = "sCO"
                cell.lblSubTitle.text = "mg/m3"
                break
            case "p3":
                cell.lblTitle.text = "PM1"
                cell.lblSubTitle.text = "ug/m3"
                break
            case "g7":
                cell.lblTitle.text = "NO2"
                cell.lblSubTitle.text = "ug/m3"
                break
            case "g17":
                cell.lblTitle.text = "weH2S"
                cell.lblSubTitle.text = "ug/m3"
                break
            case "g13":
                cell.lblTitle.text = "weSO2"
                cell.lblSubTitle.text = "ug/m3"
                break
            case "g16":
                cell.lblTitle.text = "aeOX"
                cell.lblSubTitle.text = "ug/m3"
                break
            case "g22":
                cell.lblTitle.text = "atNO2"
                cell.lblSubTitle.text = "PPB"
                break
            case "g10":
                cell.lblTitle.text = "VOC"
                cell.lblSubTitle.text = "PPM"
                break
            case "g20":
                cell.lblTitle.text = "aeCO"
                cell.lblSubTitle.text = "PPB"
                break
            case "g19":
                cell.lblTitle.text = "weCO"
                cell.lblSubTitle.text = "ug/m3"
                break
            case "g21":
                cell.lblTitle.text = "tNO2"
                cell.lblSubTitle.text = "ug/m3"
                break
            case "g28":
                cell.lblTitle.text = "HC"
                cell.lblSubTitle.text = "PPM"
                break
            case "g25":
                cell.lblTitle.text = "tO3"
                cell.lblSubTitle.text = "PPB"
                break
            case "g11":
                cell.lblTitle.text = "weNO2"
                cell.lblSubTitle.text = "ug/m3"
                break
            case "g26":
                cell.lblTitle.text = "atO3"
                cell.lblSubTitle.text = "PPB"
                break
            case "g27":
                cell.lblTitle.text = "tSO2"
                cell.lblSubTitle.text = "PPB"
                break
            case "g35":
                cell.lblTitle.text = "atSO2"
                cell.lblSubTitle.text = "PPB"
                break
            case "g23":
                cell.lblTitle.text = "tCO"
                cell.lblSubTitle.text = "PPB"
                break
            case "g12":
                cell.lblTitle.text = "aeNO2"
                cell.lblSubTitle.text = "ug/m3"
                break
            case "g29":
                cell.lblTitle.text = "tH2S"
                cell.lblSubTitle.text = "PPB"
                break
            case "g24":
                cell.lblTitle.text = "atCO"
                cell.lblSubTitle.text = "PPB"
                break
            case "g30":
                cell.lblTitle.text = "atH2S"
                cell.lblSubTitle.text = "PPB"
                break
            default:
                cell.lblTitle.text = "Unknown"
                cell.lblSubTitle.text = "N/A"
                break
            }
            print(dictionary)
            print(array)
            
            if dictionary.valueForKey(array[indexPath.row]) is NSString
            {
                let x = CGFloat((nf.numberFromString((dictionary.valueForKey(array[indexPath.row]) as? String)!)?.floatValue)! / 500.0)
                //let x = CGFloat((dictionary.valueForKey(array[indexPath.row]) as? NSString)!.floatValue / 500.0)
                
                if dictionary.valueForKey(temp) is NSString
                {
                    cell.lblValue.text = String(format: "%0.f",(nf.numberFromString((dictionary.valueForKey(temp) as? String)!))!.floatValue)
                    cell.backView.bounds.size.height = cell.viewProgress.bounds.size.height
                    cell.backView.bounds.size.width = cell.viewProgress.bounds.size.width
                    if DeviceType.IS_IPHONE_5
                    {
                        cell.backView.cornerRadius = 27.5
                    }
                    else if DeviceType.IS_IPHONE_6
                    {
                        cell.backView.cornerRadius = 32.0
                    }
                    else if DeviceType.IS_IPHONE_6P
                    {
                        cell.backView.cornerRadius = 32.1666666666667
                    }
                    cell.viewProgress.updateProgress(x)
                }
                else
                {
                    cell.lblValue.text = String(format: "%0.f",(dictionary.valueForKey(temp) as? NSNumber)!.floatValue)
                    cell.backView.bounds.size.height = cell.viewProgress.bounds.size.height
                    cell.backView.bounds.size.width = cell.viewProgress.bounds.size.width
                    if DeviceType.IS_IPHONE_5
                    {
                        cell.backView.cornerRadius = 27.5
                    }
                    else if DeviceType.IS_IPHONE_6
                    {
                        cell.backView.cornerRadius = 32.0
                    }
                    else if DeviceType.IS_IPHONE_6P
                    {
                        cell.backView.cornerRadius = 32.1666666666667
                    }
                    cell.viewProgress.updateProgress(x)
                }
            }
            else
            {
                let x = CGFloat((dictionary.valueForKey(array[indexPath.row]) as? NSNumber)!.floatValue / 500.0)
                cell.lblValue.text = String(format: "%0.f",(dictionary.valueForKey(temp) as? NSNumber)!.floatValue)
                cell.backView.bounds.size.height = cell.viewProgress.bounds.size.height
                cell.backView.bounds.size.width = cell.viewProgress.bounds.size.width
                if DeviceType.IS_IPHONE_5
                {
                    cell.backView.cornerRadius = 27.5
                }
                else if DeviceType.IS_IPHONE_6
                {
                    cell.backView.cornerRadius = 32.0
                }
                else if DeviceType.IS_IPHONE_6P
                {
                    cell.backView.cornerRadius = 32.1666666666667
                }
                cell.viewProgress.updateProgress(x)
            }
        }
        else
        {
            cell.lblValue.text = "N/A"
            cell.viewProgress.updateProgress(0.0)
        }
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        return CGSize(width: ScreenSize.SCREEN_WIDTH/4.5, height: 100.0);
        
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
    }
}
