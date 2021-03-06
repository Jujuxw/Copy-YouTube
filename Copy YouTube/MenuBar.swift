//
//  MenuBar.swift
//  Copy YouTube
//
//  Created by juju on 15/10/2016.
//  Copyright © 2016 juju. All rights reserved.
//

import UIKit


class MenuBar: UIView, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    lazy var collectionView:UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.rgb(red: 239, green: 32, blue: 31)
        cv.dataSource = self
        cv.delegate = self
        return cv
    }()
    
    let cellId = "cellId"
    let icons = ["home", "hot", "album", "person"]
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize (width: frame.width/4, height: frame.height)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! MenuBarCell
        cell.imageView.image = UIImage (named: icons[indexPath.item])?.withRenderingMode(.alwaysTemplate)
        cell.backgroundColor = UIColor.rgb(red: 239, green: 32, blue: 31)
        return cell
    }
    
    override init(frame:CGRect) {
        super.init(frame: frame)
        
        collectionView.register(MenuBarCell.self, forCellWithReuseIdentifier: cellId)
        addSubview(collectionView)
        addConstraintsWithVisualFormat(format: "H:|[v0]|", views: collectionView)
        addConstraintsWithVisualFormat(format: "V:|[v0]|", views: collectionView)
        
        let selectedIndexPath = IndexPath (item: 0, section: 0)
        collectionView.selectItem(at: selectedIndexPath, animated: false, scrollPosition: .left)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
class MenuBarCell: baseCell {
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage (named: "home")
        iv.tintColor = UIColor.rgb(red: 0, green: 0, blue: 0)
        return iv
    }()
    
    override var isHighlighted:Bool {
        didSet {
            imageView.tintColor = isHighlighted ? UIColor.white : UIColor.rgb(red: 91, green: 14, blue: 13)
        }
    }
    
    override var isSelected: Bool {
        didSet {
            imageView.tintColor = isSelected ? UIColor.white : UIColor.rgb(red: 91, green: 14, blue: 13)
        }
    }
    
    override func setUpViews() {
        addSubview(imageView)
        addConstraintsWithVisualFormat(format: "H:[v0(30)]", views: imageView)
        addConstraintsWithVisualFormat(format: "V:[v0(30)]", views: imageView)
        addConstraint(NSLayoutConstraint (item: imageView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint (item: imageView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
        
    }
    
    
}
