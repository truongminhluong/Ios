//
//  EditProfileViewController.swift
//  Instagram
//
//  Created by Trương Minh Lượng Jr on 12/3/24.
//

import UIKit

class EditProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        setupNavigation()
    }
    
    private func setupNavigation() {
        navigationItem.title = "Bài viết mới"
        let attrsss = [
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.font: UIFont(name: "Kohinoor Gujarati Bold", size: 18)!
        ]
        navigationController?.navigationBar.titleTextAttributes = attrsss
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Tiếp", style: .plain, target: nil, action: nil)
        let attrss = [
            NSAttributedString.Key.foregroundColor: UIColor(red: 56/255, green: 151/255, blue: 240/255, alpha: 1.0),
            NSAttributedString.Key.font: UIFont(name: "Kohinoor Gujarati Bold", size: 17)!
        ]
        navigationItem.rightBarButtonItem?.setTitleTextAttributes(attrss, for: .normal)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "Back"), style: .plain, target: self, action: #selector(closeButtonTapped))
        navigationController?.navigationBar.tintColor = .white
    }
    
    @objc func closeButtonTapped() {
        print("abc")
    }
    

   

}
