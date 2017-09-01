//
//  AddCityMapVC.swift
//  AirIndiaQuality
//
//  Created by Shivang Dave on 25/08/16.
//  Copyright © 2016 Shivang Dave. All rights reserved.
//

import UIKit
import MapKit

class CityListCell: UITableViewCell {
    @IBOutlet weak var lblTitle: UILabel!
}

class CustomPointAnnotation: MKPointAnnotation {
    var imageName: String!
    var aqi : Int!
    var lastUpdate : String!
    var name : String!
}

class customAnn : UIViewController
{
    @IBOutlet weak var lblCityName : UILabel!
    @IBOutlet weak var lblLastUpdate : UILabel!
    
    var name = ""
    var time = ""
    
    override func viewDidLoad() {
        lblCityName.text = name
        lblLastUpdate.text = time
    }
}

class AddCityMapVC: UIViewController, MKMapViewDelegate{
   
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var viewForMap: UIView!
    @IBOutlet weak var viewForList: UIView!
    
    @IBOutlet weak var mapView: MKMapView!
    var arrayAllDeviceDic = NSDictionary()
    var arrayAllDevice : NSArray = NSArray()
    var arrayAllCities = NSArray()

    var mapAnnotations : [Annotation] = [Annotation]()
    
    var barButton = UIBarButtonItem()

    var flag = true
    
    @IBOutlet weak var tableView: YUTableView!
    var closeOtherNodes = true
    var insertRowAnimation: UITableViewRowAnimation = .Right
    var deleteRowAnimation: UITableViewRowAnimation = .Left
    var allNodes : [YUTableViewNode]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewForList.hidden = true
        
        title = "Add City"
        barButton = UIBarButtonItem(image: UIImage(named: "Assets_Add City_List View"), style: .Done, target: self, action: #selector(btnMapListClicked))
        
        getAllDeviceData()

        setTableProperties()
        setTableViewSettings(true, insertAnimation: insertRowAnimation, deleteAnimation: deleteRowAnimation)
    }
    
    
    func updateUI()
    {
        self.mapView.removeAnnotations(mapView.annotations)
        
        mapAnnotations = [Annotation]()
        //------------------------------------------------- MapView
        
        for(_,obj) in arrayAllDevice.enumerate()
        {
            //print(obj)
            let abc = nf.numberFromString(obj["payload"]!?["d"]!?["t"] as! String)?.doubleValue
            let date = NSDate(timeIntervalSince1970: abc!)
            df.dateFormat = "MMM dd yyyy, HH:SS"
            
            let latitude = obj["latitude"] as? Double
            let longitude = obj["longitude"] as? Double
            let x = obj["aqi"] as? Int
            
            let info = Annotation(coord: CLLocationCoordinate2DMake(latitude! , longitude!))
            
            info.coordinate = CLLocationCoordinate2DMake(latitude! , longitude!)
            info.subtitle = obj["deviceId"] as? String
            info.title = obj["label"] as? String
            info.name = obj["label"] as? String
            info.aqi = x
            info.lastUpdate = df.stringFromDate(date)
            
            if x > 0 && x <= 50
            {
                info.imageName = "good_map_marker_24.png"
            }
            else if x > 50 && x <= 100
            {
                info.imageName = "satisfactory_map_marker_24.png"
            }
            else if x > 100 && x <= 200
            {
                info.imageName = "moderate_map_marker_24.png"
            }
            else if x > 200 && x <= 300
            {
                info.imageName = "poor_map_marker_24.png"
            }
            else if x > 300 && x <= 400
            {
                info.imageName = "very_poor_map_marker_24.png"
            }
            else if x > 400 && x <= 500
            {
                info.imageName = "severe_map_marker_24.png"
            }
            else
            {
                info.imageName = "good_map_marker_24.png"
            }
            
            self.mapAnnotations.append(info)
        }
        
        mapView.addAnnotations(self.mapAnnotations)
        //-----------------------------------
    }
    
func listAllCities()
    {
        setTableProperties()
        //self.tableView.reloadData()
    }
    
func mapView(mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl)
    {
        appDelegate.gDeviceId = ((view.annotation?.subtitle)!)!
        NSUserDefaults.standardUserDefaults().setValue(appDelegate.gDeviceId, forKey: "gdevId")
        let info = DeviceInfo()
        info.device_name = ((view.annotation?.title)!)!
        info.device_id = appDelegate.gDeviceId
        info.id = 120
        ModelManager.getInstance().addNewDevice(info)
        appDelegate.switchGlobalMode(1)
    }
    
    func mapView(mapView: MKMapView, didSelectAnnotationView view: MKAnnotationView) {
        
        let pinToZoomOn = view.annotation
        let span = MKCoordinateSpanMake(0.5, 0.5)
        let region = MKCoordinateRegion(center: pinToZoomOn!.coordinate, span: span)
        mapView.setRegion(region, animated: true)
    }
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
    
        var pinView:CustomAnnotationView?
            = mapView.dequeueReusableAnnotationViewWithIdentifier("CustomPinAnnotationView") as? CustomAnnotationView
        
