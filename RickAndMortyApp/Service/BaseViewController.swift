import UIKit

// MARK: - BaseViewController
class BaseViewController: UIViewController {

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBackground(imageName: "backgroundImage")
    }

    // MARK: - Setup Navigation Bar
    func setupNavigationBar(title: String) {
        self.title = title
        let titleAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.white,
            .font: UIFont(name: "Inter-Regular", size: 24) ?? UIFont.systemFont(ofSize: 24)
        ]
        navigationController?.navigationBar.titleTextAttributes = titleAttributes
    }
}
