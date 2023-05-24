//
//  RecipeDetails.swift
//  Recipes
//
//  Created by Blaine Fahey on 5/23/23.
//

import RecipeKit
import SwiftUI

struct RecipeDetails: View {
    @EnvironmentObject var model: RecipeModel
    
    @Binding var recipe: Recipe
    @State var headerHeight: CGFloat = 250.0
    
    var body: some View {
        List {
            Section {
                EmptyView()
            } header: {
                Text(recipe.name)
            } footer: {
                AsyncImage(url: recipe.imageURL) { image in
                    image.resizable().scaledToFill()
                        .frame(height: headerHeight)
                        .clipped()
                } placeholder: {
                    Color(.quaternarySystemFill)
                }
                .frame(height: headerHeight)
            }
            .headerProminence(.increased)
            if let ingredients = recipe.ingredients {
                Section {
                    ForEach(ingredients) { ingredient in
//                        LabeledContent(ingredient.name.capitalized, value: ingredient.measurement)
                        IngredientRow(ingredient: ingredient)
                    }
                } header: {
                    Text("Ingredients")
                }
                .headerProminence(.increased)
            }
            Section {
                if let instructions = recipe.instructions {
                    Text(instructions)
                        .font(.body)
                }
            } header: {
                Text("Instructions")
            }
            .headerProminence(.increased)
        }
        .listStyle(.plain)
        .task {
            guard recipe != .noRecipe else { return }
            do {
                try await model.fetchRecipe(id: recipe.id)
            } catch {
                // handle error
            }
        }
    }
}

struct RecipeDetails_Previews: PreviewProvider {
    struct PreviewWrapper: View {
        @State private var selection: Recipe = .preview
        
        var body: some View {
            RecipeDetails(recipe: $selection)
                .environmentObject(RecipeModel.preview)
        }
    }
    
    static var previews: some View {
        PreviewWrapper()
    }
}
