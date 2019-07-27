//
//  Links.swift
//  MindvalleyApp
//
//  Created by Zain Almasri on 7/25/19.
//  Copyright © 2019 Zain Almasri. All rights reserved.
//

import UIKit
import SwiftyJSON

class Links: NSObject {
	// MARK: Keys
	private let KSelfKey = "self"
	private let kHtmlKey = "html"
	private let kPhotosKey = "photos"
	private let kLikesKey = "likes"
	private let kDownloadKey = "download"
	
	// MARK: Properties
	public var self_: String?
	public var html: String?
	public var photos: String?
	public var likes: String?
	public var download: String?
	
	// MARK: Links initializer
	public override init(){
		super.init()
	}
	
	public init(self_: String, html: String, photos: String, likes: String, download: String) {
		super.init()
		self.self_ = self_
		self.html = html
		self.photos = photos
		self.likes = likes
		self.download = download
	}
	
	/**
	Initates the instance based on the JSON that was passed.
	- parameter json: JSON object from SwiftyJSON.
	- returns: An initalized instance of the class.
	*/
	public required init(json: JSON) {
		self_ = json[KSelfKey].string
		html = json[kHtmlKey].string
		photos = json[kPhotosKey].string
		likes = json[kLikesKey].string
		download = json[kDownloadKey].string
	}
	
	/**
	Generates description of the object in the form of a NSDictionary.
	- returns: A Key value pair containing all valid values in the object.
	*/
	public func dictionaryRepresentation() -> [String: Any] {
		var dictionary: [String: Any] = [:]
		// self
		if let value = self_ {
			dictionary[KSelfKey] = value
		}
		// html
		if let value = html {
			dictionary[kHtmlKey] = value
		}
		// photos
		if let value = photos {
			dictionary[kPhotosKey] = value
		}
		// likes
		if let value = likes {
			dictionary[kLikesKey] = value
		}
		// download
		if let value = download {
			dictionary[kDownloadKey] = value
		}
		return dictionary
	}
}
