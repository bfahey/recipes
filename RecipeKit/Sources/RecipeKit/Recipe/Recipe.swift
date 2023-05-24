import Foundation

public struct Recipe: Hashable, Identifiable {
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
