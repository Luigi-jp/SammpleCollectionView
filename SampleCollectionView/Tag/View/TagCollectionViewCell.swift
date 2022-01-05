//
//  TagCollectionViewCell.swift
//  SampleCollectionView
//
//  Created by 佐藤瑠偉史 on 2022/01/05.
//

import UIKit

class TagCollectionViewCell: UICollectionViewCell {
    
    static var identifier: String {
        return String(describing: self)
    }

    @IBOutlet weak var view: UIView!
    @IBOutlet weak var tagLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        view.layer.cornerRadius = 10
        view.backgroundColor = .cyan
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }

    func configure(tagName: String) {
        tagLabel.text = tagName
    }
}
