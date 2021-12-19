//
//  API.swift
//  SampleCollectionView
//
//  Created by 佐藤瑠偉史 on 2021/12/19.
//

import Foundation

final class API {
    static func getPosts(completion: @escaping ([PostModel]) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
            guard let data = sampleData.data(using: .utf8),
                  let posts = try? JSONDecoder().decode([PostModel].self, from: data) else {
                      completion([])
                      return
                  }
            completion(posts)
        }
        
    }
    
    private static var sampleData: String {
        let json =
        """
        [
            {
                "name": "user01",
                "post_date": "2021/12/11 17:10",
                "icon_image": "user",
                "post_image": "goku",
                "content": "投稿に関する説明です。"
            },
            {
                "name": "user02",
                "post_date": "2021/12/12 17:10",
                "icon_image": "user",
                "post_image": "meerkat",
                "content": "Insta風のフィードを作ってみた。"
            },
            {
                "name": "user03",
                "post_date": "2021/12/13 17:10",
                "icon_image": "user",
                "post_image": "taiwan",
                "content": "いい感じ。いい感じ。いい感じ。いい感じ。いい感じ。いい感じ。いい感じ。いい感じ。いい感じ。いい感じ。いい感じ。いい感じ。いい感じ。"
            },
            {
                "name": "user04",
                "post_date": "2021/12/14 17:10",
                "icon_image": "user",
                "post_image": "goku",
                "content": "書くこと無くなってきた。書くこと無くなってきた。書くこと無くなってきた。書くこと無くなってきた。書くこと無くなってきた。書くこと無くなってきた。書くこと無くなってきた。"
            },
            {
                "name": "user05",
                "post_date": "2021/12/15 17:10",
                "icon_image": "user",
                "post_image": "meerkat",
                "content": "最近寒すぎん？最近寒すぎん？最近寒すぎん？最近寒すぎん？最近寒すぎん？最近寒すぎん？最近寒すぎん？最近寒すぎん？最近寒すぎん？最近寒すぎん？最近寒すぎん？"
            },
            {
                "name": "user06",
                "post_date": "2021/12/16 17:10",
                "icon_image": "user",
                "post_image": "taiwan",
                "content": "次の投稿はコメントないよ。"
            },
            {
                "name": "user07",
                "post_date": "2021/12/17 17:10",
                "icon_image": "user",
                "post_image": "goku",
                "content": ""
            }
        ]
        """
        return json
    }
}
