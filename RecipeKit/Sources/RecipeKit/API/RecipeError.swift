import Foundation

enum RecipeError: LocalizedError {
    case server(String)
}

extension RecipeError {
    
    var errorDescription: String? {
        switch self {
        case .server: return "Server Error"
        }
    }
    
    var failureReason: String? {
        switch self {
        case .server(let message):
            return message
        }
    }
}
