//
//  Recipe.swift
//  
//
//  Created by Kush on 3/17/26.
//
import Foundation

/// Represents a recipe in the café game
struct Recipe: Identifiable {
    
    /// Unique ID
    let id = UUID()
    
    /// Name of the recipe
    var name: String
    
    /// Type of recipe (drink, pastry, etc.)
    var category: RecipeCategory
    
    /// Price earned
    var price: Double
    
    /// Prep time in seconds
    var prepTime: Int
    
    /// Is unlocked or not
    var isUnlocked: Bool
    
    /// Optional image name
    var imageName: String? = nil
    
    
    /// Computed property (required)
    var formattedPrice: String {
        "$\(price)"
    }
    
    /// Another computed property (extra clean)
    var isPremium: Bool {
        price >= 5.0
    }
}
