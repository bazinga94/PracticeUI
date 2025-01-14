//
//  FirstViewController.swift
//  PracticeUI
//
//  Created by 장용범 on 2021/08/04.
//

import UIKit

class FirstViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidAppear(_ animated: Bool) {
        if #available(iOS 13.0, *) {
            let statusBar = UIView(frame: UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.windowScene?.statusBarManager?.statusBarFrame ?? CGRect.zero)
            statusBar.backgroundColor = .white.withAlphaComponent(0.95)
            UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.addSubview(statusBar)
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerCollectionViewCells()
        configureCollectionView()
    }
    
    private func registerCollectionViewCells() {
        collectionView.register(UINib(nibName: MainCollectionViewCell.reuseIdentifier, bundle: nil), forCellWithReuseIdentifier: MainCollectionViewCell.reuseIdentifier)
        collectionView.register(UINib(nibName: CategoryCollectionViewCell.reuseIdentifier, bundle: nil), forCellWithReuseIdentifier: CategoryCollectionViewCell.reuseIdentifier)
        collectionView.register(UINib(nibName: WebCollectionViewCell.reuseIdentifier, bundle: nil), forCellWithReuseIdentifier: WebCollectionViewCell.reuseIdentifier)
    }
    
    private func configureCollectionView() {
        let customCollectionViewFlowLayout = CustomCollectionViewFlowLayout(stickyIndexPath: IndexPath(row: 2, section: 0))
        collectionView.collectionViewLayout = customCollectionViewFlowLayout
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}

// MARK: - UICollectionViewDelegate

extension FirstViewController: UICollectionViewDelegate {
    
}

// MARK: - UICollectionViewDataSource

extension FirstViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainCollectionViewCell.reuseIdentifier, for: indexPath) as! MainCollectionViewCell
            return cell
        }
        
        if indexPath.row == 2 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCollectionViewCell.reuseIdentifier, for: indexPath) as! CategoryCollectionViewCell
            return cell
        }
        
        if indexPath.row == 3 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WebCollectionViewCell.reuseIdentifier, for: indexPath) as! WebCollectionViewCell
            return cell
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        
        cell.contentView.backgroundColor = UIColor.random
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 80, left: 0, bottom: 0, right: 0)
    }
    
}


// MARK: - UICollectionViewDelegate

extension FirstViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = UIScreen.main.bounds.width
        
        if indexPath.row == 0 {
            return CGSize(width: width, height: 400)
        }
        
        if indexPath.row == 2 {
            return CGSize(width: width, height: 60)
        }
        
        if indexPath.row == 3 {
            return CGSize(width: width, height: 2185)
        }
        
        return CGSize(width: width, height: 100)
    }
}
