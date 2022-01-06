//
//  AddTagCollectionViewCell.swift
//  SampleCollectionView
//
//  Created by 佐藤瑠偉史 on 2022/01/06.
//

import UIKit

protocol AddTagCollectionViewCellDelegate {
    func addTag(tagName: String)
}

class AddTagCollectionViewCell: UICollectionViewCell {

    static var identifier: String {
        return String(describing: self)
    }
    
    var delegate: AddTagCollectionViewCellDelegate?
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var addButton: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        addButton.addTarget(self, action: #selector(tapAddButton), for: .touchUpInside)
    }
    
    @objc func tapAddButton() {
        guard let tagName = textField.text, !tagName.isEmpty else {
            print("追加するタグ名を入力してください。")
            return
        }
        delegate?.addTag(tagName: tagName)
    }
}
