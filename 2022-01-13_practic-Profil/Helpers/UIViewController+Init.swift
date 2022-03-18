//
//  UIViewController+Init.swift
//  2022-01-13_practic-Profil
//
//  Created by Anton Dovnar on 13.01.22.
//

import UIKit

extension UIViewController {
    
   static func getVC(storyboard: UIStoryboard) -> Self {
        return storyboard.instantiateViewController(withIdentifier: "\(Self.self)") as! Self
        
    }
    
}

