//
//  TagViewController.swift
//  SampleCollectionView
//
//  Created by 佐藤瑠偉史 on 2022/01/05.
//

import UIKit

enum SectionKind: Int, CaseIterable {
    case addTag
    case tagList
}

enum Item: Hashable {
    case addTag
    case tagName(String)
}

class TagViewController: UIViewController {

    var tags: [String] = ["Apple", "Logicool", "Anker", "Amazon", "Meta", "Google"]
    let badgeElementKind = "badge-element-kind"
    
    private lazy var compositionalLayout: UICollectionViewCompositionalLayout = {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex: Int, layoutEnvironment :NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            switch sectionIndex {
            case SectionKind.addTag.rawValue:
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(40))
                let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
                
                let section = NSCollectionLayoutSection(group: group)
                return section
                
            case SectionKind.tagList.rawValue:
                let badgeAnchor = NSCollectionLayoutAnchor(edges: [.top, .trailing], fractionalOffset: CGPoint(x: 0.3, y: -0.3))
                let badgeSize = NSCollectionLayoutSize(widthDimension: .absolute(20), heightDimension: .absolute(20))
                let badge = NSCollectionLayoutSupplementaryItem(layoutSize: badgeSize, elementKind: self.badgeElementKind, containerAnchor: badgeAnchor)
                
                let itemWidth = self.collectionView.bounds.width / 3
                let itemSize = NSCollectionLayoutSize(widthDimension: .estimated(itemWidth), heightDimension: .estimated(30))
                let item = NSCollectionLayoutItem(layoutSize: itemSize, supplementaryItems: [badge])
                
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(30))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                group.interItemSpacing = .fixed(5)
                
                let section = NSCollectionLayoutSection(group: group)
                section.interGroupSpacing = 5
                section.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 20, bottom: 0, trailing: 20)
                return section
                
            default:
                fatalError("想定外のsectionIndex")
            }
        }
        return layout
    }()
    
    private var snapshot: NSDiffableDataSourceSnapshot<SectionKind, Item>!
    private var datasource: UICollectionViewDiffableDataSource<SectionKind, Item>!
    
    @IBOutlet weak var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setCollectionView()
    }
    
    func setCollectionView() {
        collectionView.register(UINib(nibName: AddTagCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: AddTagCollectionViewCell.identifier)
        collectionView.register(UINib(nibName: TagCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: TagCollectionViewCell.identifier)
        collectionView.register(UINib(nibName: DeleteCollectionReusableView.identifier, bundle: nil), forSupplementaryViewOfKind: badgeElementKind, withReuseIdentifier: DeleteCollectionReusableView.identifier)
        
        collectionView.collectionViewLayout = compositionalLayout
        setDatasource()
        apply()
    }
    
    func setDatasource() {
        datasource = UICollectionViewDiffableDataSource<SectionKind, Item>(collectionView: collectionView) {(collectionView: UICollectionView, indexPath: IndexPath, itemIdentifier: Item) -> UICollectionViewCell? in
            switch itemIdentifier {
            case .addTag:
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AddTagCollectionViewCell.identifier, for: indexPath) as? AddTagCollectionViewCell else {
                    fatalError("Cellの再利用に失敗")
                }
                cell.delegate = self
                return cell
            
            case .tagName(let tagName):
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TagCollectionViewCell.identifier, for: indexPath) as? TagCollectionViewCell else {
                    fatalError("Cellの再利用に失敗")
                }
                cell.configure(tagName: tagName)
                return cell
            }
        }
        
        datasource.supplementaryViewProvider = { (collectionView: UICollectionView, kind: String, indexPath: IndexPath) -> UICollectionReusableView? in
            switch indexPath.section {
            case SectionKind.tagList.rawValue:
                if kind == self.badgeElementKind {
                    guard let badge = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: DeleteCollectionReusableView.identifier, for: indexPath) as? DeleteCollectionReusableView else {
                        fatalError()
                    }
                    guard let identifire = self.datasource.itemIdentifier(for: indexPath) else {
                        fatalError()
                    }
                    badge.configure(itemIdentifier: identifire)
                    badge.delegate = self
                    return badge
                }
            default:
                break
            }
            return nil
        }
    }
    
    func apply() {
        snapshot = NSDiffableDataSourceSnapshot<SectionKind, Item>()
        snapshot.appendSections(SectionKind.allCases)
        snapshot.appendItems([.addTag], toSection: .addTag)
        let tagList: [Item] = tags.map { .tagName($0) }
        snapshot.appendItems(tagList, toSection: .tagList)
        
        datasource.apply(snapshot, animatingDifferences: true)
    }
}

extension TagViewController: AddTagCollectionViewCellDelegate {
    func addTag(tagName: String) {
        guard !tags.contains(tagName) else {
            print("同じタグを複数作成できません。")
            return
        }
        tags.append(tagName)
        apply()
    }
}

extension TagViewController: DeleteCollectionReusableViewDelegate {
    func deleteCell(itemIdentifier: Item) {
        guard let indexPath = datasource.indexPath(for: itemIdentifier) else {
            fatalError()
        }
        tags.remove(at: indexPath.row)
        apply()
    }
}
