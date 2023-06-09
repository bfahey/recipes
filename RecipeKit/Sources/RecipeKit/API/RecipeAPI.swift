import Foundation

public protocol RecipeAPI {
    func recipes(for category: String) async throws -> [Recipe]
    func recipe(id: String) async throws -> Recipe
}

public enum RecipeSortOrder: Hashable {
    case name
}
