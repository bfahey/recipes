import Foundation

struct MealDBResponse: Decodable {
    let recipes: [Recipe]
}

extension MealDBResponse {
    enum CodingKeys: String, CodingKey {
        case recipes = "meals"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        // Any recipes that fail to decode will be skipped. Errors should be logged to a
        // remote error logging service like SentrySDK.
        self.recipes = container.decodeArray(of: Recipe.self, forKey: .recipes)
    }
}
