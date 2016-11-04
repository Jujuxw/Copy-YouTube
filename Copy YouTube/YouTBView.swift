//
//  view.swift
//  Copy YouTube
//
//  Created by juju on 15/10/2016.
//  Copyright © 2016 juju. All rights reserved.
//

import UIKit

class baseCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpViews()
    }
    func setUpViews() {
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class YoutubeCell: baseCell {
    
    var video: Video? {
        didSet {
            titleLabel.text = video?.title
//            videoThumbnailView.image = UIImage (named: (video?.thumbnailImage)!)
            
            setupThumnailImage()
            setupProfileImage()
    
            if let channelName = video?.channel?.name, let numberOfviews = video?.numberOfviews{
                let farmatter = NumberFormatter()
                farmatter.numberStyle = .decimal
                subtextview.text = "(\(channelName) • \(farmatter.string(from: numberOfviews)!) views)"
            }
        }
    }
    
    func setupThumnailImage() {
        if let thumnailUrl = video?.thumbnailImage{
            videoThumbnailView.loadImageUrl(urlString: thumnailUrl)
        }
    }
    func setupProfileImage() {
        if let profileImageUrl = video?.channel?.profileImageName {
            userImageView.loadImageUrl(urlString: profileImageUrl)
        }
    }
    
    let videoThumbnailView: CustomImageView = {
        
        let imageView = CustomImageView()
        imageView.image = UIImage (named: "p1")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let userImageView: CustomImageView  = {
        let imageview = CustomImageView()
        imageview.image = UIImage.init(named: "p2")
        imageview.layer.cornerRadius = 22
        imageview.layer.masksToBounds = true
        return imageview
    }()
    
    let separatorView:UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black
        return view
    }()
    
    let titleLabel:UILabel = {
        let label = UILabel()
        //            label.backgroundColor = UIColor.orange
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "hello ,you see me, right?"
        return label
    }()
    
    let subtextview: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        //            textView.backgroundColor = UIColor.yellow
        textView.isUserInteractionEnabled = false
        textView.text = "yes. • 800 views"
        textView.textColor = UIColor.rgb(red: 160, green: 160, blue: 160)
        return textView
    }()
    
    
   override func setUpViews(){
        addSubview(videoThumbnailView)
        addSubview(separatorView)
        addSubview(userImageView)
        addSubview(titleLabel)
        addSubview(subtextview)
        
        addConstraintsWithVisualFormat(format: "H:|-10-[v0]-10-|", views: videoThumbnailView)
        addConstraintsWithVisualFormat(format: "H:|-8-[v0(44)]|", views: userImageView)
        addConstraintsWithVisualFormat(format: "V:|-10-[v0]-8-[v1(44)]-16-[v2(1)]|", views: videoThumbnailView,userImageView,separatorView)
        addConstraintsWithVisualFormat(format: "H:|[v0]|", views: separatorView)
        
        //Top
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .top, relatedBy: .equal, toItem: videoThumbnailView, attribute: .bottom, multiplier: 1, constant: 8))
        //Left
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .left, relatedBy: .equal, toItem: userImageView, attribute: .right, multiplier: 1, constant: 8))
        //Right
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .right, relatedBy: .equal, toItem: videoThumbnailView, attribute: .right, multiplier: 1, constant: 0))
        //Height
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 20))
        
        //Top
        addConstraint(NSLayoutConstraint(item: subtextview, attribute: .top, relatedBy: .equal, toItem: titleLabel, attribute: .bottom, multiplier: 1, constant: 8))
        //Left
        addConstraint(NSLayoutConstraint(item: subtextview, attribute: .left, relatedBy: .equal, toItem: userImageView, attribute: .right, multiplier: 1, constant: 8))
        //Right
        addConstraint(NSLayoutConstraint(item: subtextview, attribute: .right, relatedBy: .equal, toItem: videoThumbnailView, attribute: .right, multiplier: 1, constant: 0))
        //Height
        addConstraint(NSLayoutConstraint(item: subtextview, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 20))
    }
}
