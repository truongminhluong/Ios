//
//  CameraViewController.swift
//  Instagram
//
//  Created by Trương Minh Lượng Jr on 12/3/24.
//

import UIKit

class CameraViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var myView: UIView!
    @IBOutlet weak var closeImage: UIImageView!
    @IBOutlet weak var labraryCameraLabel: UILabel!
    @IBOutlet weak var cameraLabel: UILabel!
    @IBOutlet weak var closeAvatarLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    private func setupUI() {
        setup()
        setupGestures()
    }
    
    private func setup() {
        myView.backgroundColor = UIColor(red: 27/255, green: 27/255, blue: 27/255, alpha: 1.0)
        
        labraryCameraLabel.layer.cornerRadius = 10
        labraryCameraLabel.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        labraryCameraLabel.layer.masksToBounds = true
        labraryCameraLabel.backgroundColor = UIColor(red: 52/255, green: 52/255, blue: 51/255, alpha: 1.0)
        
        cameraLabel.layer.masksToBounds = true
        cameraLabel.backgroundColor = UIColor(red: 52/255, green: 52/255, blue: 51/255, alpha: 1.0)
        
        closeAvatarLabel.layer.cornerRadius = 10
        closeAvatarLabel.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        closeAvatarLabel.layer.masksToBounds = true
        closeAvatarLabel.backgroundColor = UIColor(red: 52/255, green: 52/255, blue: 51/255, alpha: 1.0)
    }
    
    private func setupGestures() {
        
        let labreryTapGesture = UITapGestureRecognizer(target: self, action: #selector(clickLabraryCamera))
        labraryCameraLabel.addGestureRecognizer(labreryTapGesture)
        labraryCameraLabel.isUserInteractionEnabled = true
        
        let cameraTapGesture = UITapGestureRecognizer(target: self, action: #selector(clickCamera))
        cameraLabel.addGestureRecognizer(cameraTapGesture)
        cameraLabel.isUserInteractionEnabled = true
        
        let closeAvatarTapGesture = UITapGestureRecognizer(target: self, action: #selector(clickCloseAvatar))
        closeImage.addGestureRecognizer(closeAvatarTapGesture)
        closeImage.isUserInteractionEnabled = true
    }
    
    @objc func clickLabraryCamera() {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        
        // Hiển thị UIImagePickerController để chọn ảnh
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        // Lấy ảnh được chọn
        if let selectedImage = info[.originalImage] as? UIImage {
            
            picker.dismiss(animated: true) {
                if let signUp6VC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SignUp6ViewController") as? SignUp6ViewController {
                    signUp6VC.selectedImage = selectedImage
                    signUp6VC.modalPresentationStyle = .fullScreen
                    self.present(signUp6VC, animated: true, completion: nil)
                } else {
                    print("No image selected")
                }
            }
            
        }
        
    }
    
    @objc func clickCamera() {
        print("b")
        
    }
    
    @objc func clickCloseAvatar() {
        dismiss(animated: true, completion: nil)
        
    }

}
