import XCTest
@testable import RecipeKit

final class MealDBTests: XCTestCase {
    
    var api: MealDB!
    
    override func setUp() {
        api = MealDB()
    }
    
    func testRecipes() async throws {
        let desserts = try await api.recipes(for: "Dessert")
        XCTAssertEqual(desserts.count, 64)
    }
    
    func testCarrotCake() async throws {
        let id = "52897"
        let carrotCake = try await api.recipe(id: id)
        XCTAssertEqual(carrotCake.id, id)
        XCTAssertEqual(carrotCake.name, "Carrot Cake")
        XCTAssertEqual(carrotCake.imageURL.absoluteString, "https://www.themealdb.com/images/media/meals/vrspxv1511722107.jpg")
        XCTAssertEqual(carrotCake.thumbnailURL.absoluteString, "https://www.themealdb.com/images/media/meals/vrspxv1511722107.jpg/preview")
    }
}
