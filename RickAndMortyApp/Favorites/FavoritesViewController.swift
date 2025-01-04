import UIKit
import CoreData

class FavoritesViewController: BaseViewController {

    // MARK: - Properties
    private var favoritesView: FavoritesView!
    private var favorites: [NSManagedObject] = []

    // MARK: - Lifecycle Methods
    override func loadView() {
        favoritesView = FavoritesView()
        view = favoritesView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar(title: "Favorites")
        setupTableView()
        fetchFavorites()
        NotificationCenter.default.addObserver(self, selector: #selector(fetchFavorites), name: .favoritesDidUpdate, object: nil)
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    // MARK: - Setup Methods
    private func setupTableView() {
        favoritesView.tableView.dataSource = self
        favoritesView.tableView.delegate = self
        favoritesView.tableView.register(FavoriteCharacterCell.self, forCellReuseIdentifier: "FavoriteCharacterCell")
    }

    // MARK: - Data Fetching
    @objc private func fetchFavorites() {
        favorites = FavoriteCharacterService.shared.fetchFavorites()
        favoritesView.tableView.reloadData()
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate
extension FavoritesViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorites.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavoriteCharacterCell", for: indexPath) as! FavoriteCharacterCell
        let favorite = favorites[indexPath.row]
        guard let rmCharacter = favorite.toRMCharacter() else {
            fatalError("Failed to convert NSManagedObject to RMCharacter")
        }
        let isFavorited = FavoriteCharacterService.shared.isFavorited(id: rmCharacter.id)
        cell.configure(with: rmCharacter, isFavorited: isFavorited, delegate: self)
        return cell
    }
}

// MARK: - FavoriteCharacterCellDelegate
extension FavoritesViewController: FavoriteCharacterCellDelegate {
    
    func didTapInfoButton(for character: RMCharacter) {
        let detailVC = CharacterDetailViewController(character: character)
        navigationController?.pushViewController(detailVC, animated: true)
    }

    func didToggleFavorite(for character: RMCharacter) {
        FavoriteCharacterService.shared.toggleFavorite(for: character) { [weak self] _ in
            self?.fetchFavorites()
        }
    }
}

