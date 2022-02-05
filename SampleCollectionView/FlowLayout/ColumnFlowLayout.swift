//
//  ColumnFlowLayout.swift
//  SampleCollectionView
//
//  Created by 佐藤瑠偉史 on 2022/02/05.
//

import Foundation
import UIKit

class ColumnFlowLayout: UICollectionViewFlowLayout {
    
    override func prepare() {
        super.prepare()
        
        guard let cv = collectionView else { return }
        self.minimumInteritemSpacing = 2
        self.minimumLineSpacing = 2
        let availableWidth = cv.bounds.size.width
        let numColumns = 3
        let itemSpacing = self.minimumInteritemSpacing * CGFloat(numColumns - 1)
        let cellWidth = ((availableWidth - itemSpacing) / CGFloat(numColumns)).rounded(.down)
        self.itemSize = CGSize(width: cellWidth, height: cellWidth)
        
        let collectionViewWidth = cv.bounds.size.width
        print("ColumnFlowLayout: \(collectionViewWidth)")
    }
}
