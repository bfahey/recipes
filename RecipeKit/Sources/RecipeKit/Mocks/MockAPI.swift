import Foundation

public struct MockAPI: RecipeAPI {
    
    public func recipes(for category: String, sort: RecipeSortOrder) -> [Any] {
        return []
    }
    
    public func recipe(id: String) -> Any {
        return ""
    }
}
