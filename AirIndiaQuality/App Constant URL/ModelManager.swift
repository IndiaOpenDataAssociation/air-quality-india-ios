//
//  ModelManager.swift
//  AirQualityIndia
//
//  Created by Shivang Dave on 20/10/16.
//  Copyright © 2016 Shivang Dave. All rights reserved.
//

import UIKit

let deviceInstance = ModelManager()

class ModelManager: NSObject {
    var database : FMDatabase? = nil
    
    class func getInstance() -> ModelManager
    {
        if(deviceInstance.database == nil)
        {
            deviceInstance.database = FMDatabase(path: Util.getPath("Devices.sqlite"))
        }
        return deviceInstance
    }
    
    func addNewDevice(info : DeviceInfo) -> Bool
    {
        deviceInstance.database!.open()
        let isInserted = deviceInstance.database!.executeUpdate("INSERT INTO device_info (id,device_name,device_id,aqi,lastUpdate) VALUES (?,?,?,?,?)", withArgumentsInArray: [info.id,info.device_name,info.device_id,info.aqi,info.lastUpdate])
        if isInserted
        {
            showAlert("Device added")
        }else{
            showAlert("Device addition failed")
        }
        deviceInstance.database!.close()
        return isInserted
    }
    
    func deleteDevice(info : DeviceInfo) -> Bool
    {
        deviceInstance.database!.open()
        let isDeleted = deviceInstance.database!.executeUpdate("DELETE FROM device_info WHERE device_id=?", withArgumentsInArray: [info.device_id])
        if isDeleted
        {
            showAlert("Device deleted")
        }else{
            showAlert("Device deletion failed")
        }
        deviceInstance.database!.close()
        return isDeleted
    }
    
    func getAllData() -> NSMutableArray {
        deviceInstance.database!.open()
        let resultSet: FMResultSet! = deviceInstance.database!.executeQuery("SELECT * FROM device_info", withArgumentsInArray: nil)
        let totalInfo : NSMutableArray = NSMutableArray()
        if (resultSet != nil) {
            while resultSet.next() {
                let totalInfo2 : DeviceInfo = DeviceInfo()
                totalInfo2.device_id = resultSet.stringForColumn("device_id")
                totalInfo2.device_name = resultSet.stringForColumn("device_name")
                totalInfo2.aqi = Int(resultSet.intForColumn("aqi"))
                totalInfo2.lastUpdate = resultSet.stringForColumn("lastUpdate")
                totalInfo.addObject(totalInfo2)
            }
        }
        deviceInstance.database!.close()
        return totalInfo
    }

}
