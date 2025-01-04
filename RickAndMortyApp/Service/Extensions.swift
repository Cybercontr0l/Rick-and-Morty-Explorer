import UIKit
import CoreData
import os

// MARK: - UIViewController Extension
extension UIViewController {
    func setupBackground(imageName: String) {
        let backgroundImageView = UIImageView()
        backgroundImageView.image = UIImage(named: imageName)
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(backgroundImageView)
        view.sendSubviewToBack(backgroundImageView)
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            backgroundImageView.widthAnchor.constraint(equalToConstant: 393),
            backgroundImageView.heightAnchor.constraint(equalToConstant: 852)
        ])
    }
}

// MARK: - UILabel Extension
extension UILabel {
    func setAttributedText(boldText: String, boldFont: UIFont, normalText: String, normalFont: UIFont, color: UIColor) {
        let boldAttributes: [NSAttributedString.Key: Any] = [
            .font: boldFont,
            .foregroundColor: color
        ]
        let normalAttributes: [NSAttributedString.Key: Any] = [
            .font: normalFont,
            .foregroundColor: color
        ]

        let attributedText = NSMutableAttributedString(string: boldText, attributes: boldAttributes)
        attributedText.append(NSAttributedString(string: normalText, attributes: normalAttributes))
        self.attributedText = attributedText
    }
}

// MARK: - NSManagedObject Extension
extension NSManagedObject {
    func toRMCharacter() -> RMCharacter? {
        // Обязательные поля
        guard let id = self.value(forKey: "id") as? Int else {
            os_log("Missing 'id' in NSManagedObject", type: .error)
            return nil
        }
        guard let name = self.value(forKey: "name") as? String else {
            os_log("Missing 'name' in NSManagedObject", type: .error)
            return nil
        }

        // Необязательные поля
        let status = self.value(forKey: "status") as? String ?? "Unknown"
        let species = self.value(forKey: "species") as? String ?? "Unknown"
        let gender = self.value(forKey: "gender") as? String ?? "Unknown"
        let originName = self.value(forKey: "originName") as? String
        let locationName = self.value(forKey: "locationName") as? String

        guard let image = self.value(forKey: "image") as? String else {
            os_log("Missing 'image' in NSManagedObject", type: .error)
            return nil
        }

        // Опциональное поле
        let created = self.value(forKey: "created") as? String

        return RMCharacter(
            id: id,
            name: name,
            status: status,
            species: species,
            gender: gender,
            origin: RMCharacter.Origin(name: originName),
            image: image,
            location: RMCharacter.Location(name: locationName),
            created: created
        )
    }
}

// MARK: - Notification Name Extension
extension Notification.Name {
    static let favoritesUpdated = Notification.Name("favoritesUpdated")
}

