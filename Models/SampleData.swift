//
//  SampleData.swift
//  
//
//  Created by Kush on 3/17/26.
//
import Foundation

extension Recipe {
    
    static let sampleData: [Recipe] = [
        
        Recipe(
            name: "Latte",
            category: .drink,
            price: 4.5,
            prepTime: 30,
            isUnlocked: true
        ),
        
        Recipe(
            name: "Cappuccino",
            category: .drink,
            price: 4.75,
            prepTime: 35,
            isUnlocked: false
        ),
        
        Recipe(
            name: "Mocha",
            category: .drink,
            price: 5.25,
            prepTime: 40,
            isUnlocked: true
        ),
        
        Recipe(
            name: "Croissant",
            category: .pastry,
            price: 3.25,
            prepTime: 20,
            isUnlocked: true
        ),
        
        Recipe(
            name: "Blueberry Muffin",
            category: .pastry,
            price: 3.75,
            prepTime: 25,
            isUnlocked: false
        )
    ]
}
