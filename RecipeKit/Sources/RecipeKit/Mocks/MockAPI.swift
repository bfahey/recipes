import Foundation

public struct MockAPI: RecipeAPI {
    
    public init() {}
    
    public func recipes(for category: String) async throws -> [Recipe] {
        let data = loadTestData(name: "desserts.json")
        let response = try JSONDecoder().decode(MealDBResponse.self, from: data)
        return response.recipes
    }
    
    public func recipe(id: String) async throws -> Recipe {
        let data = loadTestData(name: "carrotcake.json")
        let response = try JSONDecoder().decode(MealDBResponse.self, from: data)
        return response.recipes.first!
    }
}
