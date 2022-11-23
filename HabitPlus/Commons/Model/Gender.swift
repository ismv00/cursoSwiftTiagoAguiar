//
//  Gender.swift
//  HabitPlus
//
//  Created by Igor S. Menezes on 10/09/22.
//

import Foundation

enum Gender : String , CaseIterable, Identifiable {
    case male = "Masculino"
    case feminino = "Feminino"
    
    var id : String {
        self.rawValue
    }
    
    var index: Self.AllCases.Index {
        return Self.allCases.firstIndex { self == $0 } ?? 0
    }
}
