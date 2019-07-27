//
//  User.swift
//  MindvalleyApp
//
//  Created by Zain Almasri on 7/25/19.
//  Copyright © 2019 Zain Almasri. All rights reserved.
//
import UIKit
import SwiftyJSON

class User: NSObject {
	// MARK: Keys
	private let kIdKey = "id"
	private let kUserNameKey = "username"
	private let kNameKey = "name"
	private let kProfileImageKey = "profile_image"
	private let kLinksKey = "links"
	
	// MARK: Properties
	public var id: String?
	public var username: String?
	public var name: String?
	public var profileImage: ProfileImage?
	public var links: Links?
	
	// MARK: User initializer
	public override init(){
		super.init()
	}
	
	/**
	Dependency Injection (DI)
	- parameter id: user id.
	- parameter username: user name.
	- parameter name: full name of user.
	- parameter profileImage: all profile photo with diffrent size.
	- parameter links: links belong to user.
	- returns: An initalized instance of the class.
	*/
	public init(id: String, username: String, name: String, profileImage: ProfileImage, links: Links) {
		super.init()
		self.id = id
		self.username = username
		self.name = name
		self.profileImage = profileImage
		self.links = links
	}
	
	/**
	Initates the instance based on the JSON that was passed.
	- parameter json: JSON object from SwiftyJSON.
	- returns: An initalized instance of the class.
	*/
	public required init(json: JSON) {
		id = json[kIdKey].string
		username = json[kUserNameKey].string
		name = json[kNameKey].string
		if json[kProfileImageKey].exists() {
			profileImage = ProfileImage(json: json[kProfileImageKey])
		}
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
			dictionary[kIdKey] = value
		}
		// username
		if let value = username {
			dictionary[kUserNameKey] = value
		}
		// name
		if let value = name {
			dictionary[kNameKey] = value
		}
		// profileImage
		if let value = profileImage {
			dictionary[kProfileImageKey] = value.dictionaryRepresentation()
		}
		// links
		if let value = links {
			dictionary[kLinksKey] = value.dictionaryRepresentation()
		}
		return dictionary
	}
}
