//
//  ContentView.swift
//  Recipes
//
//  Created by Blaine Fahey on 5/23/23.
//

import RecipeKit
import SwiftUI

struct ContentView: View {
    @EnvironmentObject var model: RecipeModel
    @SceneStorage("selection") private var selectedRecipeID: Recipe.ID?

    var body: some View {
        NavigationStack {
            RecipeList(selection: $selectedRecipeID)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(RecipeModel.preview)
    }
}
