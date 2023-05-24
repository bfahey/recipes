//
//  RecipeDetails.swift
//  Recipes
//
//  Created by Blaine Fahey on 5/23/23.
//

import RecipeKit
import SwiftUI

struct RecipeDetails: View {
    @Binding var selection: Recipe?
    @State var headerHeight: CGFloat = 250.0
    
    var body: some View {
        if let recipe = selection {
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
        } else {
            Text("Select a recipe")
                .font(.largeTitle)
                .foregroundColor(.secondary)
        }
    }
}

struct RecipeDetails_Previews: PreviewProvider {
    struct PreviewWrapper: View {
        @State private var selection: Recipe? = .preview
        
        var body: some View {
            RecipeDetails(selection: $selection)
                .environmentObject(RecipeModel.preview)
        }
    }
    
    static var previews: some View {
        PreviewWrapper()
    }
}
