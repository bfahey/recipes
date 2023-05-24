import Foundation

public struct Ingredient: Hashable, Identifiable, Decodable {
    public var name: String
    public var measurement: String
    
    public init(name: String, measurement: String) {
        self.name = name
        self.measurement = measurement
    }
}

public extension Ingredient {
    var id: String { name }
}

public extension Ingredient {
    static let baseImageURL = URL(string: "https://www.themealdb.com/images/ingredients/")!
    
    func imageURL(thumbnail: Bool) -> URL? {
        var components = URLComponents(url: Self.baseImageURL, resolvingAgainstBaseURL: false)!
        components.path = components.path + "\(thumbnail ? name + "-Small" : name).png"
        return components.url
    }
}
