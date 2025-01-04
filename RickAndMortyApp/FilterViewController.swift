import UIKit

class FilterViewController: UIViewController {
    var planets: [String] = []
    var onPlanetSelected: ((String) -> Void)?

    // Implement UIPickerView for planets

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchPlanets()
    }

    private func fetchPlanets() {
        // Fetch all unique planets from characters
    }
}

// Update CharactersViewController to handle planet selection
