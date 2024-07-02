//
//  SettingViewController.swift
//  Instagram
//
//  Created by Trương Minh Lượng Jr on 27/3/24.
//

import UIKit

class SettingViewController: UIViewController {

    @IBOutlet weak var viewBackground: UIView!
    
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var view3: UIView!
    @IBOutlet weak var view4: UIView!
    @IBOutlet weak var view5: UIView!
    @IBOutlet weak var view6: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    private func setupUI() {
        setup()
        setupGestures()
    }
    
    private func setupGestures() {
        let clickView6TapGesture = UITapGestureRecognizer(target: self, action: #selector(clickView6))
        view6.addGestureRecognizer(clickView6TapGesture)
        view6.isUserInteractionEnabled = true
    }
    
    private func setup() {
        viewBackground.backgroundColor = UIColor(red: 27/255, green: 27/255, blue: 27/255, alpha: 1.0)
        
        view1.backgroundColor = UIColor(red: 27/255, green: 27/255, blue: 27/255, alpha: 1.0)
        view2.backgroundColor = UIColor(red: 27/255, green: 27/255, blue: 27/255, alpha: 1.0)
        view3.backgroundColor = UIColor(red: 27/255, green: 27/255, blue: 27/255, alpha: 1.0)
        view4.backgroundColor = UIColor(red: 27/255, green: 27/255, blue: 27/255, alpha: 1.0)
        view5.backgroundColor = UIColor(red: 27/255, green: 27/255, blue: 27/255, alpha: 1.0)
        view6.backgroundColor = UIColor(red: 27/255, green: 27/255, blue: 27/255, alpha: 1.0)
    }
    
    @objc func clickView6() {
        print("ookokok")
    }

}
