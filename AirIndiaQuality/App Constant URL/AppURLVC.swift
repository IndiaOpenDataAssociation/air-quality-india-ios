import Foundation

//let URL_BASE = "http://api.airpollution.online/all/public/"

let URL_BASE = "https://openenvironment.p.mashape.com/all/public/"
let URL_ALLDevice = "https://openenvironment.p.mashape.com/all/public/"+"devices"

let URL_AllCities = URL_BASE+"devices/cities"
let URL_device_data_current = URL_BASE + "data/cur/"
let URL_device_data_hourwise = URL_BASE + "data/hours/24/"

let URL_device_data_week = URL_BASE + "data/hours/168/"

//MARK: Private URLs
let PRIVATE_URL_BASE = "http://api.oizom.com"

let URL_Login = PRIVATE_URL_BASE + "/login"
let URL_Signup = PRIVATE_URL_BASE + "/signup"

let URL_deviceList = "/userId/app/private/devices"
