import UIKit

// MARK: - MainTabBarController
class MainTabBarController: UITabBarController {

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Добавляем viewControllers в таб бар
        viewControllers = [
            createCharactersModule(),
            createSearchModule(),
            createFavoritesModule()
        ]

        setupTabBarAppearance()
    }

    // MARK: - Setup Tab Bar Appearance
    /// Настройка внешнего вида таб бара
    private func setupTabBarAppearance() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(red: 64/255, green: 64/255, blue: 64/255, alpha: 1) // Цвет фона

        let tabBarItemAppearance = UITabBarItemAppearance()
        tabBarItemAppearance.normal.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -10)
        tabBarItemAppearance.normal.titleTextAttributes = [
            .font: UIFont(name: "Inter-Regular", size: 20) ?? UIFont.systemFont(ofSize: 20),
            .foregroundColor: UIColor.white
        ]

        tabBarItemAppearance.selected.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -10)
        tabBarItemAppearance.selected.titleTextAttributes = [
            .font: UIFont(name: "Inter-Regular", size: 20) ?? UIFont.systemFont(ofSize: 20),
            .foregroundColor: UIColor.systemBlue
        ]

        appearance.stackedLayoutAppearance = tabBarItemAppearance
        appearance.inlineLayoutAppearance = tabBarItemAppearance
        appearance.compactInlineLayoutAppearance = tabBarItemAppearance

        tabBar.standardAppearance = appearance
        if #available(iOS 15.0, *) {
            tabBar.scrollEdgeAppearance = appearance
        }
    }

    // MARK: - Create Modules
    /// Создание модуля "Characters"
    private func createCharactersModule() -> UINavigationController {
        let charactersVC = CharactersViewController()
        let navVC = UINavigationController(rootViewController: charactersVC)
        navVC.tabBarItem = UITabBarItem(
            title: "Characters",
            image: UIImage(named: "characters_icon"),
            tag: 0
        )
        return navVC
    }

    /// Создание модуля "Search"
    private func createSearchModule() -> UINavigationController {
        let searchVC = SearchViewController()
        let navVC = UINavigationController(rootViewController: searchVC)
        navVC.tabBarItem = UITabBarItem(
            title: "Search",
            image: UIImage(named: "search_icon"),
            tag: 1
        )
        return navVC
    }

    /// Создание модуля "Favorites"
    private func createFavoritesModule() -> UINavigationController {
        let favoritesVC = FavoritesViewController()
        let navVC = UINavigationController(rootViewController: favoritesVC)
        navVC.tabBarItem = UITabBarItem(
            title: "Favorites",
            image: UIImage(named: "favorites_icon"), 
            tag: 2
        )
        return navVC
    }
}
