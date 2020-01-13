
import UIKit

class AttachmentCVCell: UICollectionViewCell {
        
    @IBOutlet weak var imgIcon: UIImageView!
    @IBOutlet weak var playIcon: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.imgIcon.contentMode = .scaleAspectFill
    }
    func configureCell(item: Any?) {
        if let video = item as? SelectedVideo {
            if let imageSafe = video.previewImage {
                self.imgIcon.image = imageSafe
                playIcon.isHidden = false
            }
            playIcon.isHidden = false
        } else if let image = item as? SelectedImage {
            self.imgIcon.image = image.image
            playIcon.isHidden = true
        }
    }
}
