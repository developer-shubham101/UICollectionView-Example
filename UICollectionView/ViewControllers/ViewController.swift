//
//  ViewController.swift
//  UICollectionView
//
//  Created by Shubham Sharma on 30/10/20.
//  Copyright © 2020 Newdevpoint. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var collectionFlow: UICollectionViewFlowLayout!
 
    
    fileprivate var collectionData: [TutorListModel] = []
    
    
    fileprivate var isNewDataLoading: Bool = false
    fileprivate var overallCount: Int = 0
    fileprivate var page: Int = 1
    fileprivate let limit = 5
    
    
    fileprivate var collectionFooterHeight: CGFloat = 100.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initCollection()
        
        getTutorList( clear: true)
    }
    
 
    fileprivate func initCollection() {
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        // Setting the space between cells
        collectionFlow.minimumInteritemSpacing = 0
        collectionFlow.minimumLineSpacing = 0
        
        collectionView.register(UINib(nibName: "UserCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "UserCollectionViewCell")
        
       
    }
    fileprivate func getTutorList(clear: Bool) {
        
        if clear {
            page = 1
            self.collectionData.removeAll()
        }
        NetworkManager.getUserList(page: page, limit: limit) { (success, res) in
            
            self.isNewDataLoading = false
            if let response: [String:Any] = res as? [String:Any] {
                
                let data: [[String : Any]] = response["data"] as! [[String:Any]]
                self.overallCount = response["total"] as! Int
                
                self.collectionData.append(contentsOf: TutorListModel.giveList(list: data))
                
                if self.overallCount == self.collectionData.count {
                    self.collectionFooterHeight = 0
                }
                self.collectionView.reloadData()
                
                
                
            } else if let response: String  = res as? String {
                print(response)
            }
        }
    }
}
extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        return CGSize(width: collectionView.bounds.width, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: collectionFooterHeight)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if (kind == UICollectionView.elementKindSectionFooter) {
            let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "UserFooterCollectionReusableView", for: indexPath) as! CollectionReusableView
            footerView.footerActivityIndicator.startAnimating()
//            footerView.backgroundColor = .red
            return footerView
        } else if (kind == UICollectionView.elementKindSectionHeader) {
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "UserHeaderCollectionReusableView", for: indexPath)
//            headerView.backgroundColor = .green

            if let secondViewController: HeaderTableViewController = self.storyboard?.instantiateViewController(withIdentifier: "HeaderTableViewController") as? HeaderTableViewController {
                self.addChild(secondViewController)
                secondViewController.didMove(toParent: self)
                secondViewController.view?.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 100)
                headerView.insertSubview(secondViewController.view, aboveSubview: headerView)
            }
            return headerView
        }
        fatalError()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: UserCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "UserCollectionViewCell", for: indexPath) as! UserCollectionViewCell
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
        return CGSize.init(width: (self.collectionView.frame.size.width / 2), height: (self.collectionView.frame.size.width / 2) + 80)
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        if ((scrollView.contentOffset.y + scrollView.frame.size.height) >= scrollView.contentSize.height)        {
            if !isNewDataLoading && overallCount > collectionData.count {
                isNewDataLoading = true
                page = page + 1
                getTutorList(clear: false)
                
            }
        }
    }
     
}
 
