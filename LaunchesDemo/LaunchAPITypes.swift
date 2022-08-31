//
//  LaunchAPITypes.swift
//  LaunchesDemo
//
//  Created by hadi on 26/08/2022.
//
import ObjectMapper
import Foundation


class GetLaunchesResponse:NSObject {
    
    var launchesArray=[Launch]()
}


class Launch:NSObject,Mappable {

    var success:Bool?
    var upcoming:Bool?
    var dateLocal:String?
    var flight_number:Int?
    var details:String?
    var name:String?
    var links:Link?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        success <- map["success"]
        dateLocal <- map["date_utc"]
        flight_number <- map["flight_number"]
        upcoming <- map["upcoming"]
        details <- map["details"]
        name <- map["name"]
        links <- map["links"]
    }
}

struct LaunchViewModel {

    let success:Bool?
    let upcoming:Bool?
    let dateLocal:String?
    let flight_number:Int?
    let details:String?
    let name:String?
    let wikipediaLink:String?

}


class Link:NSObject,Mappable {

    var wikipedia:String?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        wikipedia <- map["wikipedia"]
    }
}
