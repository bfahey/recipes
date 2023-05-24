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
    @Binding var selection: Recipe?
    
    var body: some View {
        List(selection: $selection) {
            ForEach(model.recipes) { recipe in
                NavigationLink(value: recipe) {
                    RecipeRow(recipe: recipe)
                }
            }
        }
        .navigationTitle("Desserts")
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
        @State private var selection: Recipe? = .preview
        
        var body: some View {
            RecipeList(selection: $selection)
                .environmentObject(RecipeModel.preview)
        }
    }
    
    static var previews: some View {
        PreviewWrapper()
    }
}
