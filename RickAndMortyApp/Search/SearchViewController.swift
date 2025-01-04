import UIKit

class SearchViewController: BaseViewController {
    
    // MARK: - Properties
    private var searchView: SearchView!
    private var characters: [RMCharacter] = []
    private var filteredCharacters: [RMCharacter] = []
    private var selectedPlanet: String? = nil
    private var currentIndex: Int = 0

    // MARK: - Lifecycle Methods
    override func loadView() {
        searchView = SearchView()
        view = searchView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar(title: "Search")
        setupActions()
        fetchCharacters()
        NotificationCenter.default.addObserver(self, selector: #selector(handleFavoritesUpdate), name: .favoritesDidUpdate, object: nil)
    }

    deinit {
        NotificationCenter.default.removeObserver(self, name: .favoritesDidUpdate, object: nil)
    }

    // MARK: - Notification Handlers
    @objc private func handleFavoritesUpdate() {
        let isFavorited = FavoriteCharacterService.shared.isFavorited(id: filteredCharacters[currentIndex].id)
        updateFavoriteButton(isFavorited: isFavorited)
    }

    // MARK: - Update Methods
    private func updateFavoriteButton(isFavorited: Bool) {
        let imageName = isFavorited ? "filled_star" : "star"
        searchView.favoriteButton.setImage(UIImage(named: imageName), for: .normal)
    }

    // MARK: - Setup Methods
    private func setupActions() {
        searchView.previousButton.addTarget(self, action: #selector(previousCharacter), for: .touchUpInside)
        searchView.nextButton.addTarget(self, action: #selector(nextCharacter), for: .touchUpInside)
        searchView.searchButton.addTarget(self, action: #selector(showPlanetPicker), for: .touchUpInside)
        searchView.infoButton.addTarget(self, action: #selector(showDetails), for: .touchUpInside)
        searchView.favoriteButton.addTarget(self, action: #selector(toggleFavorite), for: .touchUpInside)
    }

    // MARK: - Action Methods
    @objc private func previousCharacter() {
        guard !filteredCharacters.isEmpty else { return }
        currentIndex = (currentIndex == 0) ? filteredCharacters.count - 1 : currentIndex - 1
        updateCharacterCard()
    }

    @objc private func nextCharacter() {
        guard !filteredCharacters.isEmpty else { return }
        currentIndex = (currentIndex == filteredCharacters.count - 1) ? 0 : currentIndex + 1
        updateCharacterCard()
    }

    @objc private func showDetails() {
        let character = filteredCharacters[currentIndex]
        let detailVC = CharacterDetailViewController(character: character)
        navigationController?.pushViewController(detailVC, animated: true)
    }

    @objc private func toggleFavorite() {
        let character = filteredCharacters[currentIndex]
        FavoriteCharacterService.shared.toggleFavorite(for: character) { [weak self] isFavorited in
            DispatchQueue.main.async {
                self?.updateFavoriteButton(isFavorited: isFavorited)
            }
        }
    }

    @objc private func showPlanetPicker() {
        let alertController = UIAlertController(title: "Select a Planet", message: nil, preferredStyle: .actionSheet)
        let planets = Array(Set(characters.compactMap { $0.location.name })).sorted()
        
        planets.forEach { planet in
            alertController.addAction(UIAlertAction(title: planet, style: .default) { [weak self] _ in
                self?.selectedPlanet = planet
                self?.filterCharactersByPlanet()
            })
        }
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alertController, animated: true, completion: nil)
    }

    // MARK: - Helper Methods
    private func filterCharactersByPlanet() {
        if let planet = selectedPlanet {
            filteredCharacters = characters.filter { $0.location.name == planet }
        } else {
            filteredCharacters = characters
        }
        currentIndex = 0
        updateCharacterCard()
    }

    private func updateCharacterCard() {
        guard !filteredCharacters.isEmpty else {
            searchView.characterCard.isHidden = true
            searchView.noCharactersLabel.isHidden = false
            return
        }
        searchView.characterCard.isHidden = false
        searchView.noCharactersLabel.isHidden = true
        let character = filteredCharacters[currentIndex]
        searchView.configure(
            with: character,
            isFavorited: FavoriteCharacterService.shared.isFavorited(id: character.id)
        ) { [weak self] isFavorited in
            self?.updateFavoriteButton(isFavorited: isFavorited)
        }
    }

    // MARK: - Data Fetching
    private func fetchCharacters() {
        APIService.shared.fetchCharacters { [weak self] characters in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.characters = characters ?? []
                self.filteredCharacters = self.characters
                self.updateCharacterCard()
            }
        }
    }
}
