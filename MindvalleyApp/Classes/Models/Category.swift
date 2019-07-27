//
//  Category.swift
//  MindvalleyApp
//
//  Created by Zain Almasri on 7/25/19.
//  Copyright © 2019 Zain Almasri. All rights reserved.
//
import UIKit
import SwiftyJSON

class Category: NSObject {
	// MARK: Keys
	private let kIdKey = "id"
	private let kCreatedAtKey = "created_at"
	private let kUserKey = "user"
	private let kUrlKey = "urls"
	private let kCategoriesKey = "categories"
	private let kLinksKey = "links"
	
	// MARK: Properties
	public var id: String?
	public var created_at: String?
	public var user: User?
	public var urls: Urls?
	public var categories: [Categories]?
	public var links: Links?
	
	// MARK: Category initializer
	public override init(){
		super.init()
	}
	
	/**
	Dependency Injection (DI)
	- parameter name: the name of the category
	- parameter image: the image of the category
	- parameter partnersCount: the partners count
	- returns: An initalized instance of the class.
	*/
	public init(id: String, created_at: String, user: User, urls: Urls, categories: [Categories], links: Links) {
		super.init()
		self.id = id
		self.created_at = created_at
		self.user = user
		self.urls = urls
		self.categories = categories
		self.links = links
	}
	
	/**
	Initates the instance based on the JSON that was passed.
	- parameter json: JSON object from SwiftyJSON.
	- returns: An initalized instance of the class.
	*/
	public required init(json: JSON) {
		id = json[kIdKey].string
		created_at = json[kCreatedAtKey].string
		if json[kUserKey].exists() {
			user = User(json: json[kUserKey])
		}
		if json[kUrlKey].exists() {
			urls = Urls(json: json[kUrlKey])
		}
		if let categoriesJsonArr = json[kCategoriesKey].array {
			categories = categoriesJsonArr.map{Categories(json:$0)}
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
		// created at
		if let value = created_at {
			dictionary[kCreatedAtKey] = value
		}
		// user
		if let value = user {
			dictionary[kUserKey] = value.dictionaryRepresentation()
		}
		// urls
		if let value = urls {
			dictionary[kUrlKey] = value.dictionaryRepresentation()
		}
		// categories
		if let array: [Categories] = categories {
			let categoriesDictionaries : [[String:Any]] = array.map{$0.dictionaryRepresentation()}
			dictionary[kCategoriesKey] = categoriesDictionaries
		}
		// links
		if let value = links {
			dictionary[kLinksKey] = value.dictionaryRepresentation()
		}
		return dictionary
	}
}
