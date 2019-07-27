//
//  ProfileImage.swift
//  MindvalleyApp
//
//  Created by Zain Almasri on 7/25/19.
//  Copyright © 2019 Zain Almasri. All rights reserved.
//

import UIKit
import SwiftyJSON

class ProfileImage: NSObject {
	// MARK: Keys
	private let kSmallKey = "small"
	private let kMediumKey = "medium"
	private let kLargeKey = "large"
	
	// MARK: Properties
	public var small: String?
	public var medium: String?
	public var large: String?
	
	// MARK: Profile Image initializer
	public override init(){
		super.init()
	}
	
	/**
	Dependency Injection (DI)
	- parameter small: small image url.
	- parameter medium: medium image url.
	- parameter large: large image url.
	- returns: An initalized instance of the class.
	*/
	public init(small: String, medium: String, large: String) {
		super.init()
		self.small = small
		self.medium = medium
		self.large = large
	}
	
	/**
	Initates the instance based on the JSON that was passed.
	- parameter json: JSON object from SwiftyJSON.
	- returns: An initalized instance of the class.
	*/
	public required init(json: JSON) {
		small = json[kSmallKey].string
		medium = json[kMediumKey].string
		large = json[kLargeKey].string
	}
	
	/**
	Generates description of the object in the form of a NSDictionary.
	- returns: A Key value pair containing all valid values in the object.
	*/
	public func dictionaryRepresentation() -> [String: Any] {
		var dictionary: [String: Any] = [:]
		// small
		if let value = small {
			dictionary[kSmallKey] = value
		}
		// medium
		if let value = medium {
			dictionary[kMediumKey] = value
		}
		// large
		if let value = large {
			dictionary[kLargeKey] = value
		}
		return dictionary
	}
}
