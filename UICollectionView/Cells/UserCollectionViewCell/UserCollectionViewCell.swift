import UIKit
import SDWebImage

class UserCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var callImage: UIImageView!
    @IBOutlet weak var cellName: UILabel!
    @IBOutlet weak var cellId: UILabel!
    @IBOutlet weak var cellEmail: UILabel!
   
    
    override func awakeFromNib() {
        super.awakeFromNib()
        callImage.clipsToBounds = true
        // Initialization code
    }
    
    func configData(obj:TutorListModel){
        cellId.text = "ID: \(obj.id)"
        cellName.text = "\(obj.first_name) \(obj.last_name)"
        cellEmail.text = "\(obj.email)"
        
        
        callImage.layer.cornerRadius = 4
        callImage.sd_setImage(with: URL(string:obj.avatar), completed: { (image, error, cache, url) in

        })
    }

}
