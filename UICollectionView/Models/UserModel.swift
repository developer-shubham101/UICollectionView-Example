//
//  UserModel.swift
//  UICollectionView
//
//  Created by Shubham Sharma on 30/10/20.
//  Copyright © 2020 Newdevpoint. All rights reserved.
//

import Foundation

@objcMembers
class TutorListModel: NSObject {
    
    var id: NSNumber = 0
    var email: String = ""
    var first_name: String = ""
    var last_name: String = ""
    var avatar: String = ""
     
    static func giveList(list:[[String:Any]]) -> [TutorListModel] {
        var couponsArray = [TutorListModel]()
        for cdic in list {
            couponsArray.append(giveObj(cdic: cdic))
        }
        return couponsArray
    }
    static func giveObj(cdic:[String:Any]) -> TutorListModel{
        let resObj = TutorListModel()
        resObj.id = cdic["id"] as? NSNumber ?? 0
        resObj.email = cdic["email"] as? String ?? ""
        resObj.first_name = cdic["first_name"] as? String ?? ""
        resObj.last_name = cdic["last_name"] as? String ?? ""
        resObj.avatar = cdic["avatar"] as? String ?? ""
        return resObj
    }
}
