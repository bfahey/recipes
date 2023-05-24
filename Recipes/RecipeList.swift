//
//  RecipeList.swift
//  Recipes
//
//  Created by Blaine Fahey on 5/23/23.
//

import RecipeKit
import SwiftUI

struct RecipeList: View {
    @EnvironmentObject var model: RecipeModel
    @State private var sort = RecipeSortOrder.name
    @Binding var selection: Recipe.ID?
    
    var sortedRecipes: [Recipe] {
        model.recipes(sortedBy: sort)
    }
    
    var body: some View {
        List(selection: $selection) {
            ForEach(sortedRecipes) { recipe in
                NavigationLink(value: recipe) {
                    RecipeRow(recipe: recipe)
                }
            }
        }
        .navigationTitle("Desserts")
        .navigationDestination(for: Recipe.self) { recipe in
            RecipeDetails(recipe: model.recipeBinding(id: recipe.id))
        }
        .task {
            do {
                try await model.fetchRecipes()
            } catch {
                // handle error
            }
        }
    }
}

struct RecipeList_Previews: PreviewProvider {
    struct PreviewWrapper: View {
        @State private var selection: Recipe.ID? = Recipe.preview.id
        
        var body: some View {
            RecipeList(selection: $selection)
                .environmentObject(RecipeModel.preview)
        }
    }
    
    static var previews: some View {
        PreviewWrapper()
    }
}
