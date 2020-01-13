
import UIKit

class SelectedImage: NSObject {
    var image: UIImage?
}

class SelectedVideo: NSObject {
    
    var url: NSURL?
    var previewImage: UIImage?
    
    override init() {
        super.init()
    }
    init(url: NSURL?, previewImage: UIImage?) {
        self.url = url
        self.previewImage = previewImage
    }
}

protocol AttachmentViewDelegate: class {
    func didTapOnAddBtn()
}

class AttachmentView: UIView {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var addBtn: UIButton!

    weak var delegate: AttachmentViewDelegate?
    
    var arrItem = [Any]() {
        didSet {
            self.collectionView.reloadData()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initializeFromNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initializeFromNib()
    }
    
    fileprivate func initializeFromNib() {
        self.initializeFromNib(nibNamed: AttachmentView.name)
        setUp()
       // self.showAnimatedSkeleton()
    }
    
    deinit {
    }
    
    func setUp() {
//        self.backgroundColor = .clear
//        collectionView.backgroundColor = .clear
        

        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.registerCellWithCollection(nibName: AttachmentCVCell.name, reuseIdentifier: AttachmentCVCell.name)
        self.collectionView.reloadData()
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cellHeight = self.collectionView.frame.size.height
        layout.itemSize = CGSize(width: cellHeight, height: cellHeight)
        self.collectionView?.setCollectionViewLayout(layout, animated: true)
    }
    
    @IBAction func addBtnAction( _ sender: UIButton) {
        self.delegate?.didTapOnAddBtn()
    }
}

extension AttachmentView: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1 //expandedRowCount(count: arrOpetions.count)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrItem.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell: AttachmentCVCell  = collectionView.dequeueReusableCell(withReuseIdentifier: AttachmentCVCell.name, for: indexPath) as! AttachmentCVCell
        cell.configureCell(item: self.arrItem[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }
}




