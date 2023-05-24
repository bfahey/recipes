import Foundation

struct MealDBResponse<Value: Decodable>: Decodable {
    let value: Value
}

extension MealDBResponse {
    enum CodingKeys: String, CodingKey {
        case value = "meals"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.value = try container.decode(Value.self, forKey: .value)
    }
}
