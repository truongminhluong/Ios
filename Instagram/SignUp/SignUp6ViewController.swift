//
//  SignUp6ViewController.swift
//  Instagram
//
//  Created by Trương Minh Lượng Jr on 12/3/24.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage
import Toast
import MHLoadingButton

class SignUp6ViewController: UIViewController {

    var selectedImage: UIImage? {
        didSet {
            updateAvatarButtonState()
        }
    }
    
    var isAvatarButtonDone: Bool = false {
        didSet {
            updateAvatarButtonTitle()
        }
    }
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var title2Label: UILabel!
    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var avatarBtn: LoadingButton!
    @IBOutlet weak var closeBtn: UIButton!
        
    lazy var vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LibraryCameraViewController")
    
    lazy var vcc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CameraViewController")
        
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
    }
    
    private func setupUI() {
        setupBtn()
        setupAvatar()
        updateTitleLabels()
    }
    
    private func updateTitleLabels() {
        if isAvatarButtonDone {
            titleLabel.text = "Đã thêm ảnh đại diện"
            title2Label.isHidden = true
        } else {
            title2Label.isHidden = false
        }
    }
    
    private func setupAvatar () {
        if let image = selectedImage {
            configureAvatarImageView(image)
            isAvatarButtonDone = true
        }
    }
    
    private func configureAvatarImageView(_ image: UIImage) {
            avatarImage.image = image
            avatarImage.layer.cornerRadius = 75
            avatarImage.layer.masksToBounds = true
            avatarImage.contentMode = .scaleAspectFill
        }
    
    private func updateAvatarButtonState() {
        isAvatarButtonDone = (selectedImage != nil)
    }
    
    private func updateAvatarButtonTitle() {
        
        guard avatarBtn != nil else {
            print("Lỗi: avatarBtn là nil.")
            return
        }
        
        if isAvatarButtonDone {
            avatarBtn.setTitle("Xong", for: .normal)
        } else {
            avatarBtn.setTitle("Thêm ảnh", for: .normal)
        }
        
        updateTitleLabels()
    }
    
    func setupBtn() {
        avatarBtn.layer.cornerRadius = 20.0
        avatarBtn.layer.masksToBounds = true
        avatarBtn.clipsToBounds = true
        closeBtn.layer.cornerRadius = 20.0
        closeBtn.backgroundColor = UIColor(red: 52/255, green: 52/255, blue: 52/255, alpha: 1.0)
        
        avatarBtn.indicator = MaterialLoadingIndicator(color: .white)
        
        
        }
    
    @IBAction func onClickAddAvatar(_ sender: Any) {
        if !isAvatarButtonDone {
            configureCameraSheetPresentation()
            present(vc, animated: true, completion: nil)
        } else {
            addUserInfoToFirestore()
        }
        
    }
    
    private func configureCameraSheetPresentation() {
        guard !isAvatarButtonDone else {
            return
        }
        
        if let sheet = vc.sheetPresentationController {
            sheet.detents = [.medium()]
            sheet.prefersScrollingExpandsWhenScrolledToEdge = false
            sheet.prefersGrabberVisible = true
        }
    }
    
    
    @IBAction func onClickClose(_ sender: Any) {
        if let sheet = vcc.sheetPresentationController {
            sheet.detents = [.medium()]
            sheet.prefersScrollingExpandsWhenScrolledToEdge = false
            sheet.prefersGrabberVisible = true
        }
        
        present(vcc, animated: true, completion: nil)
    }
    
    private func addUserInfoToFirestore() {
        guard let email = UserDefaults.standard.string(forKey: "userEmail"),
              let password = UserDefaults.standard.string(forKey: "password"),
              let name = UserDefaults.standard.string(forKey: "name"),
              let userName = UserDefaults.standard.string(forKey: "userName"),
              let birthdate = UserDefaults.standard.string(forKey: "selectedDate") else {
            print("Error")
            return
        }
        
        
        avatarBtn.showLoader(userInteraction: false)

        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                print("Error creating user: \(error.localizedDescription)")
                return
            }
            
            guard let uid = authResult?.user.uid else {
                print("ERROR: UID")
                return
            }
            
            print(uid)
            
            // Tải ảnh avatar lên Firebase Storage
            if let avatarImageData = self.avatarImage.image?.jpegData(compressionQuality: 0.8) {
                let storageRef = Storage.storage().reference().child("avatars").child("\(uid).jpg")
                
                storageRef.putData(avatarImageData, metadata: nil) { metadata, error in
                    guard let _ = metadata else {
                        print("Lỗi khi tải ảnh avatar lên: \(error?.localizedDescription ?? "Lỗi không xác định")")
                        return
                    }
                    
                    let userInfo = User(uid: uid, email: email, password: password, name: name, userName: userName, birthdate: birthdate)
                    FirestoreManager.shared.addUserInfo(userInfo: userInfo)
                    self.view.makeToast("Thông tin người dùng đã được thêm vào Firestore.")
                    
                    self.avatarBtn.hideLoader()
                    let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    let signUp7VC = mainStoryboard.instantiateViewController(withIdentifier: "SignUp7ViewController") as! SignUp7ViewController
                    signUp7VC.modalPresentationStyle = .fullScreen
                    signUp7VC.modalTransitionStyle = .crossDissolve
                    self.present(signUp7VC, animated: true, completion: nil)
                }
            } else {
                print("Lỗi: Không thể chuyển đổi ảnh avatar thành dữ liệu.")
            }
            
        }
        
    }

}
