import UIKit

// MARK: - ImageLoader
class ImageLoader {
    // MARK: - Properties
    static let shared = ImageLoader()
    private let cache = NSCache<NSURL, UIImage>()

    // MARK: - Initializer
    private init() {}

    // MARK: - Load Image
    func loadImage(from url: URL, completion: @escaping (UIImage?) -> Void) {
        if let cachedImage = cache.object(forKey: url as NSURL) {
            completion(cachedImage)
            return
        }

        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil, let image = UIImage(data: data) else {
                completion(nil)
                return
            }

            self.cache.setObject(image, forKey: url as NSURL)
            completion(image)
        }.resume()
    }
}
