//
//  ProfileViewController.swift
//  Instagram
//
//  Created by Trương Minh Lượng Jr on 12/3/24.
//

import UIKit

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var postsLabel: UILabel!
    @IBOutlet weak var followersLabel: UILabel!
    @IBOutlet weak var watchingLabel: UILabel!
    
    @IBOutlet weak var editBtn: UIButton!
    @IBOutlet weak var shareBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    private func setupUI() {
        setupButton()
        setupNavigation()
    }
    
    private func setupNavigation() {
        navigationItem.rightBarButtonItems = [UIBarButtonItem(image: UIImage(named: "Image 2"), style: .plain, target: self, action: #selector(closeButtonTapped)), UIBarButtonItem(image: UIImage(named: "Image 3"), style: .plain, target: nil, action: nil)]
        navigationController?.navigationBar.tintColor = .white
        
        let attrss = [
            NSAttributedString.Key.foregroundColor: UIColor(.white),
            NSAttributedString.Key.font: UIFont(name: "Kohinoor Gujarati Bold", size: 18)!
        ]
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "truongminhluongjr", style: .plain, target: nil, action: nil)
        navigationItem.leftBarButtonItem?.setTitleTextAttributes(attrss, for: .normal)
    }
    
    private func setupButton() {
        editBtn.layer.cornerRadius = 8.0
        editBtn.backgroundColor = UIColor(red: 52/255, green: 52/255, blue: 52/255, alpha: 1.0)
        
        shareBtn.layer.cornerRadius = 8.0
        shareBtn.backgroundColor = UIColor(red: 52/255, green: 52/255, blue: 52/255, alpha: 1.0)
    }
    
    @IBAction func onClickEdit(_ sender: Any) {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let editVC = mainStoryboard.instantiateViewController(withIdentifier: "EditProfileViewController") as! EditProfileViewController
        navigationController?.pushViewController(editVC, animated: true)
    }
    
    @IBAction func onClickShare(_ sender: Any) {
        
    }
    
    @objc func closeButtonTapped() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: "SettingViewController") as? SettingViewController else {
            print("Không thể tạo SettingViewController từ storyboard hoặc kiểu không đúng.")
            return
        }
        
        if let sheet = vc.sheetPresentationController {
            sheet.detents = [.medium()]
            sheet.prefersScrollingExpandsWhenScrolledToEdge = false
            sheet.prefersGrabberVisible = true
            sheet.preferredCornerRadius = 20
            
            vc.preferredContentSize = CGSize(width: UIScreen.main.bounds.width, height: 300)
            
            present(vc, animated: true, completion: nil)
        } else {
            print("Không thể truy cập vào sheetPresentationController.")
        }
    }
    
}
