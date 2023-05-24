import Foundation

func loadTestData(name: String) -> Data {
    guard let url = Bundle.module.url(forResource: name, withExtension: nil) else {
        fatalError("Invalid name")
    }
    return try! Data(contentsOf: url)
}
