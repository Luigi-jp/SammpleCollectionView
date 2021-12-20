//
//  InstaStyleGridViewController.swift
//  SampleCollectionView
//
//  Created by 佐藤瑠偉史 on 2021/12/20.
//

import UIKit

final class InstaStyleGridViewController: UIViewController {
    
    private lazy var compositionalLayout: UICollectionViewCompositionalLayout = {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            
            // item間のスペース
            let itemSpace: CGFloat = 2
            
            // 小アイテムのサイズを設定
            let smallItemWidth: CGFloat = (self.view.bounds.width - (itemSpace * 2)) / 3
            let smallItemSize = NSCollectionLayoutSize(widthDimension: .absolute(smallItemWidth), heightDimension: .absolute(smallItemWidth))
            let smallItem = NSCollectionLayoutItem(layoutSize: smallItemSize)
            
            // 大アイテムのサイズを設定
            let largeItemWidth: CGFloat = (smallItemWidth * 2) + itemSpace
            let largeItemSize = NSCollectionLayoutSize(widthDimension: .absolute(largeItemWidth), heightDimension: .absolute(largeItemWidth))
            let largeItem = NSCollectionLayoutItem(layoutSize: largeItemSize)
            
            // 小アイテムが二つ入ったグループを設定
            let twoSmallItemGroupSize = NSCollectionLayoutSize(widthDimension: .absolute(smallItemWidth), heightDimension: .absolute(largeItemWidth))
            let twoSmallItemGroup = NSCollectionLayoutGroup.vertical(layoutSize: twoSmallItemGroupSize, subitem: smallItem, count: 2)
            twoSmallItemGroup.interItemSpacing = .fixed(itemSpace)
            
            // 大アイテム(左）と小アイテム２つのグループ（右）が入ったグループ
            let leftLargeItemGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(largeItemWidth))
            let leftLargeItemGroup = NSCollectionLayoutGroup.horizontal(layoutSize: leftLargeItemGroupSize, subitems: [largeItem, twoSmallItemGroup])
            leftLargeItemGroup.interItemSpacing = .fixed(itemSpace)
            
            // 小アイテム２つのグループ（左）と大アイテム（右）の入ったグループ
            let rightLargeItemGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(largeItemWidth))
            let rightLargeItemGroup = NSCollectionLayoutGroup.horizontal(layoutSize: rightLargeItemGroupSize, subitems: [twoSmallItemGroup, largeItem])
            rightLargeItemGroup.interItemSpacing = .fixed(itemSpace)
            
            // 小アイテム２つのグループが３つ入ったグループ
            let threeSmallItemGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(largeItemWidth))
            let threeSmallItemGroup = NSCollectionLayoutGroup.horizontal(layoutSize: threeSmallItemGroupSize, subitem: twoSmallItemGroup, count: 3)
            threeSmallItemGroup.interItemSpacing = .fixed(itemSpace)
            
            // 3つのグループが順番に格納されたグループの設定
            let subItem = [leftLargeItemGroup, threeSmallItemGroup, rightLargeItemGroup, threeSmallItemGroup]
            let groupsSpaceCount: CGFloat = CGFloat(subItem.count - 1)
            let heightDimension = NSCollectionLayoutDimension.absolute((largeItemWidth * CGFloat(subItem.count)) + (itemSpace * groupsSpaceCount))
            let groupsSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: heightDimension)
            let groups = NSCollectionLayoutGroup.vertical(layoutSize: groupsSize, subitems: subItem)
            groups.interItemSpacing = .fixed(itemSpace)
            
            // Sectionの設定
            let section = NSCollectionLayoutSection(group: groups)
            section.interGroupSpacing = itemSpace
            
            return section
        }
        return layout
    }()

    @IBOutlet private weak var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUpCollectionView()
    }
    
    private func setUpCollectionView() {
        collectionView.register(UINib(nibName: InstaStyleGridCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: InstaStyleGridCollectionViewCell.identifier)
        
        collectionView.collectionViewLayout = compositionalLayout
        
        collectionView.dataSource = self
    }
}

extension InstaStyleGridViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 180
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: InstaStyleGridCollectionViewCell.identifier, for: indexPath) as? InstaStyleGridCollectionViewCell else {
            fatalError()
        }
        switch indexPath.row % 6 {
        case 0:
            cell.backgroundColor = .blue
        case 1:
            cell.backgroundColor = .brown
        case 2:
            cell.backgroundColor = .gray
        case 3:
            cell.backgroundColor = .green
        case 4:
            cell.backgroundColor = .red
        case 5:
            cell.backgroundColor = .yellow
        default:
            fatalError()
        }
        return cell
    }
}
