import Foundation

public struct Ingredient: Hashable, Identifiable {
    public var name: String
    public var measurement: String
}

public extension Ingredient {
    var id: String { name }
}

public extension Ingredient {
    func imageURL(thumbnail: Bool) -> URL {
        URL(string: "www.themealdb.com/images/ingredients/\(thumbnail ? name + "-Small" : name)).png")!
    }
}
