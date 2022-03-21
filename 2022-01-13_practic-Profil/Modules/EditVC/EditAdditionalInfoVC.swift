//
//  EditAdditionalInfoVC.swift
//  2022-01-13_practic-Profil
//
//  Created by Anton Dovnar on 18.01.22.
//

import UIKit

protocol EditAdditionalInfoVCDelegate {
    func didSave(additionalInfo: AdditionalInfo)
}

class EditAdditionalInfoVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var companyTextField: UITextField!
    @IBOutlet weak var positionTextField: UITextField!
    @IBOutlet weak var relationshipTextField: UITextField!
    
    private var  relationshipPicker: UIPickerView!
   
    var cachedPersonalInfo: PersonalInfo?  //  что бы добраться до Gender
    var cachedAdditionalInfo: AdditionalInfo?
    var addDelegate: EditAdditionalInfoVCDelegate?
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    
    }
    

    private func setup() {
        companyTextField.placeholder = "Укажите компанию, где работаете"
            if cachedAdditionalInfo?.company == "Не указана" {
                companyTextField.text = ""
            } else {
                companyTextField.text = cachedAdditionalInfo?.company
            }
                
        positionTextField.placeholder = "Укажите должность"
            if cachedAdditionalInfo?.position == "Не указана" {
                positionTextField.text = ""
            } else {
                positionTextField.text = cachedAdditionalInfo?.position
            }
        
        relationshipPicker = UIPickerView()
        relationshipPicker.delegate = self
        relationshipPicker.dataSource = self
        
        let gender = cachedPersonalInfo?.gender ?? .unknown
        relationshipTextField.text = cachedAdditionalInfo?.relationship.getTitle(gender: gender)
        relationshipTextField.inputView = relationshipPicker
        
       // relationshipPicker.showsSelectionIndicator = true
    }

    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Relationship.allCases.count  
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
       // self.view.endEditing(true)
        let gender = cachedPersonalInfo?.gender ?? .unknown // избавляемся от опционала установив дефолтное значение "не указан пол"
        return Relationship.getAllStringCases(gender)[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let gender = cachedPersonalInfo?.gender ?? .unknown
        relationshipTextField.text = Relationship.getAllStringCases(gender)[row]
        
        cachedAdditionalInfo?.relationship = Relationship.allCases[row]
        //self.relationshipTextField.resignFirstResponder()
        self.relationshipPicker.isHidden = false
    }
    
    
    
    
    @IBAction private func saveDidTap() {
        
        if let newCompany = companyTextField.text,
           !newCompany.isEmpty {
            cachedAdditionalInfo?.company = newCompany
        } else {
            cachedAdditionalInfo?.company = "Не указана"
        }
        
        if let newPosition = positionTextField.text,
           !newPosition.isEmpty {
            cachedAdditionalInfo?.position = newPosition
        } else {
            cachedAdditionalInfo?.position = "Не указана"
        }
        
        
        if let additionalInfo = cachedAdditionalInfo {
            addDelegate?.didSave(additionalInfo: additionalInfo)
        }
        navigationController?.popViewController(animated: true)
    }
    
    

}
