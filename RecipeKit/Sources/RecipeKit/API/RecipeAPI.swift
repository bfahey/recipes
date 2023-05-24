import Foundation

protocol RecipeAPI {
    func recipes(for category: String, sort: RecipeSortOrder) -> [Any]
    func recipe(id: String) -> Any
}

enum RecipeSortOrder: Hashable {
    case name
}
