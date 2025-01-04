import Foundation

final class APIService {
    // MARK: - Singleton
    static let shared = APIService()

    private init() {} //предотвращает создание дополнительных экземпляров класса.

    // MARK: - Fetch Characters
    func fetchCharacters(completion: @escaping ([RMCharacter]?) -> Void) {
        let initialURL = "https://rickandmortyapi.com/api/character"

        func fetchPage(url: String, allCharacters: [RMCharacter] = []) {
            guard let url = URL(string: url) else {
                print("Invalid URL: \(url)")
                completion(nil)
                return
            }

            URLSession.shared.dataTask(with: url) { data, response, error in
                if let error = error {
                    print("Network error: \(error.localizedDescription)")
                    completion(nil)
                    return
                }

                guard let httpResponse = response as? HTTPURLResponse,
                      200..<300 ~= httpResponse.statusCode else {
                    print("Invalid response: \(String(describing: response))")
                    completion(nil)
                    return
                }

                guard let data = data else {
                    print("No data received")
                    completion(nil)
                    return
                }

                do {
                    let apiResponse = try JSONDecoder().decode(APIResponse.self, from: data)
                    var allCharacters = allCharacters
                    allCharacters.append(contentsOf: apiResponse.results)

                    if let nextURL = apiResponse.info?.next {
                        fetchPage(url: nextURL, allCharacters: allCharacters) // Рекурсивно загружаем следующую страницу
                    } else {
                        completion(allCharacters) // Возвращаем результат после последней страницы
                    }
                } catch {
                    print("Decoding error: \(error.localizedDescription)")
                    completion(nil)
                }
            }.resume()
        }

        fetchPage(url: initialURL)
    }

    // MARK: - Fetch Characters by Location
    func fetchCharactersByLocation(location: String, completion: @escaping ([RMCharacter]?) -> Void) {
        fetchCharacters { characters in
            guard let characters = characters else {
                completion(nil)
                return
            }
            let filteredCharacters = characters.filter {
                $0.location.name?.lowercased() == location.lowercased()
            }
            completion(filteredCharacters)
        }
    }

    // MARK: - Fetch Locations
    func fetchLocations(completion: @escaping ([String]?) -> Void) {
        fetchCharacters { characters in
            guard let characters = characters else {
                completion(nil)
                return
            }
            let locations = Array(Set(characters.compactMap { $0.location.name }))
            completion(locations)
        }
    }
}

// MARK: - API Models

struct RMCharacter: Codable {
    let id: Int
    let name: String
    let status: String
    let species: String
    let gender: String
    let origin: Origin
    let image: String
    let location: Location
    let created: String?

    struct Origin: Codable {
        let name: String?
    }

    struct Location: Codable {
        let name: String?
    }
}

struct APIResponse: Decodable {
    let info: PageInfo?
    let results: [RMCharacter]
}

struct PageInfo: Decodable {
    let next: String?
    let prev: String?
}
