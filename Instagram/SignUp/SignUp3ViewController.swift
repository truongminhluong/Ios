//
//  SignUp3ViewController.swift
//  Instagram
//
//  Created by Trương Minh Lượng Jr on 12/3/24.
//

import UIKit

class SignUp3ViewController: UIViewController {

    @IBOutlet weak var backImage: UIImageView!
    
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var nameClearBtn: UIButton!
    @IBOutlet weak var nameClearImage: UIImageView!
    @IBOutlet weak var nameClearView: UIView!
    
    @IBOutlet weak var nextBtn: UIButton!
   
    private var isNamelHasText: Bool = false {
        didSet {
            nameClearView.isHidden = !isNamelHasText
            
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
        isNamelHasText = false
        
        nameTF.backgroundColor = UIColor(red: 18/255, green: 18/255, blue: 18/255, alpha: 0.2)
        nameTF.layer.borderColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.2).cgColor
        nameTF.layer.borderWidth = 0.5
        nameTF.layer.cornerRadius = 5.0
        nameTF.placeholder = "Tên đầy đủ"
        nameTF.attributedPlaceholder = NSAttributedString(string: nameTF.placeholder ?? "", attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 142/255, green: 142/255, blue: 142/255, alpha: 1.0)])
        
        nameClearView.backgroundColor = UIColor(red: 18/255, green: 18/255, blue: 18/255, alpha: 0.2)
    }
    
    private func setupButtons() {
        nextBtn.layer.cornerRadius = 20.0
    }
    
    private func setupGestures() {
        let clickBackTapGesture = UITapGestureRecognizer(target: self, action: #selector(clickBack))
        backImage.addGestureRecognizer(clickBackTapGesture)
        backImage.isUserInteractionEnabled = true
        
        nameTF.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
    }
    
    @IBAction func onClickNext(_ sender: Any) {
        if let userName = nameTF.text , !userName.isEmpty {
            UserDefaults.standard.set(userName, forKey: "name")
            let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let signUp4VC = mainStoryboard.instantiateViewController(withIdentifier: "SignUp4ViewController") as! SignUp4ViewController
            signUp4VC.modalPresentationStyle = .fullScreen
            signUp4VC.modalTransitionStyle = .crossDissolve
            self.present(signUp4VC, animated: true, completion: nil)
        } else {
            self.view.makeToast("Tên của bạn không được để trống!")
        }
    }
    
    @objc func clickBack() {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let signUpVC = mainStoryboard.instantiateViewController(withIdentifier: "SignUp2ViewController") as! SignUp2ViewController
        signUpVC.modalPresentationStyle = .fullScreen
        signUpVC.modalTransitionStyle = .crossDissolve
        self.present(signUpVC, animated: true, completion: nil)
        
    }
    
    
    @IBAction func clearName(_ sender: Any) {
        nameTF.text = nil
        isNamelHasText = false
    }
    
    @objc func textFieldDidChange() {
        isNamelHasText = !(nameTF.text?.isEmpty ?? true)
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
