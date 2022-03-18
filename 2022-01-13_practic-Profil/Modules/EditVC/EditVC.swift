//
//  EditVC.swift
//  2022-01-13_practic-Profil
//
//  Created by Anton Dovnar on 13.01.22.
//

import UIKit

class EditVC: UIViewController {

    var cashedProfile: Profile?
    var editDelegate: EditProfileDelegate?
    

    @IBAction func cancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)  // закрывает текущий экран и переходит к предыдущему
        
        //let newVC = storyboard?.instantiateViewController(withIdentifier: "HomeVC") as! HomeVC
       // navigationController?.pushViewController(newVC, animated: true)
        
    }
    
    @IBAction func save(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
        guard let profile = cashedProfile else { return }
        editDelegate?.didSave(prifile: profile)
       // editDelegate?.didSave(personalInfo: profile.personalInfo)
        
    }
    
    @IBAction private func profileDidTap() {
        let nextVC = EditProfileVC.getVC(storyboard: .main)
        nextVC.delegate = self
        nextVC.cashProfile = cashedProfile
        navigationController?.pushViewController(nextVC, animated: true)
    }
    
    @IBAction private func personalInfoDidTap() {
        let nextVC = EditPersonalInfoVC.getVC(storyboard: .main)
        nextVC.personalInfoDelegate = self
        nextVC.cachedPersonalInfo = cashedProfile?.personalInfo
        navigationController?.pushViewController(nextVC, animated: true)
    }
    
    @IBAction private func additionalInfoDidTap() {
        let nextVC = EditAdditionalInfoVC.getVC(storyboard: .main)
        nextVC.addDelegate = self
        nextVC.cachedPersonalInfo = cashedProfile?.personalInfo
        nextVC.cachedAdditionalInfo = cashedProfile?.additionalInfo
        navigationController?.pushViewController(nextVC, animated: true)
    }
    
}

extension EditVC: EditProfileVCDelegate, EditPersonalInfoVCDelegate, EditAdditionalInfoVCDelegate {
    func didSave(profile: Profile) {
        cashedProfile = profile
    }
    func didSave(personalInfo: PersonalInfo) {
        cashedProfile?.personalInfo = personalInfo
    }
    func didSave(additionalInfo: AdditionalInfo) {
        cashedProfile?.additionalInfo = additionalInfo
    }
    
}
