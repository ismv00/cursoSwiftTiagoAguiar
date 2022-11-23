//
//  SignInUIState.swift
//  Habit
//
//  Created by Tiago Aguiar on 04/05/21.
//

import Foundation

enum SignInUIState: Equatable {
  case none
  case loading
  case goToHomeScreen
  case error(String)
}
