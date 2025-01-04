import UIKit

class FavoritesView: UIView {

    // MARK: - Properties
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = 310
        tableView.estimatedRowHeight = 310
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        return tableView
    }()

    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }

    // MARK: - Setup UI
    private func setupUI() {
        backgroundColor = .systemBackground
        
        let cardBackgroundView = UIView()
        cardBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        cardBackgroundView.backgroundColor = UIColor(red: 30 / 255, green: 30 / 255, blue: 30 / 255, alpha: 1)
        cardBackgroundView.layer.cornerRadius = 42
        cardBackgroundView.layer.masksToBounds = true
        addSubview(cardBackgroundView)
        
        addSubview(tableView)

        NSLayoutConstraint.activate([
            cardBackgroundView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
            cardBackgroundView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 21),
            cardBackgroundView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -21),
            cardBackgroundView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20),

            tableView.topAnchor.constraint(equalTo: cardBackgroundView.topAnchor, constant: 23),
            tableView.leadingAnchor.constraint(equalTo: cardBackgroundView.leadingAnchor, constant: 24),
            tableView.trailingAnchor.constraint(equalTo: cardBackgroundView.trailingAnchor, constant: -24),
            tableView.bottomAnchor.constraint(equalTo: cardBackgroundView.bottomAnchor, constant: -9)
        ])
    }
}
