//
//  LoginViewController.swift
//  Instagram
//
//  Created by Trương Minh Lượng Jr on 12/3/24.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var emailClearView: UIView!
    @IBOutlet weak var emailClearImage: UIImageView!
    @IBOutlet weak var emailClearBtn: UIButton!
    
    @IBOutlet weak var passTF: UITextField!
    @IBOutlet weak var passEyeBtn: UIButton!
    @IBOutlet weak var passEyeImage: UIImageView!
    @IBOutlet weak var passErrorView: UIView!
    
    @IBOutlet weak var forgotPasswordBtn: UIButton!
    
    @IBOutlet weak var loginBtn: UIButton!
    
    @IBOutlet weak var facebookLoginBtn: UIButton!
    
    @IBOutlet weak var signUpBtn: UIButton!
    
    private var isEmailHasText: Bool = false {
        didSet {
            emailClearView.isHidden = !isEmailHasText
            
        }
    }
    
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
        setupGestures()
        
    }
    
    private func setupTextField() {
        isEmailHasText = false
        isShowPassword = false
        
        emailTF.backgroundColor = UIColor(red: 18/255, green: 18/255, blue: 18/255, alpha: 0.2)
        emailTF.layer.borderColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.2).cgColor
        emailTF.layer.borderWidth = 0.5
        emailTF.layer.cornerRadius = 5.0
        emailTF.placeholder = "Tên người dùng,email/ số điện thoại"
        emailTF.attributedPlaceholder = NSAttributedString(string: emailTF.placeholder ?? "", attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 142/255, green: 142/255, blue: 142/255, alpha: 1.0)])

        
        passTF.backgroundColor = UIColor(red: 18/255, green: 18/255, blue: 18/255, alpha: 0.2)
        passTF.layer.borderColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.2).cgColor
        passTF.layer.borderWidth = 0.5
        passTF.layer.cornerRadius = 5.0
        passTF.placeholder = "Mật khẩu"
        passTF.attributedPlaceholder = NSAttributedString(string: passTF.placeholder ?? "", attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 142/255, green: 142/255, blue: 142/255, alpha: 1.0)])
        
        loginBtn.layer.cornerRadius = 5.0
        emailClearView.backgroundColor = UIColor(red: 18/255, green: 18/255, blue: 18/255, alpha: 0.2)
        passErrorView.backgroundColor = UIColor(red: 18/255, green: 18/255, blue: 18/255, alpha: 0.2)

    }
    
    private func setupGestures() {
        emailTF.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
    }
    
    @objc func textFieldDidChange() {
        isEmailHasText = !(emailTF.text?.isEmpty ?? true)
    }
    
    @IBAction func onHandleButton(_ sender: UIButton) {
        switch sender {
        case emailClearBtn:
            emailTF.text = nil
            isEmailHasText = false
            break
        case passEyeBtn:
            isShowPassword.toggle()
            break
        case forgotPasswordBtn:
            break
        case loginBtn:
            break
        case facebookLoginBtn:
            break
        case signUpBtn:
            
            let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let signUpVC = mainStoryboard.instantiateViewController(withIdentifier: "SignUp1ViewController") as! SignUp1ViewController
            signUpVC.modalPresentationStyle = .fullScreen
            signUpVC.modalTransitionStyle = .crossDissolve
            self.present(signUpVC, animated: true, completion: nil)
            
            break
        default:
            break
        }
    }
    
    private func isValidEmail(email: String) -> Bool {
        // Sử dụng biểu thức chính quy để kiểm tra định dạng email
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
    

}
