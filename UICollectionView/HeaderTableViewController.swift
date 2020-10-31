//
//  HeaderTableViewController.swift
//  UICollectionView
//
//  Created by Shubham Sharma on 30/10/20.
//  Copyright © 2020 Newdevpoint. All rights reserved.
//

import UIKit

class HeaderTableViewController: UIViewController {
     
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var collectionFlow: UICollectionViewFlowLayout!
    
    fileprivate var collectionData: [TutorListModel] = []
   
    override func viewDidLoad() {
        super.viewDidLoad()
        initTable()
        
        getTutorList()
    }
    fileprivate func initTable() {
        collectionView.dataSource = self
        collectionView.delegate = self
        
        // Setting the space between cells
//        collectionFlow.minimumInteritemSpacing = 0
//        collectionFlow.minimumLineSpacing = 0
        
        collectionFlow.scrollDirection = .horizontal
        
        collectionView.register(UINib(nibName: "HeaderCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "HeaderCollectionViewCell")
    }
    
    
    fileprivate func getTutorList( ) {  
        NetworkManager.getUserList(page: 1, limit: 30) { (success, res) in
            if let response: [String:Any] = res as? [String:Any] {
                
                let data: [[String : Any]] = response["data"] as! [[String:Any]]
               
                self.collectionData.append(contentsOf: TutorListModel.giveList(list: data))
                self.collectionView.reloadData()
                
            } else if let response: String  = res as? String {
                print(response)
            }
        }
    }
    
}


extension HeaderTableViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
   
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: HeaderCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "HeaderCollectionViewCell", for: indexPath) as! HeaderCollectionViewCell
        cell.configData(obj: collectionData[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: (self.collectionView.frame.size.height), height: (self.collectionView.frame.size.height))
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       
    }
   
}
 
