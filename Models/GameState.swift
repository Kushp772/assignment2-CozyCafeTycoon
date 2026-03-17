//
//  GameState.swift
//  
//
//  Created by Kush on 3/17/26.
//

import Foundation

/// Represents app/game state
enum GameState {
    
    case loading
    case loaded([Recipe])   // ← associated value
    case error(String)      // ← associated value
    case empty
}
