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
    let headerHeight: CGFloat = 250.0
    
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
            if !recipe.ingredients.isEmpty {
                Section {
                    ForEach(recipe.ingredients) { ingredient in
                        IngredientRow(ingredient: ingredient)
                    }
                } header: {
                    Text("Ingredients")
                }
                .headerProminence(.increased)
            }
            let instructions = recipe.instructions.enumeratedArray()
            if !instructions.isEmpty {
                Section {
                    ForEach(instructions, id: \.0) { idx, step in
                        InstructionStepRow(number: idx+1, instructions: step)
                    }
                } header: {
                    Text("Instructions")
                }
                .headerProminence(.increased)
            }
        }
        .listStyle(.plain)
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                if let youTubeURL = recipe.youTubeURL {
                    Button {
                        UIApplication.shared.open(youTubeURL)
                    } label: {
                        Label("Watch on YouTube", systemImage: "play.rectangle")
                    }
                }
                if let sourceURL = recipe.sourceURL {
                    ShareLink(item: sourceURL)
                }
            }
        }
        .task {
            guard recipe != .noRecipe else { return }
            do {
                try await model.fetchRecipe(id: recipe.id)
            } catch {
                // FIXME: Display errors in an alert.
            }
        }
    }
}

extension Collection {
    /// Not all sequences are zero indexed so we need to zip by the collection's indicies.
    /// https://stackoverflow.com/a/63145650
    func enumeratedArray() -> Array<(Index, Element)> {
        Array(zip(self.indices, self))
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
