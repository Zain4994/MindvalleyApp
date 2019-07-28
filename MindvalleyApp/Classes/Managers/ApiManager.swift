//
//  ApiManager.swift
//  MindvalleyApp
//
//  Created by Zain Almasri on 7/25/19.
//  Copyright © 2019 Zain Almasri. All rights reserved.
//

import Foundation
import SystemConfiguration
import Alamofire
import SwiftyJSON
import CacheLibrary

class ApiManager: NSObject {
	
	/// frequent request headers
	var headers: HTTPHeaders{
		get {
			let httpHeaders = [
				"X-Device-Platform": "ios",
			]
			return httpHeaders
		}
	}
	
	// MARK: Data
	let baseURL = "http://pastebin.com/raw/wgkJgazE"
	
	// MARK: Shared Instance
	static let shared: ApiManager = ApiManager()
	
	private override init(){
		super.init()
	}
		
	/**
	Get current user information
	- parameter completionBlock: closure to return back the success or failure result
	- parameter categoryData: array of data parse from json data
	- parameter success: the process finished successfully
	- parameter error: server error type
	*/
	func getCategoryData(completionBlock: @escaping (_ categoryData: [Category], _ success: Bool, _ error: ServerError?) -> Void) {
		
		// url & parameters
		let requestURL = baseURL
		
		if NetworkReachabilityManager()?.isReachable ?? false {
			Alamofire.request(requestURL, method: .get, encoding: JSONEncoding.default, headers: nil).responseJSON { (responseObject) -> Void in
				if responseObject.result.isSuccess {
					let jsonResponse = JSON(responseObject.result.value!)
					if let code = responseObject.response?.statusCode, code >= 400 { /// Server error with payload
						let serverError = ServerError(json: jsonResponse) ?? ServerError.unknownError
						completionBlock([], false, serverError)
					}else if let data = jsonResponse.array, data.count > 0 {
						// parse response
						let categoryData : [Category] = data.map{Category(json: $0)}
						
						if let hasData = try? storage.existsObject(forKey: requestURL), !hasData, let data = responseObject.data {
							let newCachedData = CachedData(url: requestURL, data: data)
							try? storage.setObject(newCachedData, forKey: requestURL, expiry: .never)
						}
						completionBlock(categoryData, true, nil)
					} else {
						completionBlock([], true,nil)
					}
				}
				// Network error request time out or server error with no payload
				if responseObject.result.isFailure {
					if let code = responseObject.response?.statusCode, code >= 400 {
						completionBlock([], false, ServerError.unknownError)
					} else {
						completionBlock([], false, ServerError.connectionError)
					}
				}
			}
		} else { /// Check if this data is cached before
			checkIfCached(from: baseURL,completionBlock: {
				(Data, success) in
				if success {
					let jsonResponse = JSON(data: Data)
					if let data = jsonResponse.array, data.count > 0 {
						// parse response
						let categoryData : [Category] = data.map{Category(json: $0)}
						completionBlock(categoryData, true, ServerError.connectionError)
					} else {
						completionBlock([], false, ServerError.unknownError)
					}
				} else {
					completionBlock([], false, ServerError.noCached)
				}
			})
		}
	}
}
