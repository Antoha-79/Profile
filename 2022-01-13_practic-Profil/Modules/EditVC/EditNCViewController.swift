//
//  EditNCViewController.swift
//  2022-01-13_practic-Profil
//
//  Created by Anton Dovnar on 13.01.22.
//

import UIKit

protocol EditProfileDelegate {
    func didSave(prifile: Profile)
}

class EditNC: UINavigationController {

    var editDelegate: EditProfileDelegate?
    var profile: Profile?
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let rootVC = viewControllers.first as? EditVC {
            rootVC.cashedProfile = profile
            rootVC.editDelegate = editDelegate
        }
    }
    
}
