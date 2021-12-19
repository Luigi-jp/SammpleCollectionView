//
//  InstaStyleFeedCollectionViewCell.swift
//  SampleCollectionView
//
//  Created by 佐藤瑠偉史 on 2021/12/19.
//

import UIKit

final class InstaStyleFeedCollectionViewCell: UICollectionViewCell {

    static var identifier: String {
        return String(describing: self)
    }

    @IBOutlet private weak var iconImageView: UIImageView!
    @IBOutlet private  weak var userNameLabel: UILabel!
    @IBOutlet private  weak var postedDateLabel: UILabel!
    @IBOutlet private  weak var postImageView: UIImageView!
    @IBOutlet weak var postImageViewAspect: NSLayoutConstraint!
    @IBOutlet private  weak var contentLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        iconImageView.image = nil
        userNameLabel.text = nil
        postedDateLabel.text = nil
        postImageView.image = nil
        contentLabel.text = nil
    }
    
    func configure(post: PostModel) {
        userNameLabel.text = post.userName
        postedDateLabel.text = post.postDate
        contentLabel.text = post.content
        
        iconImageView.layer.cornerRadius = iconImageView.bounds.width * 0.5
        iconImageView.image = UIImage(named: post.iconImageUrlStr)
        
        guard let imageView = postImageView else { fatalError() }
        if let image = UIImage(named: post.postImageUrlStr) {
            NSLayoutConstraint.deactivate([postImageViewAspect])
            let aspect = image.size.height / image.size.width
            let constraint = NSLayoutConstraint(item: imageView,
                                                       attribute: .height,
                                                       relatedBy: .equal,
                                                       toItem: imageView,
                                                       attribute: .width,
                                                       multiplier: aspect,
                                                       constant: 0)
                        NSLayoutConstraint.activate([constraint])
            postImageViewAspect = constraint
            postImageView.image = image
        }
    }
}
