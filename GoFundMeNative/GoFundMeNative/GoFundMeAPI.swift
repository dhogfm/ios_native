//
//  GoFundMeAPI.swift
//  GoFundMeNative
//
//  Created by Daniel Ho on 12/29/15.
//  Copyright © 2015 Daniel Ho. All rights reserved.
//

import Foundation
import Moya

private extension String {
    var URLEscapedString: String {
        return self.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLHostAllowedCharacterSet())!
    }
}

// MARK: - Provider setup
let endpointClosure = { (target: GoFundMe) -> Endpoint<GoFundMe> in
    let endpoint: Endpoint<GoFundMe> = Endpoint<GoFundMe>(URL: url(target), sampleResponseClosure: {.NetworkResponse(200, target.sampleData)}, method: target.method, parameters: target.parameters)
    
    switch target {
    default:
        return endpoint.endpointByAddingHTTPHeaderFields(httpHeaders())
    }
}

let GoFundMeProvider = MoyaProvider<GoFundMe>(endpointClosure: endpointClosure)

public enum GoFundMe {
    case InitializeApp
    case SignIn(String, String)
}
var gfm_csrf = ""
var gfm_passport = ""


extension GoFundMe: TargetType {
    public var baseURL: NSURL {
        switch self {
        case .InitializeApp:
            return NSURL(string: "https://funds.gofundme.com/index.php")!
        case .SignIn:
            return NSURL(string: "https://www.gofundme.com/mvc.php")!
        
        }
    }
    
    public var path: String {
        switch self {
        case .InitializeApp:
            return ""
        case .SignIn:
            return "?route=index/postsignin"
        }
    }
        
    public var method: Moya.Method {
        switch self {
        case .InitializeApp:
            return .GET
        case .SignIn:
            return .POST
        }
    }
        
    public var parameters: [String: AnyObject]? {
        switch self {
        case .InitializeApp:
            return ["route".URLEscapedString : "mobile_user/initializeApp"]
        case .SignIn(let email, let password):
            return ["_token" : gfm_csrf,
                    "safeid" : gfm_csrf,
                    "Login[email]" : email,
                    "Login[password]" : password]
        }
    }
    
    public var sampleData: NSData {
        switch self {
        case .SignIn:
            return "{\"login\": \"true\", \"id\": 100}".dataUsingEncoding(NSUTF8StringEncoding)!
        default:
            return "{}".dataUsingEncoding(NSUTF8StringEncoding)!
        }
    }
}

public func url(route: GoFundMe) -> String {
    let urlString = route.baseURL.URLByAppendingPathComponent(route.path).absoluteString
    let newUrlString = urlString.stringByReplacingOccurrencesOfString("%3F", withString: "?")
    let slashChar: Character = "/"
    if (newUrlString.characters.last == slashChar) {
        return String(newUrlString.characters.dropLast())
    } else {
        return newUrlString
    }
}

func httpHeaders() -> [String: String] {
    let device = UIDevice.currentDevice()
    let identifier = device.identifierForVendor
    var uuid = "null"
    if identifier != nil {
        uuid = identifier!.UUIDString
    }
    let nsObject: AnyObject? = NSBundle.mainBundle().infoDictionary!["CFBundleShortVersionString"]
    let version = nsObject as! String
    var headers = [String: String]()
    headers["X-Auth-Token"] = gfm_passport
    headers["X-Mobile-App"] = "true"
    headers["x-Mobile-App-UUID"] = uuid
    headers["X-Mobile-App-Device"] = device.model
    headers["X-Mobile-App-OSVersion"] = device.systemVersion
    headers["X-Mobile-App-Platform"] = "iOS"
    headers["X-Mobile-App-Version"] = version
    headers["User-Agent"] = device.model
    headers["X-Requested-With"] = "XMLHTTPREQUEST"
#if DEBUG
    headers["Cookie"] = "XDEBUG_SESSION=PHPSTORM"
#endif
    return headers
}

