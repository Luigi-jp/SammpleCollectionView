//
//  GridDesignCollectionViewCell.swift
//  SampleCollectionView
//
//  Created by 佐藤瑠偉史 on 2022/02/05.
//

import UIKit

class GridDesignCollectionViewCell: UICollectionViewCell {
    
    static var identifier: String {
        return String(describing: self)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.backgroundColor = .blue
    }

}
