//
//  CategoryView.swift
//  MindvalleyApp
//
//  Created by Zain Almasri on 7/24/19.
//  Copyright © 2019 Zain Almasri. All rights reserved.
//

import UIKit

class CategoryViewCell: UICollectionViewCell {
	
	// MARK: Properties
	@IBOutlet weak var categoryView: UIView!
	@IBOutlet weak var categoryImageView: UIImageView!
	@IBOutlet weak var titleLabel: UILabel!

	
	/// Populate category view
	func populateCell(category: Category) {
		// image
		
		var imageString = ""
		if let value = category.user?.profileImage?.small, ScreenSize.isSmallScreen {
			imageString = value
		} else if let value = category.user?.profileImage?.medium, ScreenSize.isMidScreen {
			imageString = value
		} else if let value = category.user?.profileImage?.large, ScreenSize.isBigScreen || ScreenSize.isXBigScreen || ScreenSize.isIpad {
			imageString = value
		}
		
		if imageString != "" {
			checkIfCached(from: imageString, completionBlock: {
				(data, success) in
				if success {
					self.categoryImageView.image = UIImage(data: data)
				}
			})
		}
		
		if let text = category.user?.username {
			titleLabel.text = text
		}
	}
	
}

