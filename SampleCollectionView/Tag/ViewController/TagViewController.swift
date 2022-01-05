//
//  TagViewController.swift
//  SampleCollectionView
//
//  Created by 佐藤瑠偉史 on 2022/01/05.
//

import UIKit

class TagViewController: UIViewController {

    let tags: [String] = ["Logicool", "マウス", "キーボード", "ウルトラワイドモニター", "あけましておめでとうございます"]
    
    private lazy var compositionalLayout: UICollectionViewCompositionalLayout = {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex: Int, layoutEnvironment :NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            
            let itemWidth = self.tagCollectionView.bounds.width / 3
            let itemSize = NSCollectionLayoutSize(widthDimension: .estimated(itemWidth), heightDimension: .estimated(30))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(30))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
            group.interItemSpacing = .fixed(5)
            
            let section = NSCollectionLayoutSection(group: group)
            section.interGroupSpacing = 5
            
            return section
        }
        return layout
    }()
    
    @IBOutlet weak var tagCollectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setCollectionView()
    }
    
    func setCollectionView() {
        tagCollectionView.register(UINib(nibName: TagCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: TagCollectionViewCell.identifier)
        
//        tagCollectionView.collectionViewLayout = compositionalLayout
        tagCollectionView.dataSource = self
    }
}

extension TagViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        tags.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TagCollectionViewCell.identifier, for: indexPath) as? TagCollectionViewCell else {
            fatalError()
        }
        let tag = tags[indexPath.row]
        cell.configure(tagName: tag)
        return cell
    }
}
