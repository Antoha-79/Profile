//
//  EditPersonalInfoVC.swift
//  2022-01-13_practic-Profil
//
//  Created by Anton Dovnar on 15.01.22.
//

import UIKit

protocol EditPersonalInfoVCDelegate {
    func didSave(personalInfo: PersonalInfo)
}

class EditPersonalInfoVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    
    @IBOutlet private weak var birthdayTextField: UITextField!
    @IBOutlet private weak var genderTextField: UITextField!
    @IBOutlet private weak var phoneTextField: UITextField!
    @IBOutlet private weak var emailTextField: UITextField!
    
    private var genderPicker: UIPickerView!
    private var birthdayPicker: UIDatePicker!
    
    var cachedPersonalInfo: PersonalInfo?
    var personalInfoDelegate: EditPersonalInfoVCDelegate?

 

// функция что бы скрыть "крутилку" при тапе на UIViewController вне TextField
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    

/*
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        birthdayTextField.resignFirstResponder()
        genderTextField.resignFirstResponder()
        phoneTextField.resignFirstResponder()
        emailTextField.resignFirstResponder()
    }
*/
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBirthdateTextField()
        setup()
        
    }
    
    private func setupBirthdateTextField() {
        let datePicker = UIDatePicker()
        datePicker.locale = Locale(identifier: "ru_RU")
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        birthdayTextField.inputView = datePicker
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ru_RU")
        dateFormatter.dateFormat = "dd MMMM yyyy"
        birthdayTextField.text = dateFormatter.string(from: cachedPersonalInfo?.birthday ?? Date())
         //т.е. видим в поле кешированную дату или по умолчению - сегодняшнюю дату
        
        datePicker.addTarget(self, action: #selector(birthdayPickerDidChange(sender:)), for: .valueChanged)
    }
   
    @objc func birthdayPickerDidChange(sender: UIDatePicker) {
        let selectedDate = sender.date
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ru_RU")
        dateFormatter.dateFormat = "dd MMMM yyyy"
        birthdayTextField.text = dateFormatter.string(from: selectedDate)
        
        cachedPersonalInfo?.birthday = sender.date
    }
    
    
    
    private func setup() {
        
        genderPicker = UIPickerView()
        genderPicker.delegate = self
        genderPicker.dataSource = self
        
    
        genderTextField.text = cachedPersonalInfo?.gender.rawValue
        genderTextField.inputView = genderPicker
        
        
        phoneTextField.placeholder = "Укажите телефон"
        if cachedPersonalInfo?.phone == "Не указан" {
            phoneTextField.text = ""
        } else {
        phoneTextField.text = cachedPersonalInfo?.phone
        }
        
        emailTextField.placeholder = "Укажите email"
        if cachedPersonalInfo?.email == "Не указан" {
            emailTextField.text = ""
        } else {
            emailTextField.text = cachedPersonalInfo?.email
        }
        
    }
 
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int{
        return 1
    }

    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        return Gender.allStringCases.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        //self.view.endEditing(true)
        return Gender.allStringCases[row]
    }
    

    

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.genderTextField.text = Gender.allStringCases[row]
        
        if Gender.allStringCases[row] == Gender.allStringCases.last {
            cachedPersonalInfo?.gender = Gender.allCases.last!
        } else {
            cachedPersonalInfo?.gender = Gender.allCases[row]
        }
        
        //genderTextField.resignFirstResponder()
        genderPicker.isHidden = false
        

    }
 
 
    @IBAction private func saveDidTap() {
        
        if let newPhone = phoneTextField.text,
           !newPhone.isEmpty {
            cachedPersonalInfo?.phone = newPhone
        } else {
            cachedPersonalInfo?.phone = "Не указан"
        }
        
        if let newEmail = emailTextField.text,
           !newEmail.isEmpty {
            cachedPersonalInfo?.email = newEmail
        } else {
            cachedPersonalInfo?.email = "Не указан"
        }
        
        
        if let personalInfo = cachedPersonalInfo {
            personalInfoDelegate?.didSave(personalInfo: personalInfo)
        }
        navigationController?.popViewController(animated: true)
    }



}


