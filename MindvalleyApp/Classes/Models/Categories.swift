//
//  Categories.swift
//  MindvalleyApp
//
//  Created by Zain Almasri on 7/25/19.
//  Copyright © 2019 Zain Almasri. All rights reserved.
//

import UIKit
import SwiftyJSON

class Categories: NSObject {
	// MARK: Keys
	private let KIdKey = "id"
	private let kTitleKey = "title"
	private let kPhotoCountKey = "photo_count"
	private let kLinksKey = "links"
	
	// MARK: Properties
	public var id: String?
	public var title: String?
	public var photo_count: Int?
	public var links: Links?
	
	// MARK: Categories initializer
	public override init(){
		super.init()
	}
	
	public init(id: String, title: String, photo_count: Int, links: Links) {
		super.init()
		self.id = id
		self.title = title
		self.photo_count = photo_count
		self.links = links
	}
	
	/**
	Initates the instance based on the JSON that was passed.
	- parameter json: JSON object from SwiftyJSON.
	- returns: An initalized instance of the class.
	*/
	public required init(json: JSON) {
		id = json[KIdKey].string
		title = json[kTitleKey].string
		photo_count = json[kPhotoCountKey].intValue
		if json[kLinksKey].exists() {
			links = Links(json: json[kLinksKey])
		}
	}
	
	/**
	Generates description of the object in the form of a NSDictionary.
	- returns: A Key value pair containing all valid values in the object.
	*/
	public func dictionaryRepresentation() -> [String: Any] {
		var dictionary: [String: Any] = [:]
		// id
		if let value = id {
			dictionary[KIdKey] = value
		}
		// title
		if let value = title {
			dictionary[kTitleKey] = value
		}
		// photo count
		if let value = photo_count {
			dictionary[kPhotoCountKey] = value
		}
		// links
		if let value = links {
			dictionary[kLinksKey] = value.dictionaryRepresentation()
		}
		return dictionary
	}
}
