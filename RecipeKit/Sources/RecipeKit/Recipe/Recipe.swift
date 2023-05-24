import Foundation

public struct Recipe: Hashable, Identifiable, Decodable {
    public var id: String
    public var name: String
    public var area: String?
    public var instructions: String?
    public var tags: [String]
    public var sourceURL: URL?
    public var thumbnailURL: URL
    public var youTubeURL: URL?
    
    public init(id: String, name: String, area: String? = nil, instructions: String? = nil, tags: [String], sourceURL: URL? = nil, thumbnailURL: URL, youTubeURL: URL? = nil) {
        self.id = id
        self.name = name
        self.area = area
        self.instructions = instructions
        self.tags = tags
        self.sourceURL = sourceURL
        self.thumbnailURL = thumbnailURL
        self.youTubeURL = youTubeURL
    }
}

extension Recipe {
    enum CodingKeys: String, CodingKey {
        case id = "idMeal"
        case name = "strName"
        case area = "strArea"
        case instructions = "strInstructions"
        case tags = "strTags"
        case sourceURL = "strSource"
        case thumbnailURL = "strMealThumb"
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

        if let thumbnailString = try container.decodeIfPresent(String.self, forKey: .thumbnailURL), let thumbnailURL = URL(string: thumbnailString) {
            self.thumbnailURL = thumbnailURL
        } else {
            let context = DecodingError.Context(codingPath: container.codingPath, debugDescription: "Recipe thumbnail is not a valid URL")
            throw DecodingError.valueNotFound(String.self, context)
        }
        
        if let youTubeString = try container.decodeIfPresent(String.self, forKey: .youTubeURL) {
            self.youTubeURL = URL(string: youTubeString)
        }
    }
}
