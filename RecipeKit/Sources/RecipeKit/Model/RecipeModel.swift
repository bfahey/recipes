import SwiftUI

@MainActor
public final class RecipeModel: ObservableObject {
    @Published public var recipes: [Recipe] = []
    
    private let api: RecipeAPI
    
    public init(api: RecipeAPI) {
        self.api = api
    }
    
    public func recipe(id: Recipe.ID) -> Recipe {
        recipes.first(where: { $0.id == id }) ?? Recipe.noRecipe
    }
    
    public func recipes(sortedBy sort: RecipeSortOrder = .name) -> [Recipe] {
        switch sort {
        case .name:
            return recipes.sorted { $0.name.localizedCompare($1.name) == .orderedAscending }
        }
    }
    
    public func fetchRecipes(category: String = "Dessert") async throws {
        self.recipes = try await api.recipes(for: category)
    }
    
    public func fetchRecipe(id: String) async throws {
        
    }
}

public extension RecipeModel {
    static var preview = RecipeModel(api: MockAPI())
}
