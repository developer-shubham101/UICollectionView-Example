//
//  HeaderCollectionViewCell.swift
//  UICollectionView
//
//  Created by Shubham Sharma on 31/10/20.
//  Copyright © 2020 Newdevpoint. All rights reserved.
//

import UIKit

class HeaderCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var callImage: UIImageView!
    @IBOutlet weak var cellName: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        callImage.clipsToBounds = true
        // Initialization code
    }
    
    func configData(obj:TutorListModel){
        cellName.text = "\(obj.first_name) \(obj.last_name)"
        
        callImage.layer.cornerRadius = callImage.bounds.height / 2
        callImage.sd_setImage(with: URL(string:obj.avatar), completed: { (image, error, cache, url) in
            
        })
    }
}
