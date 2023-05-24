import Foundation

public struct Recipe: Hashable, Identifiable, Decodable {
    public var id: String
    public var name: String
    public var area: String?
    public var instructions: String?
    public var tags: [String]
    public var sourceURL: URL?
    public var imageURL: URL
    public var youTubeURL: URL?
    
    public init(id: String, name: String, area: String? = nil, instructions: String? = nil, tags: [String], sourceURL: URL? = nil, imageURL: URL, youTubeURL: URL? = nil) {
        self.id = id
        self.name = name
        self.area = area
        self.instructions = instructions
        self.tags = tags
        self.sourceURL = sourceURL
        self.imageURL = imageURL
        self.youTubeURL = youTubeURL
    }
}

public extension Recipe {
    
    static let preview = Recipe(
        id: "1",
        name: "Carrot Cake",
        area: "British",
        instructions: """
        For the carrot cake, preheat the oven to 160C/325F/Gas 3. Grease and line a 26cm/10in springform cake tin.
        
        Mix all of the ingredients for the carrot cake, except the carrots and walnuts, together in a bowl until well combined. Stir in the carrots and walnuts.\r\nSpoon the mixture into the cake tin and bake for 1 hour 15 minutes, or until a skewer inserted into the middle comes out clean. Remove the cake from the oven and set aside to cool for 10 minutes, then carefully remove the cake from the tin and set aside to cool completely on a cooling rack.\r\nMeanwhile, for the icing, beat the cream cheese, caster sugar and butter together in a bowl until fluffy. Spread the icing over the top of the cake with a palette knife.
        """,
        tags: ["Cake", "Treat", "Sweet"],
        sourceURL: nil,
        imageURL: URL(string: "https://www.themealdb.com/images/media/meals/vrspxv1511722107.jpg")!,
        youTubeURL: nil
    )
}

extension Recipe {
    
    /// Thumbnails are 50 x 50 pixels at 3X scale.
    public var thumbnailURL: URL {
        return imageURL.appending(path: "preview")
    }
}

extension Recipe {
    enum CodingKeys: String, CodingKey {
        case id = "idMeal"
        case name = "strMeal"
        case area = "strArea"
        case instructions = "strInstructions"
        case tags = "strTags"
        case sourceURL = "strSource"
        case imageURL = "strMealThumb"
        case youTubeURL = "strYoutube"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.area = try container.decodeIfPresent(String.self, forKey: .area)
        self.instructions = try container.decodeIfPresent(String.self, forKey: .instructions)
        
        if let tagString = try container.decodeIfPresent(String.self, forKey: .tags), !tagString.isEmpty {
            self.tags = tagString.components(separatedBy: ",")
        } else {
            self.tags = []
        }
        
        if let sourceString = try container.decodeIfPresent(String.self, forKey: .sourceURL) {
            self.sourceURL = URL(string: sourceString)
        }

        if let imageString = try container.decodeIfPresent(String.self, forKey: .imageURL), let imageURL = URL(string: imageString) {
            self.imageURL = imageURL
        } else {
            let context = DecodingError.Context(codingPath: container.codingPath, debugDescription: "Recipe thumbnail is not a valid URL")
            throw DecodingError.valueNotFound(String.self, context)
        }
        
        if let youTubeString = try container.decodeIfPresent(String.self, forKey: .youTubeURL) {
            self.youTubeURL = URL(string: youTubeString)
        }
    }
}
