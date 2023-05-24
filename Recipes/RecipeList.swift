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
    
    var body: some View {
        List {
            ForEach(model.recipes) { recipe in
                RecipeRow(recipe: recipe)
            }
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
    static var previews: some View {
        RecipeList()
            .environmentObject(RecipeModel.preview)
    }
}
