//
//  HomeVC.swift
//  2022-01-13_practic-Profil
//
//  Created by Anton Dovnar on 13.01.22.
//

import UIKit

class HomeVC: UIViewController {

    @IBOutlet private weak var avatarImageView: UIImageView!
        @IBOutlet private weak var nameLabel: UILabel!
        
        @IBOutlet private weak var birthdayLabel: UILabel!
        @IBOutlet private weak var genderLabel: UILabel!
        @IBOutlet private weak var phoneLabel: UILabel!
        @IBOutlet private weak var emailLabel: UILabel!
        
        @IBOutlet private weak var companyLabel: UILabel!
        @IBOutlet private weak var positionLabel: UILabel!
        @IBOutlet private weak var relationshipStatusLabel: UILabel!
    
    var profile = Profile() {
        didSet {
            
        // Имя
            if let newName = profile.name,  // запятая - это значит,что сначала проверка одна (на опциональность), потом вторая (на не пусто ли)
               !newName.isEmpty {
                nameLabel.text = newName
            } else {
                nameLabel.text = "Аноним"
            }
            
        // Фото аватара
            avatarImageView.image = profile.avatar
            
// Персональные данные
            
        // Дата рождения
            if let selectedDate = profile.personalInfo.birthday,
            selectedDate != Date() {
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "ru_RU")
            dateFormatter.dateFormat = "dd MMMM yyyy"
            birthdayLabel.text = dateFormatter.string(from: selectedDate)
                        }
            
        // Пол
            genderLabel.text = profile.personalInfo.gender.rawValue
            
        // Телефон
            if let newPhone = profile.personalInfo.phone,
               !newPhone.isEmpty {
                phoneLabel.text = newPhone
            } else {
                phoneLabel.text = "Не указан"
            }
           
        // E-mail
            if let newEmail = profile.personalInfo.email,
               !newEmail.isEmpty {
                emailLabel.text = newEmail
            } else {
                emailLabel.text = "Не указан"
            }
            
            
// Доп.информация
            
        // Должность
            if let newPosition = profile.additionalInfo.position,
               !newPosition.isEmpty {
                positionLabel.text = newPosition
            } else {
                positionLabel.text = "Не указана"
            }
   
        // Компания
            if let newCompany = profile.additionalInfo.company,
               !newCompany.isEmpty {
                companyLabel.text = newCompany
            } else {
                companyLabel.text = "Не указана"
            }
        
        // Семейное положение
            relationshipStatusLabel.text =
            profile.additionalInfo.relationship.getTitle(gender: profile.personalInfo.gender)

        }
    }
    
    @IBAction private func editDidTap() {
        let nextVC = EditNC.getVC(storyboard: .main)
        nextVC.profile = profile
        nextVC.editDelegate = self
        present(nextVC, animated: true, completion: nil)
    }
    
     
    override func viewDidLoad() {
        super.viewDidLoad()

        

    }
    

}


extension HomeVC: EditProfileDelegate {
    
    func didSave(profile: Profile) {
        self.profile = profile
    }
    
}


