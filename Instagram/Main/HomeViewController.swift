//
//  HomeViewController.swift
//  Instagram
//
//  Created by Trương Minh Lượng Jr on 12/3/24.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "PostTableViewCell", bundle: nil), forCellReuseIdentifier: "PostTableViewCell")
    }
    
    private func setupUI() {
        navigationItem.rightBarButtonItems = [UIBarButtonItem(image: UIImage(named: "Image 7"), style: .plain, target: nil, action: nil), UIBarButtonItem(image: UIImage(named: "Image 6"), style: .plain, target: nil, action: nil)]
        navigationController?.navigationBar.tintColor = .white
        
        navigationItem.leftBarButtonItems = [UIBarButtonItem(image: UIImage(named: "Instagram Logo"), style: .plain, target: nil, action: nil)]
        
//        navigationController?.navigationBar.tintColor = .white
    }
    
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
            cell.configureCollectionView(for: indexPath.row)
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PostTableViewCell", for: indexPath) as! PostTableViewCell
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 110
        } else {
            return 511
        }
    }
}
