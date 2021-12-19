//
//  InstaStyleFeedViewController.swift
//  SampleCollectionView
//
//  Created by 佐藤瑠偉史 on 2021/12/19.
//

import UIKit

final class InstaStyleFeedViewController: UIViewController {

    private lazy var compositionalLayout: UICollectionViewCompositionalLayout = {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            // ItemSizeを設定
            let estimatedHeight = UIScreen.main.bounds.width
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(estimatedHeight))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
            // GroupSizeを設定
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(estimatedHeight))
            let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
            
            // SectionSizeを設定
            let section = NSCollectionLayoutSection(group: group)
            
            return section
        }
        return layout
    }()
    
    private var posts: [PostModel] = []

    @IBOutlet private weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpCollectionView()

        // Do any additional setup after loading the view.
        API.getPosts { posts in
            self.posts = posts
            self.collectionView.reloadData()
        }
    }

    private func setUpCollectionView() {
        collectionView.register(UINib(nibName: InstaStyleFeedCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: InstaStyleFeedCollectionViewCell.identifier)
        
        collectionView.collectionViewLayout = compositionalLayout
        
        collectionView.dataSource = self
    }
}

extension InstaStyleFeedViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: InstaStyleFeedCollectionViewCell.identifier, for: indexPath) as? InstaStyleFeedCollectionViewCell else {
            fatalError()
        }
        let post = posts[indexPath.row]
        cell.configure(post: post)
        return cell
    }
    
    
}
