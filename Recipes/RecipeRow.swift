//
//  RecipeRow.swift
//  Recipes
//
//  Created by Blaine Fahey on 5/23/23.
//

import SwiftUI
import RecipeKit

struct RecipeRow: View {
    var recipe: Recipe
    
    var body: some View {
        HStack {
            let imageShape = RoundedRectangle(cornerRadius: 4, style: .continuous)
            AsyncImage(url: recipe.thumbnailURL, content: { image in
                image.resizable().clipShape(imageShape)
            }, placeholder: {
                Color(.gray)
            })
            .frame(width: 50, height: 50)
            .background(in: imageShape)
            .overlay {
                imageShape.strokeBorder(.quaternary, lineWidth: 0.5)
            }
            Text(recipe.name)
                .font(.body)
        }
    }
}

struct RecipeRow_Previews: PreviewProvider {
    static var previews: some View {
        RecipeRow(recipe: .preview)
    }
}
