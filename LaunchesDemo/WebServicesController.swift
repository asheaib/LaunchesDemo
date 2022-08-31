//
//  WebServicesController.swift
//  LaunchesDemo
//
//  Created by hadi on 26/08/2022.
//

import Foundation
import Alamofire
import ObjectMapper

let AlamoFireManagerTimeOut:Double = 30 //timeout for AlamoFire manager

enum WebServiceType{
    
    case getLaunches

}

struct CustomAlamoFireManager {
    
    static let manager: Session =  {
        let configuration =  URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest =  AlamoFireManagerTimeOut
        print(time)
        return Session(configuration: configuration)
    }()
}

class WebServiceController{
    
    let GetLaunchesWebservicePath="https://api.spacexdata.com/v4/launches";

    
    // MARK:using Alamofire library to call a get api
    
    func callGetWebService(_ url:String,parameters:[String:Any]?=nil,headers: [String:String]?=nil, webServiceType:WebServiceType,respondToController:UIViewController?=nil,passOnDict:[String:Any]?=nil)->DataRequest?{
        var httpHeader:HTTPHeaders?
        if headers != nil{
            httpHeader=HTTPHeaders(headers!)
        }
        let manager =  CustomAlamoFireManager.manager
        
        var request:DataRequest?
        
        request=manager.request(url, method: .get, parameters: parameters, encoding: JSONEncoding.default, headers: httpHeader)
        
        request!.responseJSON { response in
        
            self.manageWebServiceResponse(response: response, webServiceType: webServiceType,respondToController: respondToController,passOnDict:passOnDict)
        }
        return request
        
    }
    
    func manageWebServiceResponse(response:DataResponse<Any,AFError>,webServiceType:WebServiceType,respondToController:UIViewController?=nil,passOnDict:[String:Any]?=nil){
       
        switch webServiceType{

        case .getLaunches:
            self.manageGetLaunchesWebService(response: response, respondToController: respondToController,passOnDict: passOnDict as? [String : String])
            break
        }
    }
    
    
    
    func CallGetLaunchesWebservice(respondToController:UIViewController?=nil,passOnDict:[String:Any]?=nil){
        _=callGetWebService(GetLaunchesWebservicePath,headers:nil,webServiceType: .getLaunches,respondToController:respondToController,passOnDict:passOnDict)
    }
    
    func manageGetLaunchesWebService(response:DataResponse<Any,AFError>,respondToController:UIViewController?=nil,passOnDict:[String:String]?=nil){
        if let respondor=respondToController as? ViewController{
            switch response.result {
            case .success:
                if let jsonVal=response.value as? NSArray{
                    let response = GetLaunchesResponse()
                    for element in jsonVal {
                        if let launch = Mapper<Launch>().map(JSONObject: element) {
                            response.launchesArray.append(launch)
                        }
                    }
                    if response.launchesArray.count > 0 {
                        respondor.getLaunchesSuccess(response)
                        return
                    }
                }
                respondor.getLaunchesFailure()
                break
            case .failure:
                respondor.getLaunchesFailure()
                break
            }
        }
    }

}
