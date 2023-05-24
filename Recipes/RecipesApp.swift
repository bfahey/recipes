//
//  RecipesApp.swift
//  Recipes
//
//  Created by Blaine Fahey on 5/23/23.
//

import RecipeKit
import SwiftUI

@main
struct RecipesApp: App {
    @StateObject private var model = RecipeModel(api: MealDB())
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(model)
        }
    }
}
