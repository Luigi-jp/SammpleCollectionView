//
//  GridDesignViewController.swift
//  SampleCollectionView
//
//  Created by 佐藤瑠偉史 on 2022/02/05.
//

import UIKit

class GridDesignViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            let flowLayout = ColumnFlowLayout()
            collectionView.collectionViewLayout = flowLayout
            collectionView.register(GridDesignCollectionViewCell.self, forCellWithReuseIdentifier: GridDesignCollectionViewCell.identifier)
            collectionView.dataSource = self
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let collectionViewWidth = collectionView.bounds.size.width
        print("viewDidLoad: \(collectionViewWidth)")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let collectionViewWidth = collectionView.bounds.size.width
        print("viewWillAppear: \(collectionViewWidth)")
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        let collectionViewWidth = collectionView.bounds.size.width
        print("viewWillLayoutSubviews: \(collectionViewWidth)")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // storyboardとシュミレータのサイズが違う場合、viewDidLayoutSubViews以前と以後ではviewサイズが異なる。
        // その為、cellのサイズをcollectionViewのwidthから算出する場合は、viewのレイアウトが確定した後に呼ばれるviewDidLayoutSubviewsで算出する。
        // ここより前でcellのサイズを算出すると実際より大きい幅で計算される為、列が3列ではなく2列になってしまう。（storyboard: iphone11、 シュミレータ: iphone12の場合）
        
//        let flowLayout = UICollectionViewFlowLayout()
//        flowLayout.minimumInteritemSpacing = 10
//        flowLayout.minimumLineSpacing = 10
//        let availableWidth = collectionView.bounds.inset(by: collectionView.layoutMargins).size.width
//        let numColumns = 3
//        let itemSpacing = flowLayout.minimumInteritemSpacing * CGFloat(numColumns - 1)
//        let cellWidth = ((availableWidth - itemSpacing) / CGFloat(numColumns)).rounded(.down)
//        flowLayout.itemSize = CGSize(width: cellWidth, height: cellWidth)
//        collectionView.collectionViewLayout = flowLayout
        
        let collectionViewWidth = collectionView.bounds.size.width
        print("viewDidLayoutSubviews: \(collectionViewWidth)")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let collectionViewWidth = collectionView.bounds.size.width
        print("viewDidAppear: \(collectionViewWidth)")
        
    }
}

extension GridDesignViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 100
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GridDesignCollectionViewCell.identifier, for: indexPath)
        cell.backgroundColor = .blue
        return cell
    }
}
