//
//  DeleteCollectionReusableView.swift
//  SampleCollectionView
//
//  Created by 佐藤瑠偉史 on 2022/01/07.
//

import UIKit

class DeleteCollectionReusableView: UICollectionReusableView {
    
    static var identifier: String {
        return String(describing: self)
    }

    @IBOutlet weak var button: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        button.layer.cornerRadius = button.bounds.width * 0.5
        button.addTarget(self, action: #selector(tapButton), for: .touchUpInside)
    }
    
    @objc func tapButton() {
        print("タップ")
    }
}
