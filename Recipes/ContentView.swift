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

    var body: some View {
        NavigationStack {
            RecipeList()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(RecipeModel.preview)
    }
}
