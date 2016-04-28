//
//  HomeViewController.swift
//  Interests
//
//  Created by Yi Gu on 4/27/16.
//  Copyright © 2016 YiGu. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
  // MARK: - IBOutlets
  @IBOutlet weak var backgroundImageView: UIImageView!
  @IBOutlet weak var collectionView: UICollectionView!
  
  private var interests = Interest.createInterests()
  
  private struct Storyboard {
    static let cellIdentifier = "Interest Cell"
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  override func preferredStatusBarStyle() -> UIStatusBarStyle {
    return .LightContent
  }
}

// MARK: - UICollectionViewDataSource
extension HomeViewController: UICollectionViewDataSource {
  func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return interests.count
  }
  
  func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCellWithReuseIdentifier(Storyboard.cellIdentifier, forIndexPath: indexPath) as! InterestCollectionViewCell
    
    cell.interest = interests[indexPath.item]
    
    return cell
  }
}

// MARK: - UIScrollViewDelegate
extension HomeViewController: UIScrollViewDelegate {
  func scrollViewWillEndDragging(scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
    let layout = self.collectionView.collectionViewLayout as! UICollectionViewFlowLayout
    let cellWidthWithSpace = layout.itemSize.width + layout.minimumLineSpacing
    
    var offset = targetContentOffset.memory
    
    let index = (offset.x + scrollView.contentInset.left) / cellWidthWithSpace
    let roundedIndex = round(index)
    
    offset = CGPoint(x: roundedIndex * cellWidthWithSpace - scrollView.contentInset.left, y: -scrollView.contentInset.top)
  }
}