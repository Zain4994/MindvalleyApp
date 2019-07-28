//
//  Constant.swift
//  MindvalleyApp
//
//  Created by Zain Almasri on 7/24/19.
//  Copyright © 2019 Zain Almasri. All rights reserved.
//

import UIKit
import Cache

/// The name of disk storage, this will be used as folder name within directory
public var diskConfigName = ""

/// Expiry date that will be applied by default for every added object
public var memoryExpiry: Expiry = .never

/// The maximum number of objects in memory the cache should hold.
/// If 0, there is no count limit. The default value is 0.
public var memoryCountLimit: UInt = 0

/// The maximum total cost that the cache can hold before it starts evicting objects.
/// If 0, there is no total cost limit. The default value is 0
public var memoryTotalCostLimit: UInt  = 0


public let diskConfig = DiskConfig(name: diskConfigName)
public let memoryConfig = MemoryConfig(expiry: .never, countLimit: memoryCountLimit, totalCostLimit: memoryTotalCostLimit)

public let storage = try! Storage(
	diskConfig: diskConfig,
	memoryConfig: memoryConfig,
	transformer: TransformerFactory.forCodable(ofType: CachedData.self)
)
