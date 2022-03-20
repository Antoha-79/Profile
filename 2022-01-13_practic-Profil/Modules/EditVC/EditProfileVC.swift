//
//  EditProfileVC.swift
//  2022-01-13_practic-Profil
//
//  Created by Anton Dovnar on 13.01.22.
//

import UIKit

protocol EditProfileVCDelegate {
    func didSave(profile: Profile)
}

final class EditProfileVC: UIViewController {

    @IBOutlet private weak var nameTextField: UITextField!
    @IBOutlet private weak var avatarImageView: UIImageView!


    var cashProfile: Profile?
    var delegate: EditProfileVCDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameTextField.placeholder = "Введите имя"
        nameTextField.text = cashProfile?.name
        avatarImageView.image = cashProfile?.avatar
        
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        nameTextField.resignFirstResponder()
    }
    
    
    @IBAction func didLongTapView(_: UILongPressGestureRecognizer) {
        
        if avatarImageView.image != nil {
       
        let alert = UIAlertController(title: "Удаление", message: "Вы хотите удалить фото?", preferredStyle: .alert)
        
        let cancelButton  = UIAlertAction(title: "Нет", style: .cancel) { action in
            alert.dismiss(animated: true, completion: nil)
        }
        alert.addAction(cancelButton)
        
        let removeButton  = UIAlertAction(title: "Да", style: .destructive) { action in
            self.avatarImageView.image = nil
        }
        alert.addAction(removeButton)
        
        present(alert, animated: true, completion: nil)
         
        } else {
            let alert = UIAlertController(title: "Ошибка удаления", message: "Нет фотографии!", preferredStyle: .alert)
            
            let oklButton  = UIAlertAction(title: "Ok", style: .default) { action in
                alert.dismiss(animated: true, completion: nil)
            }
            alert.addAction(oklButton)
    
            present(alert, animated: true, completion: nil)
        }
        
    }
    
    
    
    @IBAction private func saveDidTap() {
        
        if let newName = nameTextField.text,  // запятая - это значит,что сначала проверка одна (на опциональность), потом вторая (на не пусто ли)
           !newName.isEmpty {
            cashProfile?.name = newName
        } else {
            cashProfile?.name = "Аноним"
        }
        
        cashProfile?.avatar = avatarImageView.image
        
        if let profile = cashProfile {
            delegate?.didSave(profile: profile)
        }
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction private func openGalleryDidTap() {
        let picker = UIImagePickerController()
        picker.delegate = self
        present(picker, animated: true, completion: nil)
        
    }
    
}

extension EditProfileVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        avatarImageView.image = info[.originalImage] as? UIImage
        
        picker.dismiss(animated: true, completion: nil)
        
    }
}
