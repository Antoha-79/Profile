//
//  Profile.swift
//  2022-01-13_practic-Profil
//
//  Created by Anton Dovnar on 13.01.22.
//

import UIKit

enum Gender: String, CaseIterable {  // CaseIterable создает массив из enum
    case male = "Мужской"
    case female = "Женский"
    case unknown = "Не указан"
    
    static var allStringCases: [String] {
        return allCases.map {gender in
            return gender.rawValue
        }
    }
}

enum Relationship: CaseIterable {
    case marrieged
    case engaged
    case free
    case complicate
    case none
    
    func getTitle(gender: Gender) -> String {
        switch self {
        case .marrieged where gender == .male: return "Женат"
        case .marrieged where gender == .female: return "Замужем"
        case .marrieged:                        return "Женат\\Замужем"
        case .engaged where gender == .male: return "Помолвлен"
        case .engaged where gender == .female: return "Помолвлена"
        case .engaged:                        return "Помолвлен(а)"
        case .free where gender == .male: return "Свободен"
        case .free where gender == .female: return "Свободна"
        case .free:                        return "Свобод(ен\\на)"
        case .complicate: return "Все сложно"
        case .none: return "Не указано"
        }
        
    }
    
    static func getAllStringCases(_ gender: Gender) -> [String] {
        return allCases.map { type in
            return type.getTitle(gender: gender)
        }
    }
}

struct PersonalInfo {
    var birthday: Date?
    var gender: Gender = .unknown
    var phone: String?
    var email: String?
}

struct AdditionalInfo {
    var position: String?
    var company: String?
    var relationship: Relationship = .none
}

struct Profile {
    var name: String?
    var avatar: UIImage?
    var personalInfo = PersonalInfo()
    var additionalInfo = AdditionalInfo()
}


