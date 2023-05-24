import Foundation

public protocol RecipeAPI {
    func recipes(for category: String, sort: RecipeSortOrder) -> [Any]
    func recipe(id: String) -> Any
}

public enum RecipeSortOrder: Hashable {
    case name
}
