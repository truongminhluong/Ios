//
//  PostView1ViewController.swift
//  Instagram
//
//  Created by Trương Minh Lượng Jr on 11/5/24.
//

import UIKit

class PostView1ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Bài viết mới"
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "Back"), style: .plain, target: self, action: #selector(closeButtonTapped))
        navigationController?.navigationBar.tintColor = .white

    }
    
    @objc func closeButtonTapped() {
        self.navigationController?.popViewController(animated: true)

    }

}
