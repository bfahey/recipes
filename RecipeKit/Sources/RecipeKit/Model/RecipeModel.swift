import SwiftUI

@MainActor
public final class RecipeModel: ObservableObject {
    @Published public var recipes: [Recipe] = []
    
    private let api: RecipeAPI
    
    public init(api: RecipeAPI) {
        self.api = api
    }
    
    public subscript(id: Recipe.ID?) -> Recipe {
        get {
            if let id {
                return recipes.first(where: { $0.id == id }) ?? .noRecipe
            }
            return .noRecipe
        }
        set(newValue) {
            if let id, let index = recipes.firstIndex(where: { $0.id == id }) {
                recipes[index] = newValue
            } else {
                recipes.append(newValue)
            }
        }
    }
    
    public func recipeBinding(id: Recipe.ID) -> Binding<Recipe> {
        Binding<Recipe> {
            self[id]
        } set: { newValue in
            self[id] = newValue
        }
    }
    
    public func updateRecipe(id: Recipe.ID, to newValue: Recipe) {
        recipeBinding(id: id).wrappedValue = newValue
    }
    
    public func recipes(sortedBy sort: RecipeSortOrder = .name) -> [Recipe] {
        switch sort {
        case .name:
            return recipes.sorted { $0.name.localizedCompare($1.name) == .orderedAscending }
        }
    }
    
    public func fetchRecipes(category: String = "Dessert") async throws {
        recipes = try await api.recipes(for: category)
    }
    
    public func fetchRecipe(id: String) async throws {
        let updatedRecipe = try await api.recipe(id: id)
        updateRecipe(id: id, to: updatedRecipe)
    }
}

public extension RecipeModel {
    static var preview = RecipeModel(api: MockAPI())
}
