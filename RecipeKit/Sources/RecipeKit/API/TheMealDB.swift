import Foundation

struct TheMealDB: RecipeAPI {
    
    func recipes(for category: String, sort: RecipeSortOrder) -> [Any] {
        return []
    }
    
    func recipe(id: String) -> Any {
        return ""
    }
}
