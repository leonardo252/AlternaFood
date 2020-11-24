//
//  CustomCollectionViewFlowLayout.swift
//  AlternaFood
//
//  Created by Nathalia Cardoso on 23/11/20.
//

import Foundation
import UIKit

//swiftlint:disable trailing_whitespace

class CustomCollectionViewFlowLayout: UICollectionViewLayout {
    // Adjust this as you need
    fileprivate var offset: CGFloat = 22
    
    //    Properties for configuring the layout: the number of columns and the cell padding.
    fileprivate var numberOfColumns = 2
    fileprivate var cellPadding: CGFloat = 10
    
    //    Cache the calculated attributes. When you call prepare(), you’ll calculate the attributes for all items and add them to the cache. You can be efficient and
    fileprivate var cache = [UICollectionViewLayoutAttributes]()
    
    //    Properties to store the content size.
    fileprivate var contentHeight: CGFloat = 0
    fileprivate var contentWidth: CGFloat {
        guard let collectionView = collectionView else {
            return 0
        }
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 30, bottom: 120, right: 30)
        let insets = collectionView.contentInset
        return collectionView.bounds.width - (insets.left + insets.right)
    }
    
    override func prepare() {
        // If cache is empty and the collection view exists – calculate the layout attributes
        guard cache.isEmpty == true, let collectionView = collectionView else {
            return
        }
        
        // xOffset: array with the x-coordinate for every column based on the column widths
        // yOffset: array with the y-position for every column, Using odd-even logic to push the even cell upwards and odd cells down.
        let columnWidth = (contentWidth / CGFloat(numberOfColumns))
        var xOffset = [CGFloat]()
        for column in 0 ..< numberOfColumns {
            xOffset.append(CGFloat(column) * columnWidth)
        }
        var column = 0
        
        var yOffset = [CGFloat]()
        for number in 0..<numberOfColumns {
            yOffset.append((number % 2 == 0) ? 0 : offset)
        }
        
        for item in 0 ..< collectionView.numberOfItems(inSection: 0) {
            
            let indexPath = IndexPath(item: item, section: 0)
            
            // Calculate insetFrame that can be set to the attribute
            
            let cellHeight = columnWidth - (cellPadding * 2)
            let height = cellPadding * 2 + cellHeight
            let frame = CGRect(x: xOffset[column], y: yOffset[column], width: columnWidth, height: height+55)
            let insetFrame = frame.insetBy(dx: cellPadding, dy: cellPadding)
            
            // Create an instance of UICollectionViewLayoutAttribute, sets its frame using insetFrame and appends the attributes to cache.
            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            attributes.frame = insetFrame
            cache.append(attributes)
            
            // Update the contentHeight to account for the frame of the newly calculated item. It then advances the yOffset for the current column based on the frame
            contentHeight = max(contentHeight, frame.maxY)
            yOffset[column] = yOffset[column] + height + 55
            
            column = column < (numberOfColumns - 1) ? (column + 1) : 0
        }
    }
    
    //    Using contentWidth and contentHeight from previous steps, calculate collectionViewContentSize.
    override var collectionViewContentSize: CGSize {
        return CGSize(width: contentWidth, height: contentHeight)
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
        var visibleLayoutAttributes = [UICollectionViewLayoutAttributes]()
        
        for attributes in cache {
            if attributes.frame.intersects(rect) {
                visibleLayoutAttributes.append(attributes)
            }
        }
        return visibleLayoutAttributes
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return cache[indexPath.item]
    }
}
