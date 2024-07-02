//
//  SignUp2ViewController.swift
//  Instagram
//
//  Created by Trương Minh Lượng Jr on 12/3/24.
//

import UIKit

class SignUp2ViewController: UIViewController {

    @IBOutlet weak var backImage: UIImageView!
    
    @IBOutlet weak var passTF: UITextField!
    @IBOutlet weak var passClearBtn: UIButton!
    @IBOutlet weak var passEyeImage: UIImageView!
    @IBOutlet weak var passErrorView: UIView!
    
    @IBOutlet weak var nextBtn: UIButton!
    
    private var isShowPassword: Bool = false {
        didSet {
            passTF.isSecureTextEntry = !isShowPassword
            passEyeImage.image = isShowPassword ? UIImage(named: "eye_open") : UIImage(named: "eye_close")
            guard let text = passTF.text else {
                return
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
    }
    
    private func setupUI() {
        setupTextField()
        setupButtons()
        setupGestures()
    }
    
    private func setupTextField() {
        isShowPassword = false
        
        passTF.backgroundColor = UIColor(red: 18/255, green: 18/255, blue: 18/255, alpha: 0.2)
        passTF.layer.borderColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.2).cgColor
        passTF.layer.borderWidth = 0.5
        passTF.layer.cornerRadius = 5.0
        passTF.placeholder = "Mật khẩu"
        passTF.attributedPlaceholder = NSAttributedString(string: passTF.placeholder ?? "", attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 142/255, green: 142/255, blue: 142/255, alpha: 1.0)])
        
        passErrorView.backgroundColor = UIColor(red: 18/255, green: 18/255, blue: 18/255, alpha: 0.2)
    }
    
    private func setupButtons() {
        nextBtn.layer.cornerRadius = 20.0
    }
    
    private func setupGestures() {
        let clickBackTapGesture = UITapGestureRecognizer(target: self, action: #selector(clickBack))
        backImage.addGestureRecognizer(clickBackTapGesture)
        backImage.isUserInteractionEnabled = true
    }
    
    @IBAction func oncCickNext(_ sender: Any) {
        if let userPass = passTF.text, !userPass.isEmpty {
            if userPass.count >= 6 {
                UserDefaults.standard.set(userPass, forKey: "password")
                let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let signUp3VC = mainStoryboard.instantiateViewController(withIdentifier: "SignUp3ViewController") as! SignUp3ViewController
                signUp3VC.modalPresentationStyle = .fullScreen
                signUp3VC.modalTransitionStyle = .crossDissolve
                self.present(signUp3VC, animated: true, completion: nil)
                
            } else {
                self.view.makeToast("Mật khẩu phải chứa ít nhất 6 ký tự!")
            }
        } else {
            self.view.makeToast("Mật khẩu không được để trống!")
        }
    }
    
    @objc func clickBack() {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let signUpVC = mainStoryboard.instantiateViewController(withIdentifier: "SignUp1ViewController") as! SignUp1ViewController
        signUpVC.modalPresentationStyle = .fullScreen
        signUpVC.modalTransitionStyle = .crossDissolve
        self.present(signUpVC, animated: true, completion: nil)
    }
    
    
    @IBAction func passEye(_ sender: Any) {
        isShowPassword.toggle()
    }
    
    @IBAction func haveAccount(_ sender: Any) {
        let alert = UIAlertController(title: "Bạn đã có tài khoản ư?", message: "", preferredStyle: .alert)
        
        let attributedTitle = NSAttributedString(string: "Đăng nhập", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 17)])

        alert.addAction(UIAlertAction(title: NSLocalizedString("Đăng nhập", comment: "Default action"), style: .default, handler: { _ in
            print("abc")
            let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let loginVC = mainStoryboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
            loginVC.modalPresentationStyle = .fullScreen
            loginVC.modalTransitionStyle = .crossDissolve
            self.present(loginVC, animated: true, completion: nil)

        NSLog("The \"OK\" alert occured.")
        }))
        alert.addAction(UIAlertAction(title: NSLocalizedString("Tiếp tục tạo tài khoản", comment: "Default action"), style: .default, handler: { _ in
        NSLog("The \"OK\" alert occured.")
        }))
        self.present(alert, animated: true, completion: nil)
    }

}
