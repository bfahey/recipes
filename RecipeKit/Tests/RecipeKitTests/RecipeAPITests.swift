import XCTest
@testable import RecipeKit

final class RecipeAPITests: XCTestCase {
    
    var realAPI: RecipeAPI!
    var mockAPI: RecipeAPI!
    
    override func setUp() {
        realAPI = MealDB()
        mockAPI = MockAPI()
    }
    
    func testDesserts() async throws {
        let realDesserts = try await realAPI.recipes(for: "Dessert")
        let mockDesserts = try await mockAPI.recipes(for: "Dessert")
        XCTAssertEqual(realDesserts, mockDesserts)
    }
    
    func testCarrotCake() async throws {
        let id = "52897"
        let realCake = try await realAPI.recipe(id: id)
        let mockCake = try await mockAPI.recipe(id: id)
        XCTAssertEqual(realCake, mockCake)
    }
}
