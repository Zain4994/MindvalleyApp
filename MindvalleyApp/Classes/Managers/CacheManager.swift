//
//  CacheManager.swift
//  MindvalleyApp
//
//  Created by Zain Almasri on 7/26/19.
//  Copyright © 2019 Zain Almasri. All rights reserved.
//

import UIKit
import Cache

func downloaded(from url: URL, link: String, completionBlock: @escaping (_ data: Data, _ success: Bool) -> Void) {
	URLSession.shared.dataTask(with: url) { data, response, error in
		guard
			let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
			let data = data, error == nil
			else { completionBlock(Data(), false); return }
		DispatchQueue.main.async() {
			let newCachedData = CachedData(url: link, data: data)
			try? storage.setObject(newCachedData, forKey: link, expiry: .never)
			completionBlock(data, true)
		}
	}.resume()
}

func checkIfCached(from link: String, completionBlock: @escaping (_ data: Data, _ success: Bool) -> Void) {
	guard let url = URL(string: link) else { return }
	let hasData = try? storage.existsObject(forKey: link)
	if hasData ?? false {
		let dataCached = try? storage.object(forKey: link)
		if let data = dataCached?.data {
			completionBlock(data, true)
		} else {
			completionBlock(Data(), false)
		}
	} else {
		downloaded(from: url, link: link, completionBlock: { (Data,success) in
			completionBlock(Data, success)
		})
	}
}
