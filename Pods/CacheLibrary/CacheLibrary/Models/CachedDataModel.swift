//
//  ImageCached.swift
//  MindvalleyApp
//
//  Created by Zain Almasri on 7/26/19.
//  Copyright © 2019 Zain Almasri. All rights reserved.
//

import UIKit
import Cache

public struct CachedData: Codable {
	
	// MARK: Properties
	var url: String
	var data: Data
	
	public init(url: String, data: Data) {
		self.url = url
		self.data = data
	}
}
