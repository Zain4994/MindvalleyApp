//
//  HomeViewController.swift
//  MindvalleyApp
//
//  Created by Zain Almasri on 7/24/19.
//  Copyright © 2019 Zain Almasri. All rights reserved.
//

import UIKit
import Cache

class HomeViewController: UIViewController {
	
	// MARK: Properties
	@IBOutlet weak var collectionView: UICollectionView!
	
	// MARK: Data
	var categories = [Category]()
	var totalItems = 100
	var pageSize = 10
	private let categoryCellIdentifier = "categoryCell"
	var refreshControl = UIRefreshControl()
	
	
	// MARK: Controller Life Cycle
	override func viewDidLoad() {
		super.viewDidLoad()
		
		loadData()
		
		addPullToRefresh()
	}
	
	///fetch category from server
	func loadData(isRefresh: Bool = false){
		ApiManager.shared.getCategoryData(completionBlock: { (data, success, error) in
			if success {
				if isRefresh {
					self.categories.append(contentsOf: data)
					self.collectionView.reloadData()
					self.refreshControl.endRefreshing()
				} else {
					for i in data.indices {
						self.collectionView?.performBatchUpdates({
							self.categories.append(data[i])
							let indexPath = IndexPath(row: self.categories.count - 1, section: 0)
							self.collectionView?.insertItems(at: [indexPath])
						}, completion: nil)
					}
				}
				if let internetError = error, internetError.type == .connection {
					print(error?.errorMessage ?? "")
				}
			} else {
				print(error?.errorMessage ?? "")
			}
		})
	}
	
	///check if load more category data
	func loadMoreData(index: Int){
		if index == categories.count - 1 && index > pageSize - 2 { // last cell
			if totalItems > categories.count { // more items to fetch
				loadData() // fetch data
			}
		}
	}
	
	func addPullToRefresh(){
		refreshControl.addTarget(self, action: #selector(didPullToRefresh(_:)), for: .valueChanged)
		collectionView.alwaysBounceVertical = true
		collectionView.refreshControl = refreshControl
	}
	
	@objc func didPullToRefresh(_ sender: Any) {
		categories = []
		loadData(isRefresh: true)
	}
	
}


// MARK: CollectionView Delegates & DataSource
extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return categories.count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: categoryCellIdentifier, for: indexPath) as! CategoryViewCell
		cell.populateCell(category: categories[indexPath.row])
		
		// Paging
		loadMoreData(index: indexPath.row)
		
		return cell
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		let width = ScreenSize.width
		let cellSize = CGSize(width: width, height: width)
		return cellSize
	}
	
	func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
		UIView.animate(withDuration: 1, animations: {
			let newFrame = cell.frame
			cell.frame = CGRect(x: newFrame.origin.x , y: newFrame.origin.y, width: newFrame.width, height: newFrame.height)
		})
	}
}
