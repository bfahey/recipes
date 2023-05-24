//
//  IngredientRow.swift
//  Recipes
//
//  Created by Blaine Fahey on 5/24/23.
//

import RecipeKit
import SwiftUI

struct IngredientRow: View {
    var ingredient: Ingredient
    
    var body: some View {
        HStack {
            let url = ingredient.imageURL(thumbnail: true)
            AsyncImage(url: url, content: { image in
                image.resizable()
            }, placeholder: {
                Color(.white)
            })
            .frame(width: 50, height: 50)
            Text(ingredient.name.capitalized)
                .font(.body)
            Spacer()
            Text(ingredient.measurement)
                .foregroundColor(.secondary)
        }
    }
}

struct IngredientRow_Previews: PreviewProvider {
    static var previews: some View {
        IngredientRow(ingredient: Ingredient(name: "Flour", measurement: "2 cups"))
    }
}
