//
//  ViewController.swift
//  imageColors
//
//  Created by Robinson Presotto on 10/01/2016.
//  Copyright © 2016 Robitto. All rights reserved.
//

import UIKit
import ImageColors

class ViewController: UICollectionViewController, loadingViewDelegate {
    let segueLoadingView = "segueLoadingView"
    var randomImage:UIImage?
    var imageColors:UIImageColors?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        dispatch_after(1, dispatch_get_main_queue(), {
            self.performSegueWithIdentifier(self.segueLoadingView, sender: self)
        })
        
    }
    
    @IBAction func reloadData(sender: AnyObject) {
        self.performSegueWithIdentifier(segueLoadingView, sender: self)
    }
    
    func loadImageColors(image: UIImage, colors: UIImageColors) {
        self.randomImage = image
        self.imageColors = colors
        self.collectionView?.reloadData()
    }
    
    // MARK: CollectionView delegate
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 2
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 4
        case 1:
            if let colors = self.imageColors?.allColors {
                return colors.count
            } else {
                return 0
            }
        default:
            return 0
        }
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("colorCell", forIndexPath: indexPath)
        
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                cell.backgroundColor = self.imageColors?.backgroundColor
            case 1:
                cell.backgroundColor = self.imageColors?.primaryColor
                break
            case 2:
                cell.backgroundColor = self.imageColors?.secondaryColor
                break
            case 3:
                cell.backgroundColor = self.imageColors?.detailColor
                break
            default:
                break
            }
        case 1:
            if let color = self.imageColors?.allColors[indexPath.row] as? EnumerateColor {
                cell.backgroundColor = color.color
                break
            }
        default:
            break
        }
        
        return cell
        
    }
    
    override func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionElementKindSectionHeader:
            let customHeader = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: "CustomHeaderView", forIndexPath: indexPath) as! CustomHeaderView
            customHeader.imageView.image = self.randomImage
            return customHeader
        case UICollectionElementKindSectionFooter:
            return collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: "CustomFooterView", forIndexPath: indexPath)
        default:
            return collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: "CustomFooterView", forIndexPath: indexPath)
        }
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        switch section {
        case 0:
            return CGSize(width: 400, height: 300)
        case 1:
            return CGSize(width: 0, height: 0)
        default:
            return CGSize(width: 0, height: 0)
        }
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        switch section {
        case 0:
            return CGSize(width: 40, height: 40)
        case 1:
            return CGSize(width: 0, height: 0)
        default:
            return CGSize(width: 0, height: 0)
        }
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        switch indexPath.section {
            case 0:
                let sizeCell = CGFloat(collectionView.frame.width)/4-10
                return CGSizeMake(sizeCell, sizeCell)
            case 1:
                return CGSizeMake(20, 20)
            default:
                return CGSizeMake(95, 95)
        }
    }
    
    // MARK: Segue viewController
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == segueLoadingView) {
            if let loadingViewController = segue.destinationViewController as? LoadingViewController {
                loadingViewController.view.backgroundColor = UIColor.getRandomColor(UIColor.whiteColor())()
                loadingViewController.delegate = self
            }
        }
    }
    
}

