//
//  Urls.swift
//  MindvalleyApp
//
//  Created by Zain Almasri on 7/25/19.
//  Copyright © 2019 Zain Almasri. All rights reserved.
//

import UIKit
import SwiftyJSON

class Urls: NSObject {
	// MARK: Keys
	private let KRawKey = "raw"
	private let kFullKey = "full"
	private let kRegularKey = "regular"
	private let kSmallKey = "small"
	private let kThumbKey = "thumb"
	
	// MARK: Properties
	public var raw: String?
	public var full: String?
	public var regular: String?
	public var small: String?
	public var thumb: String?
	
	// MARK: Urls initializer
	public override init(){
		super.init()
	}
	
	public init(raw: String, full: String, regular: String, small: String, thumb: String) {
		super.init()
		self.raw = raw
		self.full = full
		self.regular = regular
		self.small = small
		self.thumb = thumb
	}
	
	/**
	Initates the instance based on the JSON that was passed.
	- parameter json: JSON object from SwiftyJSON.
	- returns: An initalized instance of the class.
	*/
	public required init(json: JSON) {
		raw = json[KRawKey].string
		full = json[kFullKey].string
		regular = json[kRegularKey].string
		small = json[kSmallKey].string
		thumb = json[kThumbKey].string
	}
	
	/**
	Generates description of the object in the form of a NSDictionary.
	- returns: A Key value pair containing all valid values in the object.
	*/
	public func dictionaryRepresentation() -> [String: Any] {
		var dictionary: [String: Any] = [:]
		// raw
		if let value = raw {
			dictionary[KRawKey] = value
		}
		// full
		if let value = full {
			dictionary[kFullKey] = value
		}
		// regular
		if let value = regular {
			dictionary[kRegularKey] = value
		}
		// small
		if let value = small {
			dictionary[kSmallKey] = value
		}
		// thumb
		if let value = thumb {
			dictionary[kThumbKey] = value
		}
		return dictionary
	}
}
