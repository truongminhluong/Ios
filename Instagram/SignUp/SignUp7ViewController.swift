//
//  SignUp7ViewController.swift
//  Instagram
//
//  Created by Trương Minh Lượng Jr on 12/3/24.
//

import UIKit
import FirebaseFirestore
import FirebaseStorage
import FirebaseAuth

class SignUp7ViewController: UIViewController {

    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAvatar()
        getData()
    }
    
    private func setupAvatar() {
        avatarImage.layer.cornerRadius = 75
        avatarImage.layer.masksToBounds = true
//        avatarImage.contentMode = .scaleAspectFill
    }
    
    private func getData() {
        guard let uid = Auth.auth().currentUser?.uid else {
            print("Error: User not authenticated.")
            return
        }
        
        print("UID: \(uid)")
        
        
        let db = Firestore.firestore()
        let storage = Storage.storage()
        db.collection("users").document(uid).getDocument { document, error in
            if let error = error {
                print("Error getting user data: \(error.localizedDescription)")
            } else if let document = document, document.exists {
                if let userName = document["userName"] as? String {
                    self.titleLabel.text = "\(userName) ơi, chào mừng bạn đến với Instagram"
                } else {
                    print("Error: Username not found in document.")
                }
                self.fetchAvatarFromStorage(uid: uid, storage: storage)
            } else {
                print("Error: Document does not exist.")
                
            }
        }
        
    }
    
    private func fetchAvatarFromStorage(uid: String, storage: Storage) {
        
            let storageRef = storage.reference().child("avatars/\(uid).jpg")

            // Tải dữ liệu hình ảnh về
        storageRef.getData(maxSize: 1 * 1024 * 1024) { [weak self] data, error in
                guard let self = self else { return }

                if let error = error {
                    print("Lỗi khi tải hình đại diện: \(error.localizedDescription)")
                } else if let data = data {
                    // Chuyển đổi dữ liệu thành UIImage và gán nó cho avatarImage
                    if let image = UIImage(data: data) {
//                        self.avatarImage.image = UIImage(systemName: "heart.fill")
                        print(image)
                        DispatchQueue.main.async {
                            self.avatarImage.image = image
                        }
                    } else {
                        print("Lỗi khi chuyển đổi dữ liệu thành hình ảnh.")
                    }
                }
            }
        }

}
