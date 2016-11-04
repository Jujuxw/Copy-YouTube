//
//  ViewController.swift
//  Copy YouTube
//
//  Created by juju on 13/10/2016.
//  Copyright © 2016 juju. All rights reserved.
//

import UIKit

class HomeController: UICollectionViewController,UICollectionViewDelegateFlowLayout {
    
    var videos: [Video]?
    
    
    func fetchVideos() {
        let url = URL (string: "https://raw.githubusercontent.com/liuyandong/youtube/master/home.json")
        URLSession.shared.dataTask(with: url!){(data, response,error) in
            if error != nil{
                print(error)
                return
            }
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
                self.videos = [Video]()
                
                for dictionary in json as! [[String: AnyObject]] {
                    let video = Video()
                    video.title = dictionary["title"] as? String
                    video.numberOfviews = dictionary["number_of_views"] as? NSNumber
                    video.thumbnailImage = dictionary["thumbnail_image_name"] as? String
                    
                    let channelDictionary = dictionary["channel"] as! [String: AnyObject]
                    let channel = Channel()
                    channel.name = channelDictionary["name"] as? String
                    channel.profileImageName = channelDictionary["profile_image_name"] as? String
                    video.channel = channel
                 
                    self.videos?.append(video)
                }
                
                DispatchQueue.main.async {
                    self.collectionView?.reloadData()
                }
                
            }catch let jsonError {
                print(jsonError)
            }
            }.resume()
    }
    
//    var videos: [Video] = {
//        
//        var channelName1 = Channel()
//        channelName1.name = "god"
//        channelName1.profileImageName = "p2"
//        
//        var channelName2 = Channel()
//        channelName2.name = "loveToyou"
//        channelName2.profileImageName = "profile2"
//        
//        var channelName3 = Channel()
//        channelName3.name = "whereismyHusband"
//        channelName3.profileImageName = "profile3"
//        
//        var channelName4 = Channel()
//        channelName4.name = "loveYou"
//        channelName4.profileImageName = "profile4"
//        
//        var helloYou = Video()
//        helloYou.thumbnailImage = "p1"
//        helloYou.title = "Hello,you see me,right?"
//        helloYou.channel = channelName1
//        helloYou.numberOfviews = 218972631
//        
//        var one = Video()
//        one.thumbnailImage = "picture1"
//        one.title = "One universe"
//        one.channel = channelName2
//        one.numberOfviews = 213892
//        
//        var meet = Video()
//        meet.thumbnailImage = "picture2"
//        meet.title = "Meet you "
//        meet.channel = channelName3
//        meet.numberOfviews = 3728974
//        
//        var see = Video()
//        see.thumbnailImage = "picture3"
//        see.title = "See you "
//        see.channel = channelName4
//        see.numberOfviews = 3289748
//        
//        return [helloYou, one, meet, see]
//    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchVideos()
        
        // Do any additional setup after loading the view, typically from a nib.
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 30, height: view.frame.height))
        titleLabel.text = "Home"
        titleLabel.textColor = UIColor.white
        titleLabel.font = UIFont.systemFont(ofSize: 20)
        navigationItem.titleView = titleLabel
        self.navigationController!.navigationBar.isTranslucent = false
        
        collectionView?.backgroundColor = UIColor.white
        collectionView?.register(YoutubeCell.self, forCellWithReuseIdentifier: "HomeCell")
      
        collectionView?.contentInset = UIEdgeInsetsMake(50,0,0,0)
        collectionView?.scrollIndicatorInsets = UIEdgeInsetsMake(50,0,0,0)
        
        setupNavBarButtons()
        setupMenuBar()
    }
    
    func setupNavBarButtons() {
        let searchImage = UIImage (named: "search_icon")?.withRenderingMode(.alwaysOriginal)
        let searchBarButtonItem = UIBarButtonItem (image: searchImage, style: .plain, target: self, action: #selector(handleSearch))
//        navigationItem.rightBarButtonItems = [searchBarButtonItem]
        
        let moreImage = UIImage (named: "more_icon2")?.withRenderingMode(.alwaysOriginal)
        let moreBarButtonItem = UIBarButtonItem (image: moreImage, style: .plain, target: self, action: #selector(handleMore))
        navigationItem.rightBarButtonItems = [moreBarButtonItem,searchBarButtonItem]
    }
    func handleSearch() {
        print("search")
    }
    func handleMore() {
        print("more")
    }
    
    let menuBar: MenuBar = {
        let mb = MenuBar()
        return mb
    }()

    func setupMenuBar(){
        view.addSubview(menuBar)
        view.addConstraintsWithVisualFormat(format: "H:|[v0]|", views: menuBar)
        view.addConstraintsWithVisualFormat(format: "V:|[v0(50)]|", views: menuBar)
    }
    

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return videos?.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCell", for: indexPath) as! YoutubeCell
        cell.video = videos?[indexPath.item]
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = (collectionView.frame.width - 20) * 9 / 16
        return CGSize.init(width: collectionView.frame.width, height: height)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}


