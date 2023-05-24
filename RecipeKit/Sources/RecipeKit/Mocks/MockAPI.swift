import Foundation

public struct MockAPI: RecipeAPI {
    
    public func recipes(for category: String, sort: RecipeSortOrder) -> [Recipe] {
        return []
    }
    
    public func recipe(id: String) -> Recipe {
        return Recipe(id: "", name: "", tags: [], thumbnailURL: URL(fileURLWithPath: ""))
    }
}
