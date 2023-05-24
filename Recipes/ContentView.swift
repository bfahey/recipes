//
//  ContentView.swift
//  Recipes
//
//  Created by Blaine Fahey on 5/23/23.
//

import RecipeKit
import SwiftUI

struct ContentView: View {
    @State private var selection: Recipe?
    @State private var path = NavigationPath()
    
    var body: some View {
        NavigationSplitView {
            RecipeList(selection: $selection)
        } detail: {
            NavigationStack(path: $path) {
                RecipeDetails(selection: $selection)
            }
        }
        .onChange(of: selection) { _ in
            path.removeLast(path.count)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(RecipeModel.preview)
    }
}
