//
//  SignUp1ViewController.swift
//  Instagram
//
//  Created by Trương Minh Lượng Jr on 12/3/24.
//

import UIKit

class SignUp1ViewController: UIViewController {
    
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var emailClearView: UIView!
    @IBOutlet weak var emailClearImage: UIImageView!
    @IBOutlet weak var emailClearBtn: UIButton!
    
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var imageBack: UIImageView!
    
    
    private var isEmailHasText: Bool = false {
        didSet {
            emailClearView.isHidden = !isEmailHasText
            
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
        isEmailHasText = false
        
        emailTF.backgroundColor = UIColor(red: 18/255, green: 18/255, blue: 18/255, alpha: 0.2)
        emailTF.layer.borderColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.2).cgColor
        emailTF.layer.borderWidth = 0.5
        emailTF.layer.cornerRadius = 5.0
        emailTF.placeholder = "Email"
        emailTF.attributedPlaceholder = NSAttributedString(string: emailTF.placeholder ?? "", attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 142/255, green: 142/255, blue: 142/255, alpha: 1.0)])
        
        emailClearView.backgroundColor = UIColor(red: 18/255, green: 18/255, blue: 18/255, alpha: 0.2)
    }
    
    private func setupButtons() {
        nextBtn.layer.cornerRadius = 20.0
    }
    
    private func setupGestures() {
        let clickBackTapGesture = UITapGestureRecognizer(target: self, action: #selector(clickBack))
        imageBack.addGestureRecognizer(clickBackTapGesture)
        imageBack.isUserInteractionEnabled = true
        
        emailTF.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        
    }
    
    @IBAction func clickNext(_ sender: Any) {
        if let userEmail = emailTF.text, !userEmail.isEmpty {
            if isValidEmail(email: userEmail) {
                UserDefaults.standard.set(userEmail, forKey: "email")
                
                let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let signUp2VC = mainStoryboard.instantiateViewController(withIdentifier: "SignUp2ViewController") as! SignUp2ViewController
                signUp2VC.modalPresentationStyle = .fullScreen
                signUp2VC.modalTransitionStyle = .crossDissolve
                self.present(signUp2VC, animated: true, completion: nil)
            } else {
                self.view.makeToast("Địa chỉ email không hợp lệ!")
            }
        } else {
            self.view.makeToast("Email không được để trống!")
        }
        
    }
    
    @IBAction func clearEmail(_ sender: Any) {
        emailTF.text = nil
        isEmailHasText = false
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
    
    
    @objc func clickBack() {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let signUpVC = mainStoryboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        signUpVC.modalPresentationStyle = .fullScreen
        signUpVC.modalTransitionStyle = .crossDissolve
        self.present(signUpVC, animated: true, completion: nil)
        
    }
    
    private func isValidEmail(email: String) -> Bool {
        // Sử dụng biểu thức chính quy để kiểm tra định dạng email
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
    
//        private func clearEmail() {
//            guard isEmailHasText else {
//                return
//            }
//        }
    
    @objc func textFieldDidChange() {
        isEmailHasText = !(emailTF.text?.isEmpty ?? true)
    }

}
