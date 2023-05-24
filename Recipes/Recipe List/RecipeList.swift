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
    @State private var searchText = ""
    
    var sortedRecipes: [Recipe] {
        model.recipes(sortedBy: sort).filter { recipe in
            recipe.matches(searchText: searchText)
        }
    }
    
    var body: some View {
        List {
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
        .searchable(text: $searchText)
        .task {
            do {
                try await model.fetchRecipes()
            } catch {
                // FIXME: Display errors in an alert.
            }
        }
    }
}

struct RecipeList_Previews: PreviewProvider {
    static var previews: some View {
        RecipeList()
            .environmentObject(RecipeModel.preview)
    }
}
