//
//  PhotoCollectionViewCell.swift
//  Instagram
//
//  Created by Trương Minh Lượng Jr on 28/3/24.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func awakeFromNib() {
            super.awakeFromNib()
            
            // Thiết lập các thuộc tính của imageView
            imageView.contentMode = .scaleAspectFill
            imageView.clipsToBounds = true // Đảm bảo rằng ảnh không bị tràn ra ngoài kích thước imageView
        }
    
    
}
