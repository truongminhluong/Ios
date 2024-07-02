//
//  PostViewController.swift
//  Instagram
//
//  Created by Trương Minh Lượng Jr on 12/3/24.
//

import UIKit
import Photos

class PostViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var viewZoom: UIView!
    @IBOutlet weak var photoImage: UIImageView!
    @IBOutlet weak var recentlyView: UILabel!
    @IBOutlet weak var cameraView: UIView!
    
    @IBOutlet weak var selectPhotoView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var assets = [PHAsset]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
    }
    
    private func setupUI() {
        setupCollectionView()
        setupView()
    }
    
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        let layout = UICollectionViewFlowLayout()
        
        // Set the number of items per row (số cột)
        let numberOfItemsPerRow: CGFloat = 4
        
        // Tính toán kích thước cho mỗi ô dựa trên kích thước của UICollectionView
        let paddingSpace = layout.minimumInteritemSpacing * (numberOfItemsPerRow)
        let availableWidth = collectionView.frame.width - paddingSpace
        let itemWidth = availableWidth / numberOfItemsPerRow
        layout.itemSize = CGSize(width: itemWidth, height: itemWidth) // Kích thước của mỗi ô là vuông
        
        // Set the layout for the collection view
        collectionView.collectionViewLayout = layout
        
        loadPhotos()
    }
    
    private func setupView() {
        selectPhotoView.layer.cornerRadius = selectPhotoView.frame.width / 2
        selectPhotoView.clipsToBounds = true
        selectPhotoView.backgroundColor = UIColor(red: 27/255, green: 27/255, blue: 27/255, alpha: 1.0)
        
        viewZoom.layer.cornerRadius = viewZoom.frame.width / 2
        viewZoom.clipsToBounds = true
        viewZoom.backgroundColor = UIColor(red: 27/255, green: 27/255, blue: 27/255, alpha: 1.0)
        
        cameraView.layer.cornerRadius = cameraView.frame.width / 2
        cameraView.clipsToBounds = true
        cameraView.backgroundColor = UIColor(red: 27/255, green: 27/255, blue: 27/255, alpha: 1.0)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupNavigation()
        
        // Lấy indexPath của ô vuông đầu tiên
        let firstIndexPath = IndexPath(item: 0, section: 0)
        
        // Lấy cell tương ứng với indexPath
        if let cell = collectionView.cellForItem(at: firstIndexPath) as? PhotoCollectionViewCell {
            // Lấy ảnh từ imageView trong cell
            let image = cell.imageView.image
            // Hiển thị ảnh len
            photoImage.image = image
        }
        
    }
    
    private func setupNavigation() {
        navigationItem.title = "Bài viết mới"
        let attrsss = [
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.font: UIFont(name: "Kohinoor Gujarati Bold", size: 18)!
        ]
        navigationController?.navigationBar.titleTextAttributes = attrsss
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Tiếp", style: .plain, target: self, action: #selector(nextButtonTapped))
        let attrss = [
            NSAttributedString.Key.foregroundColor: UIColor(red: 56/255, green: 151/255, blue: 240/255, alpha: 1.0),
            NSAttributedString.Key.font: UIFont(name: "Kohinoor Gujarati Bold", size: 17)!
        ]
        navigationItem.rightBarButtonItem?.setTitleTextAttributes(attrss, for: .normal)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "Image 14"), style: .plain, target: self, action: #selector(closeButtonTapped))
        navigationController?.navigationBar.tintColor = .white
        
        self.tabBarController?.tabBar.isHidden = true
    }
    
    @objc func closeButtonTapped() {
        self.tabBarController?.tabBar.isHidden = false
        self.tabBarController?.selectedIndex = 0
    }
    
    @objc func nextButtonTapped() {
        let post1ViewController = PostView1ViewController()
        self.navigationController?.pushViewController(post1ViewController, animated: true)

    }

    
    private func loadPhotos() {
        //lấy tất cả ảnh từ thư viện
        let fetchOptions = PHFetchOptions()
        fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        let fetchResult = PHAsset.fetchAssets(with: .image, options: fetchOptions)
        
        //thêm các asset đã lấy vào mảng
        fetchResult.enumerateObjects { asset, _, _ in
            self.assets.append(asset)
        }
        
        //tải lại collectionView
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return assets.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCollectionViewCell", for: indexPath) as! PhotoCollectionViewCell
        
        //lấy ảnh cho vào asset
        let asset = assets[indexPath.item]
        
        let requestOptions = PHImageRequestOptions()
        requestOptions.isSynchronous = true
        
        // Lấy ảnh từ PHAsset
        PHImageManager.default().requestImage(for: asset, targetSize: CGSize(width: 80, height: 80), contentMode: .aspectFill, options: requestOptions) { image, _ in
            // Kiểm tra xem cell có còn tồn tại không trước khi đặt ảnh vào imageView
            if let image = image {
                cell.imageView.image = image
            }
        }
        
        return cell
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // Lấy ảnh của ô vuông đã được chọn
        let selectedAsset = assets[indexPath.item]
        
        // Yêu cầu ảnh từ PHAsset
        PHImageManager.default().requestImage(for: selectedAsset, targetSize: CGSize(width: photoImage.frame.size.width, height: photoImage.frame.size.height), contentMode: .aspectFill, options: nil) { image, _ in
            self.photoImage.image = image
        }
    }
    
}


