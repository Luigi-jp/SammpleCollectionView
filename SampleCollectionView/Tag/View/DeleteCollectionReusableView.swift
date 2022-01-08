//
//  DeleteCollectionReusableView.swift
//  SampleCollectionView
//
//  Created by 佐藤瑠偉史 on 2022/01/07.
//

import UIKit

protocol DeleteCollectionReusableViewDelegate {
    func deleteCell(itemIdentifier: Item)
}

class DeleteCollectionReusableView: UICollectionReusableView {
    
    static var identifier: String {
        return String(describing: self)
    }
    
    var delegate: DeleteCollectionReusableViewDelegate?
    var itemIdentifier: Item?

    @IBOutlet weak var button: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        button.layer.cornerRadius = button.bounds.width * 0.5
        button.addTarget(self, action: #selector(tapButton), for: .touchUpInside)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        itemIdentifier = nil
    }
    
    func configure(itemIdentifier: Item) {
        self.itemIdentifier = itemIdentifier
    }
    
    @objc func tapButton() {
        print("タップ")
        guard let itemIdentifier = itemIdentifier else {
            return
        }
        delegate?.deleteCell(itemIdentifier: itemIdentifier)
    }
}
