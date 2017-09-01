//
//  HomeVC.swift
//  AirIndiaQuality
//
//  Created by Shivang Dave on 25/08/16.
//  Copyright © 2016 Shivang Dave. All rights reserved.
//

import UIKit

class HomeCollectCell : UICollectionViewCell
{
    @IBOutlet weak var btnCell: UIButton!
}


class HomeVC: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var lblCityName : UILabel!
    @IBOutlet weak var imgInd : UIImageView!
    @IBOutlet weak var lblAqiValue : UILabel!
    @IBOutlet weak var lblAqiValueStatus : UILabel!
    
    @IBOutlet weak var lblShowTip : UILabel!
    
    @IBOutlet weak var btnOne : UIButton!
    @IBOutlet weak var btnTwo : UIButton!
    @IBOutlet weak var btnThree : UIButton!
    @IBOutlet weak var btnFour : UIButton!
    
    var aqi = ""
    
    //MARK: little buttons
    var temp = ""
    var percent = ""
    var date = ""
    var time = ""
    
    let goodImgArray = ["Assets All_Outdoor Activity 5","Assets All_Outdoor Activity 6","Assets All_Outdoor Activity 7","Assets All_Outdoor Activity 8"]
    let goodImgArrayCopy = ["Assets All_Outdoor Activity 5 copy","Assets All_Outdoor Activity 6 copy","Assets All_Outdoor Activity 7 copy","Assets All_Outdoor Activity 8 copy"]
    let goodStatusArray = ["Take baby out","Take dinner out","Take pet for walk","Explore nature by photography"]
    
    let satImgArray = ["Assets All_Outdoor Activity 9","Assets All_Outdoor Activity 10","Assets All_Outdoor Activity 14","Assets All_Outdoor Activity 13"]
    let satImgArrayCopy = ["Assets All_Outdoor Activity 9 copy","Assets All_Outdoor Activity 10 copy","Assets All_Outdoor Activity 14 copy","Assets All_Outdoor Activity 13 copy"]
    let satStatusArray = ["Cycling","Jogging","Plant a tree","Do not use two wheeler"]
    
    let modImgArray = ["Assets All_Outdoor Activity 14","Assets All_Outdoor Activity 1","Assets All_Outdoor Activity15","Assets All_Outdoor Activity 2"]
    let modImgArrayCopy = ["Assets All_Outdoor Activity 14 copy","Assets All_Outdoor Activity 1 copy","Assets All_Outdoor Activity15 copy","Assets All_Outdoor Activity 2 copy"]
    let modStatusArray = ["Plant a tree","Use public transport","Do not smoke","Do not fire light"]
    
    let poorImgArray = ["Assets All_Outdoor Activity 11","Assets All_Outdoor Activity 1","Assets All_Outdoor Activity 13","Assets All_Outdoor Activity 14"]
    let poorImgArrayCopy = ["Assets All_Outdoor Activity copy","Assets All_Outdoor Activity 1 copy","Assets All_Outdoor Activity 13 copy","Assets All_Outdoor Activity 14 copy"]
    let poorStatusArray = ["Use mask","Use public transport","Do not use two wheeler","Plant a tree"]
    
    let veryPoorImgArray = ["Assets All_Outdoor Activity 11","Assets All_Outdoor Activity 4","Assets All_Outdoor Activity 12","Assets All_Outdoor Activity 1"]
    let veryPoorImgArrayCopy = ["Assets All_Outdoor Activity copy","Assets All_Outdoor Activity 4 copy","Assets All_Outdoor Activity 12 copy","Assets All_Outdoor Activity 1 copy"]
    let vpoorStatusArray = ["Use mask","Wear protective eye glasses","Do not use two wheeler","Use public transport"]
    
    let sevImgArray = ["Assets All_Outdoor Activity 11","Assets All_Outdoor Activity 13","Assets All_Outdoor Activity15","Assets All_Outdoor Activity 1"]
    let sevImgArrayCopy = ["Assets All_Outdoor Activity copy","Assets All_Outdoor Activity 13 copy","Assets All_Outdoor Activity15 copy","Assets All_Outdoor Activity 1 copy"]
    let sevStatusArray = ["Use mask","Do not use two wheeler","Do not smoke","Use public transport"]
    
    @IBOutlet weak var btnTemp : UIButton!
    @IBOutlet weak var btnPercent : UIButton!
    @IBOutlet weak var btnDate : UIButton!
    @IBOutlet weak var btnTime : UIButton!
    
    override func viewWillAppear(animated: Bool) {
        initActivityLoader("Assets All_Loader_Oizom", LableName: "LOADING", color: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(HomeVC.enableBtn), name: "hum", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(HomeVC.enableTemp), name: "temp", object: nil)
        
        getDeviceData()
    }
    
    func enableTemp(noti: NSNotification)
    {
        let userInfo = noti.userInfo as? NSDictionary
        let x = userInfo!.valueForKey("per")
        print(x)
        btnTemp.setImage(UIImage(named: "therm"), forState: .Normal)
        btnTemp.imageView?.contentMode = .ScaleAspectFit
        btnTemp.setTitle("\(x!)°", forState: .Normal)
    }
    
    func enableBtn(noti: NSNotification)
    {
        let userInfo = noti.userInfo as? NSDictionary
        let x = userInfo!.valueForKey("per")
        print(x)
        btnPercent.setImage(UIImage(named: "water"), forState: .Normal)
        btnPercent.imageView?.contentMode = .ScaleAspectFit
        btnPercent.setTitle("\(x!)%", forState: .Normal)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func reloadUI(x : Int)
    {
        self.lblAqiValue.font = UIFont(name: "BebasNeue", size: 60.0)
        self.lblAqiValue.textAlignment = NSTextAlignment.Center
        self.lblAqiValue.text = nf.stringFromNumber(x)
        //let x = nf.numberFromString(self.aqi)?.integerValue
        
        if x > 0 && x <= 50
        {
            imgInd.image = UIImage(named: "Assets All_Indicator_Good")
            lblAqiValueStatus.text = "GOOD"
            setGood()
        }
        else if x > 50 && x <= 100
        {
            imgInd.image = UIImage(named: "Assets All_Indicator_Satisfactory")
            lblAqiValueStatus.text = "SATISFACTORY"
            setSat()
        }
        else if x > 100 && x <= 200
        {
            imgInd.image = UIImage(named: "Assets All_Indicator_Moderate")
            lblAqiValueStatus.text = "MODERATE"
            setMod()
        }
        else if x > 200 && x <= 300
        {
            imgInd.image = UIImage(named: "Assets All_Indicator_poor")
            lblAqiValueStatus.text = "POOR"
            setPoor()
        }
        else if x > 300 && x <= 400
        {
            imgInd.image = UIImage(named: "Assets All_Indicator_very poor")
            lblAqiValueStatus.text = "VERY POOR"
            setVpoor()
        }
        else if x > 400 && x <= 500
        {
            imgInd.image = UIImage(named: "Assets All_Indicator_Severe")
            lblAqiValueStatus.text = "SEVERE"
            setSev()
        }
        else
        {
            imgInd.image = UIImage(named: "Assets All_Indicator")
        }
    }
    
    @IBAction func btnShareClicked(sender:AnyObject)
    {
     let string = "I just discovered the air quality of " + lblCityName.text! + " is  \(lblAqiValue.text!) \(lblAqiValueStatus.text!) #KnowWhatYouBreathe"
        
        //print(string)
        self.presentViewController(appDelegate.shareActionSheet(string), animated: true, completion: nil)
    }
    
    @IBAction func btnRefreshCLicked(sender:AnyObject)
    {
        if checkInternate()
        {
            getDeviceData()
        }
    }
    
    func setGood()
    {
        btnOne.setImage(UIImage(named: goodImgArray[0])?.imageWithRenderingMode(.AlwaysOriginal), forState: .Normal)
        btnTwo.setImage(UIImage(named: goodImgArray[1])?.imageWithRenderingMode(.AlwaysOriginal), forState: .Normal)
        btnThree.setImage(UIImage(named: goodImgArray[2])?.imageWithRenderingMode(.AlwaysOriginal), forState: .Normal)
        btnFour.setImage(UIImage(named: goodImgArray[3])?.imageWithRenderingMode(.AlwaysOriginal), forState: .Normal)
        
        btnOne.setImage(UIImage(named: goodImgArrayCopy[0])?.imageWithRenderingMode(.AlwaysOriginal), forState: .Selected)
        btnTwo.setImage(UIImage(named: goodImgArrayCopy[1])?.imageWithRenderingMode(.AlwaysOriginal), forState: .Selected)
        btnThree.setImage(UIImage(named: goodImgArrayCopy[2])?.imageWithRenderingMode(.AlwaysOriginal), forState: .Selected)
        btnFour.setImage(UIImage(named: goodImgArrayCopy[3])?.imageWithRenderingMode(.AlwaysOriginal), forState: .Selected)
        
        btnOne.imageView?.contentMode = .ScaleAspectFill
        btnTwo.imageView?.contentMode = .ScaleAspectFill
        btnThree.imageView?.contentMode = .ScaleAspectFill
        btnFour.imageView?.contentMode = .ScaleAspectFill
        
        if !btnOne.selected == true || !btnTwo.selected == true || !btnThree.selected == true || !btnFour.selected == true
        {
            btnOne.selected = false
            btnTwo.selected = false
            btnFour.selected = false
            btnThree.selected = true
        }
        lblShowTip.text! = goodStatusArray[2]
    }
    
    func setSat()
    {
        btnOne.setImage(UIImage(named: satImgArray[0])?.imageWithRenderingMode(.AlwaysOriginal), forState: .Normal)
        btnTwo.setImage(UIImage(named: satImgArray[1])?.imageWithRenderingMode(.AlwaysOriginal), forState: .Normal)
        btnThree.setImage(UIImage(named: satImgArray[2])?.imageWithRenderingMode(.AlwaysOriginal), forState: .Normal)
        btnFour.setImage(UIImage(named: satImgArray[3])?.imageWithRenderingMode(.AlwaysOriginal), forState: .Normal)
        
        btnOne.setImage(UIImage(named: satImgArrayCopy[0])?.imageWithRenderingMode(.AlwaysOriginal), forState: .Selected)
        btnTwo.setImage(UIImage(named: satImgArrayCopy[1])?.imageWithRenderingMode(.AlwaysOriginal), forState: .Selected)
        btnThree.setImage(UIImage(named: satImgArrayCopy[2])?.imageWithRenderingMode(.AlwaysOriginal), forState: .Selected)
        btnFour.setImage(UIImage(named: satImgArrayCopy[3])?.imageWithRenderingMode(.AlwaysOriginal), forState: .Selected)
        
        btnOne.imageView?.contentMode = .ScaleAspectFill
        btnTwo.imageView?.contentMode = .ScaleAspectFill
        btnThree.imageView?.contentMode = .ScaleAspectFill
        btnFour.imageView?.contentMode = .ScaleAspectFill
        
        if !btnOne.selected == true || !btnTwo.selected == true || !btnThree.selected == true || !btnFour.selected == true
        {
            btnOne.selected = false
            btnTwo.selected = false
            btnFour.selected = false
            btnThree.selected = true
        }
        lblShowTip.text! = satStatusArray[2]
    }
    
    func setMod()
    {
        btnOne.setImage(UIImage(named: modImgArray[0])?.imageWithRenderingMode(.AlwaysOriginal), forState: .Normal)
        btnTwo.setImage(UIImage(named: modImgArray[1])?.imageWithRenderingMode(.AlwaysOriginal), forState: .Normal)
        btnThree.setImage(UIImage(named: modImgArray[2])?.imageWithRenderingMode(.AlwaysOriginal), forState: .Normal)
        btnFour.setImage(UIImage(named: modImgArray[3])?.imageWithRenderingMode(.AlwaysOriginal), forState: .Normal)
        
        btnOne.setImage(UIImage(named: modImgArrayCopy[0])?.imageWithRenderingMode(.AlwaysOriginal), forState: .Selected)
        btnTwo.setImage(UIImage(named: modImgArrayCopy[1])?.imageWithRenderingMode(.AlwaysOriginal), forState: .Selected)
        btnThree.setImage(UIImage(named: modImgArrayCopy[2])?.imageWithRenderingMode(.AlwaysOriginal), forState: .Selected)
        btnFour.setImage(UIImage(named: modImgArrayCopy[3])?.imageWithRenderingMode(.AlwaysOriginal), forState: .Selected)
        
        btnOne.imageView?.contentMode = .ScaleAspectFill
        btnTwo.imageView?.contentMode = .ScaleAspectFill
        btnThree.imageView?.contentMode = .ScaleAspectFill
        btnFour.imageView?.contentMode = .ScaleAspectFill
        
        if !btnOne.selected == true || !btnTwo.selected == true || !btnThree.selected == true || !btnFour.selected == true
        {
            btnOne.selected = false
            btnTwo.selected = false
            btnFour.selected = false
            btnThree.selected = true
        }
        lblShowTip.text! = modStatusArray[2]
    }
    
    func setPoor()
    {
        btnOne.setImage(UIImage(named: poorImgArray[0])?.imageWithRenderingMode(.AlwaysOriginal), forState: .Normal)
        btnTwo.setImage(UIImage(named: poorImgArray[1])?.imageWithRenderingMode(.AlwaysOriginal), forState: .Normal)
        btnThree.setImage(UIImage(named: poorImgArray[2])?.imageWithRenderingMode(.AlwaysOriginal), forState: .Normal)
        btnFour.setImage(UIImage(named: poorImgArray[3])?.imageWithRenderingMode(.AlwaysOriginal), forState: .Normal)
        
        btnOne.setImage(UIImage(named: poorImgArrayCopy[0])?.imageWithRenderingMode(.AlwaysOriginal), forState: .Selected)
        btnTwo.setImage(UIImage(named: poorImgArrayCopy[1])?.imageWithRenderingMode(.AlwaysOriginal), forState: .Selected)
        btnThree.setImage(UIImage(named: poorImgArrayCopy[2])?.imageWithRenderingMode(.AlwaysOriginal), forState: .Selected)
        btnFour.setImage(UIImage(named: poorImgArrayCopy[3])?.imageWithRenderingMode(.AlwaysOriginal), forState: .Selected)
        
        btnOne.imageView?.contentMode = .ScaleAspectFill
        btnTwo.imageView?.contentMode = .ScaleAspectFill
        btnThree.imageView?.contentMode = .ScaleAspectFill
        btnFour.imageView?.contentMode = .ScaleAspectFill

        if !btnOne.selected == true || !btnTwo.selected == true || !btnThree.selected == true || !btnFour.selected == true
        {
            btnOne.selected = false
            btnTwo.selected = false
            btnFour.selected = false
            btnThree.selected = true
        }
        lblShowTip.text! = poorStatusArray[2]
    }
    
    func setVpoor()
    {
        btnOne.setImage(UIImage(named: veryPoorImgArray[0])?.imageWithRenderingMode(.AlwaysOriginal), forState: .Normal)
        btnTwo.setImage(UIImage(named: veryPoorImgArray[1])?.imageWithRenderingMode(.AlwaysOriginal), forState: .Normal)
        btnThree.setImage(UIImage(named: veryPoorImgArray[2])?.imageWithRenderingMode(.AlwaysOriginal), forState: .Normal)
        btnFour.setImage(UIImage(named: veryPoorImgArray[3])?.imageWithRenderingMode(.AlwaysOriginal), forState: .Normal)
        
        btnOne.setImage(UIImage(named: veryPoorImgArrayCopy[0])?.imageWithRenderingMode(.AlwaysOriginal), forState: .Selected)
        btnTwo.setImage(UIImage(named: veryPoorImgArrayCopy[1])?.imageWithRenderingMode(.AlwaysOriginal), forState: .Selected)
        btnThree.setImage(UIImage(named: veryPoorImgArrayCopy[2])?.imageWithRenderingMode(.AlwaysOriginal), forState: .Selected)
        btnFour.setImage(UIImage(named: veryPoorImgArrayCopy[3])?.imageWithRenderingMode(.AlwaysOriginal), forState: .Selected)
        
        btnOne.imageView?.contentMode = .ScaleAspectFill
        btnTwo.imageView?.contentMode = .ScaleAspectFill
        btnThree.imageView?.contentMode = .ScaleAspectFill
        btnFour.imageView?.contentMode = .ScaleAspectFill
        
        if !btnOne.selected == true || !btnTwo.selected == true || !btnThree.selected == true || !btnFour.selected == true
        {
            btnOne.selected = false
            btnTwo.selected = false
            btnFour.selected = false
            btnThree.selected = true
        }
        lblShowTip.text! = vpoorStatusArray[2]
    }
    
    func setSev()
    {
        btnOne.setImage(UIImage(named: sevImgArray[0])?.imageWithRenderingMode(.AlwaysOriginal), forState: .Normal)
        btnTwo.setImage(UIImage(named: sevImgArray[1])?.imageWithRenderingMode(.AlwaysOriginal), forState: .Normal)
        btnThree.setImage(UIImage(named: sevImgArray[2])?.imageWithRenderingMode(.AlwaysOriginal), forState: .Normal)
        btnFour.setImage(UIImage(named: sevImgArray[3])?.imageWithRenderingMode(.AlwaysOriginal), forState: .Normal)
        
        btnOne.setImage(UIImage(named: sevImgArrayCopy[0])?.imageWithRenderingMode(.AlwaysOriginal), forState: .Selected)
        btnTwo.setImage(UIImage(named: sevImgArrayCopy[1])?.imageWithRenderingMode(.AlwaysOriginal), forState: .Selected)
        btnThree.setImage(UIImage(named: sevImgArrayCopy[2])?.imageWithRenderingMode(.AlwaysOriginal), forState: .Selected)
        btnFour.setImage(UIImage(named: sevImgArrayCopy[3])?.imageWithRenderingMode(.AlwaysOriginal), forState: .Selected)
        
        btnOne.imageView?.contentMode = .ScaleAspectFill
        btnTwo.imageView?.contentMode = .ScaleAspectFill
        btnThree.imageView?.contentMode = .ScaleAspectFill
        btnFour.imageView?.contentMode = .ScaleAspectFill
        
        if !btnOne.selected == true || !btnTwo.selected == true || !btnThree.selected == true || !btnFour.selected == true
        {
            btnOne.selected = false
            btnTwo.selected = false
            btnFour.selected = false
            btnThree.selected = true
        }
        lblShowTip.text! = sevStatusArray[2]
    }

    
    @IBAction func btnOne(sender: AnyObject) {
        btnTwo.selected = false
        btnThree.selected = false
        btnFour.selected = false
        btnOne.selected = true
        
        switch lblAqiValueStatus.text!
        {
        case "GOOD":
            lblShowTip.text = goodStatusArray[0]
            break
        case "SATISFACTORY":
            lblShowTip.text = satStatusArray[0]
            break
        case "MODERATE":
            lblShowTip.text = modStatusArray[0]
            break
        case "POOR":
            lblShowTip.text = poorStatusArray[0]
            break
        case "VERY POOR":
            lblShowTip.text = vpoorStatusArray[0]
            break
        case "SEVERE":
            lblShowTip.text = sevStatusArray[0]
            break
        default:
            break
        }
    }
    
    @IBAction func btnTwo(sender: AnyObject) {
        btnOne.selected = false
        btnTwo.selected = true
        btnThree.selected = false
        btnFour.selected = false
        
        switch lblAqiValueStatus.text!
        {
        case "GOOD":
            lblShowTip.text = goodStatusArray[1]
            break
        case "SATISFACTORY":
            lblShowTip.text = satStatusArray[1]
            break
        case "MODERATE":
            lblShowTip.text = modStatusArray[1]
            break
        case "POOR":
            lblShowTip.text = poorStatusArray[1]
            break
        case "VERY POOR":
            lblShowTip.text = vpoorStatusArray[1]
            break
        case "SEVERE":
            lblShowTip.text = sevStatusArray[1]
            break
        default:
            break
        }
    }
    
    @IBAction func btnThree(sender: AnyObject) {
        btnOne.selected = false
        btnTwo.selected = false
        btnThree.selected = true
        btnFour.selected = false
        
        switch lblAqiValueStatus.text!
        {
        case "GOOD":
            lblShowTip.text = goodStatusArray[2]
            break
        case "SATISFACTORY":
            lblShowTip.text = satStatusArray[2]
            break
        case "MODERATE":
            lblShowTip.text = modStatusArray[2]
            break
        case "POOR":
            lblShowTip.text = poorStatusArray[2]
            break
        case "VERY POOR":
            lblShowTip.text = vpoorStatusArray[2]
            break
        case "SEVERE":
            lblShowTip.text = sevStatusArray[2]
            break
        default:
            break
        }
    }
    
    @IBAction func btnFour(sender: AnyObject) {
        btnOne.selected = false
        btnTwo.selected = false
        btnThree.selected = false
        btnFour.selected = true
        
        switch lblAqiValueStatus.text!
        {
        case "GOOD":
            lblShowTip.text = goodStatusArray[3]
            break
        case "SATISFACTORY":
            lblShowTip.text = satStatusArray[3]
            break
        case "MODERATE":
            lblShowTip.text = modStatusArray[3]
            break
        case "POOR":
            lblShowTip.text = poorStatusArray[3]
            break
        case "VERY POOR":
            lblShowTip.text = vpoorStatusArray[3]
            break
        case "SEVERE":
            lblShowTip.text = sevStatusArray[3]
            break
        default:
            break
        }
    }
    
}
