//
//  PostModel.swift
//  SampleCollectionView
//
//  Created by 佐藤瑠偉史 on 2021/12/19.
//

import Foundation

struct PostModel: Codable {
    var userName: String
    var postDate: String
    var iconImageUrlStr: String
    var postImageUrlStr: String
    var content: String
    
    enum CodingKeys: String, CodingKey {
        case userName = "name"
        case postDate = "post_date"
        case iconImageUrlStr = "icon_image"
        case postImageUrlStr = "post_image"
        case content
    }
}
