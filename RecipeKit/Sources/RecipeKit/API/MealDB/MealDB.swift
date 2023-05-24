import Foundation
import OSLog

public struct MealDB: RecipeAPI {

    public static let defaultBaseURL = URL(string: "https://themealdb.com/api/json/v1/1/")!
    
    let baseURL: URL
    let session: URLSession
    
    private let logger = Logger(subsystem: "RecipeKit", category: "MealDB")
    
    public init(baseURL: URL = defaultBaseURL, session: URLSession = .shared) {
        self.baseURL = baseURL
        self.session = session
    }
    
    public func recipes(for category: String) async throws -> [Recipe] {
        assert(!category.isEmpty, "Category must not be empty")
        let url = baseURL.appending(path: "filter.php")
        var components = URLComponents(url: url, resolvingAgainstBaseURL: false)!
        components.queryItems = [URLQueryItem(name: "c", value: category)]

        let request = URLRequest(url: components.url!)
        logger.debug("GET \(request)")
        
        let data = try await perform(request: request)
        let response = try JSONDecoder().decode(MealDBResponse.self, from: data)
        logger.debug("Loaded \(response.recipes.count) recipes")

        return response.recipes
    }
    
    public func recipe(id: String) async throws -> Recipe {
        assert(!id.isEmpty, "ID must not be empty")
        let url = baseURL.appending(path: "lookup.php")
        var components = URLComponents(url: url, resolvingAgainstBaseURL: false)!
        components.queryItems = [URLQueryItem(name: "i", value: id)]

        let request = URLRequest(url: components.url!)
        logger.debug("GET \(request)")
        
        let data = try await perform(request: request)
        let response = try JSONDecoder().decode(MealDBResponse.self, from: data)
        
        guard let first = response.recipes.first else {
            throw RecipeError.server("Recipe not found.")
        }
        logger.debug("Found \(first.name)")
        
        return first
    }
}

private extension MealDB {

    func perform(request: URLRequest) async throws -> Data {
        let (data, response) = try await session.data(for: request)
        
        guard !data.isEmpty, let httpResponse = response as? HTTPURLResponse else {
            throw RecipeError.server("The server returned an invalid response.")
        }
        
        guard (200...300) ~= httpResponse.statusCode else {
            let message = HTTPURLResponse.localizedString(forStatusCode: httpResponse.statusCode)
            throw RecipeError.server(message)
        }
        
        return data
    }
}
