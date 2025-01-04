import UIKit

class CharactersViewController: BaseViewController {
    
    // MARK: - Properties
    private var characterCardView: CharacterCardView!
    private var characters: [RMCharacter] = []
    private var currentIndex: Int = 0

    // MARK: - Lifecycle Methods
    override func loadView() {
        characterCardView = CharacterCardView()
        view = characterCardView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar(title: "Characters")
        setupActions()
        fetchCharacters()
        NotificationCenter.default.addObserver(self, selector: #selector(handleFavoritesUpdate), name: .favoritesDidUpdate, object: nil)
    }

    deinit {
        NotificationCenter.default.removeObserver(self, name: .favoritesDidUpdate, object: nil)
    }

    // MARK: - Notification Handling
    @objc private func handleFavoritesUpdate() {
        updateFavoriteButton(isFavorited: FavoriteCharacterService.shared.isFavorited(id: characters[currentIndex].id))
    }

    // MARK: - UI Updates
    private func updateFavoriteButton(isFavorited: Bool) {
        let imageName = isFavorited ? "filled_star" : "star"
        characterCardView.favoriteButton.setImage(UIImage(named: imageName), for: .normal)
    }
    
    private func updateCharacterCard() {
        guard !characters.isEmpty else { return }
        let character = characters[currentIndex]

        characterCardView.updateView(
            with: character,
            isFavorited: FavoriteCharacterService.shared.isFavorited(id: character.id)
        ) { [weak self] updatedFavoritedState in
            guard let self = self else { return }
            self.characterCardView.updateFavoriteButton(isFavorited: updatedFavoritedState)
        }
    }

    // MARK: - Setup Methods
    private func setupActions() {
        characterCardView.configure(
            infoAction: #selector(showDetails),
            favoriteAction: #selector(toggleFavorite),
            previousAction: #selector(previousCharacter),
            nextAction: #selector(nextCharacter),
            target: self
        )
    }

    // MARK: - Data Fetching
    private func fetchCharacters() {
        APIService.shared.fetchCharacters { [weak self] characters in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.characters = characters ?? []
                self.updateCharacterCard()
            }
        }
    }

    // MARK: - Actions
    @objc private func previousCharacter() {
        guard !characters.isEmpty else { return }
        currentIndex = (currentIndex == 0) ? (characters.count - 1) : (currentIndex - 1)
        updateCharacterCard()
    }

    @objc private func nextCharacter() {
        guard !characters.isEmpty else { return }
        currentIndex = (currentIndex == characters.count - 1) ? 0 : (currentIndex + 1)
        updateCharacterCard()
    }

    @objc private func showDetails() {
        let character = characters[currentIndex]
        let detailVC = CharacterDetailViewController(character: character)
        navigationController?.pushViewController(detailVC, animated: true)
    }

    @objc private func toggleFavorite() {
        let character = characters[currentIndex]
        FavoriteCharacterService.shared.toggleFavorite(for: character) { [weak self] isFavorited in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.characterCardView.updateFavoriteButton(isFavorited: isFavorited)
            }
        }
    }
}
