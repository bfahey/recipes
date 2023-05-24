import Foundation

struct MealDB: RecipeAPI {
    
    //https://themealdb.com/api/json/v1/1/filter.php?c=Dessert
    // https://themealdb.com/api/json/v1/1/lookup.php?i=MEAL_ID
    static let defaultBaseURL = URL(string: "https://themealdb.com/api/json/v1/1/")!
    
    let baseURL: URL
    let session: URLSession
    
    init(baseURL: URL = defaultBaseURL, session: URLSession = .shared) {
        self.baseURL = baseURL
        self.session = session
    }
    
    func recipes(for category: String) async throws -> [Recipe] {
        assert(!category.isEmpty, "Category must not be empty")
        let url = baseURL.appending(path: "filter.php")
        var components = URLComponents(url: url, resolvingAgainstBaseURL: false)!
        components.queryItems = [URLQueryItem(name: "c", value: category)]

        let request = URLRequest(url: components.url!)
        let data = try await perform(request: request)
        let response = try JSONDecoder().decode(MealDBResponse.self, from: data)
        
        return response.recipes
    }
    
    func recipe(id: String) async throws -> Recipe {
        return Recipe(id: "", name: "", tags: [], imageURL: URL(fileURLWithPath: ""))
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
