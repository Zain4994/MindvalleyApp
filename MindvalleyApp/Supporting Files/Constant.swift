//
//  Constant.swift
//  MindvalleyApp
//
//  Created by Zain Almasri on 7/24/19.
//  Copyright © 2019 Zain Almasri. All rights reserved.
//

import UIKit
import Cache

// MARK: Screen size
enum ScreenSize {
	static let isSmallScreen =  UIScreen.main.bounds.height <= 568 // iphone 4/5
	static let isMidScreen =  UIScreen.main.bounds.height <= 667 // iPhone 6 & 7
	static let isBigScreen =  UIScreen.main.bounds.height >= 736 // iphone 6Plus/7Plus
	static let isXBigScreen =  UIScreen.main.bounds.height >= 812 // iphone X
	static let isIphone = UIDevice.current.userInterfaceIdiom == .phone
	static let isIpad = UIDevice.current.userInterfaceIdiom == .pad
	static let width = UIScreen.main.bounds.width
	static let height = UIScreen.main.bounds.height
}

let diskConfig = DiskConfig(name: "MindcalleyAppData")
let memoryConfig = MemoryConfig(expiry: .never, countLimit: 20, totalCostLimit: 0)
let storage = try! Storage(
	diskConfig: diskConfig,
	memoryConfig: memoryConfig,
	transformer: TransformerFactory.forCodable(ofType: CachedData.self)
)