        if(annotation is Annotation)
        {
            
            if(pinView == nil)
            {
                pinView = CustomAnnotationView(annotation:annotation, reuseIdentifier:"CustomPinAnnotationView")
                
                pinView!.canShowCallout = false
                
            }
            else
            {
                pinView!.annotation = annotation
            }
            
            let cpa = annotation as! Annotation
            pinView!.image = UIImage(named:cpa.imageName)
        }
        //Set annotation-specific properties **AFTER**
        //the view is dequeued or created...
        return pinView
    }

    
    
    //MARK: TableView Properties
    
    func setTableProperties () {
        allNodes = createNodes()
        tableView.setNodes(allNodes)
        tableView.setDelegate(self)
        tableView.allowOnlyOneActiveNodeInSameLevel = closeOtherNodes
        tableView.insertRowAnimation = insertRowAnimation
        tableView.deleteRowAnimation = deleteRowAnimation
        tableView.animationCompetitionHandler = {
            //print("Animation ended")
        }
    }
    
    func setTableViewSettings (closeOtherNodes: Bool, insertAnimation: UITableViewRowAnimation, deleteAnimation: UITableViewRowAnimation) {
        self.closeOtherNodes = closeOtherNodes
        self.insertRowAnimation = insertAnimation
        self.deleteRowAnimation = deleteAnimation
    }
    
    func createNodes () -> [YUTableViewNode] {
        var nodes = [YUTableViewNode] ()
        
        //MARK: Create cells & count
        
        for i in 0..<arrayAllDevice.count
        {
            let obj = arrayAllDevice[i] as! NSDictionary
            //print(obj)
            
            var grandChildNode = [YUTableViewNode]()
            
            var aqiString = String()
            var lastUpdate = String()
            
            if obj.valueForKey("aqi") is NSNumber
            {
                aqiString = nf.stringFromNumber(obj.valueForKey("aqi") as! NSNumber)!
            }
            else
            {
                aqiString = obj.valueForKey("aqi") as! String
            }
            
            if obj.valueForKey("t") is NSNumber
            {
                let fullDate = obj.valueForKey("t") as! NSTimeInterval
                let date = NSDate(timeIntervalSince1970: fullDate)
                df.dateFormat = "dd MMM HH:mm"
                lastUpdate = df.stringFromDate(date)
            }
            else
            {
                let fullDate = nf.numberFromString(obj.valueForKey("t") as! NSString as String)!.doubleValue
                let date = NSDate(timeIntervalSince1970: fullDate)
                df.dateFormat = "dd MMM HH:mm"
                lastUpdate = df.stringFromDate(date)
            }
            
            let gnode = YUTableViewNode(childNodes: nil, data: ["id":obj.valueForKey("deviceId") as! String,"label":obj.valueForKey("label") as! String,"aqi": aqiString,"lastUpdate":lastUpdate], cellIdentifier: "BasicCell")
            grandChildNode.append(gnode)
            
            var childNode = [YUTableViewNode]()
            let cnode = YUTableViewNode(childNodes: grandChildNode, data: ["label":obj.valueForKey("city") as! String], cellIdentifier: "BasicCell")
            childNode.append(cnode)
            
            let node = YUTableViewNode(childNodes: childNode, data: ["label" : obj.valueForKey("city") as! String], cellIdentifier: "BasicCell")
            nodes.append (node)
        }
        
        return nodes
    }
    
    override func viewWillAppear(animated: Bool) {
        initActivityLoader("Assets All_Loader_Oizom", LableName: "LOADING", color: true)
        self.navigationItem.rightBarButtonItem = barButton
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func btnMapListClicked()
    {
        viewForList.hidden = true
        viewForMap.hidden = true
        
        if flag
        {
            barButton.image = UIImage(named: "Assets_Add City_Map View")
            viewForList.hidden = false
        }
        else
        {
            barButton.image = UIImage(named: "Assets_Add City_List View")
            viewForMap.hidden = false
            
        }
        
        flag = !flag
        
    }
    
    @IBAction func btnAddCityClicked(sender: LetsButton) {
    }
}

//MARK: TableView Delegate

extension AddCityMapVC: YUTableViewDelegate {
    func setContentsOfCell(cell: UITableViewCell, node: YUTableViewNode) {
//        if let customCell = cell as? CustomTableViewCell, let cellDic = node.data as? [String:String] {
//            customCell.setLabelOnly(cellDic["label"]!)
//        } else {
//            let cellDic = node.data as? [String:String]
//            cell.textLabel!.text = cellDic!["label"]! as String
//        }
        
        if node.cellIdentifier == "ComplexCell" {
            let customCell = cell as? CustomTableViewCell
            let cellDic = node.data as? [String:String]
            customCell!.setLabelOnly(cellDic!["label"]!)
        }else if node.cellIdentifier == "BasicCell" {
            let cellDic = node.data as? [String:String]
            cell.textLabel?.text = cellDic!["label"]!
        }
    }
    func heightForNode(node: YUTableViewNode) -> CGFloat? {
        if node.cellIdentifier == "ComplexCell" {
            return 44.0
        }else if node.cellIdentifier == "BasicCell" {
            return 44.0
        }
        return nil
    }
    
    func didSelectNode(node: YUTableViewNode, indexPath: NSIndexPath) {
        if !node.hasChildren () {
            
            appDelegate.gDeviceId = node.data["id"] as! String
            NSUserDefaults.standardUserDefaults().setValue(appDelegate.gDeviceId, forKey: "gdevId")
            let info = DeviceInfo()
            
            info.device_name = node.data["label"] as! String
            info.device_id = appDelegate.gDeviceId
            info.aqi = (nf.numberFromString((node.data["aqi"] as! String))?.integerValue)!
            info.lastUpdate = node.data["lastUpdate"] as! String
            info.id = 120
            ModelManager.getInstance().addNewDevice(info)
            appDelegate.switchGlobalMode(0)
        }
    }
}
