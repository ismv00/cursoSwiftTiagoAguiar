//
//  SplashInteractor.swift
//  HabitPlus
//
//  Created by Igor S. Menezes on 26/11/22.
//

import Foundation
import Combine

class SplashInteractor {
    private let local: LocalDataSource = .shared
}

extension SplashInteractor {
    func fetchAuth() -> Future<UserAuth?, Never> {
        return local.getUserAuth()
    }
}
