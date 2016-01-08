//
//  GFMNetworkService.swift
//  GoFundMeNative
//
//  Created by Daniel Ho on 12/30/15.
//  Copyright © 2015 Daniel Ho. All rights reserved.
//

import Foundation
import Moya

typealias NetworkServiceCompletionBlock = (success: Bool, response: NSDictionary?, error: Error?) -> ()

class GFMNetworkService: NSObject {

    func request(target: GoFundMe, completion: NetworkServiceCompletionBlock) -> Cancellable {
        return GoFundMeProvider.request(target) {
            (result) in
            var success = false
            var responseDict: NSDictionary?
            var responseError: Error?
            switch result {
            case let .Success(response):
                do {
                    let json: NSDictionary? = try response.mapJSON() as? NSDictionary
                    if let json = json {
                        responseDict = json
                        success = true;
                    }
                } catch {
                }
            case .Failure(let error):
                responseError = error
                break
            }
            
            completion(success: success, response: responseDict, error: responseError)
        }
    }
}
