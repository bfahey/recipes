//
//  ContentView.swift
//  Recipes
//
//  Created by Blaine Fahey on 5/23/23.
//

import RecipeKit
import SwiftUI

struct ContentView: View {
    var body: some View {
        RecipeList()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(RecipeModel.preview)
    }
}
