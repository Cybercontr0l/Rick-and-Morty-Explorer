import UIKit

class SearchView: UIView {

    // MARK: - UI Elements
    var searchButton: UIButton!
    var characterCard: UIView!
    private var characterImageView: UIImageView!
    private var nameLabel: UILabel!
    private var locationLabel: UILabel!
    var noCharactersLabel: UILabel!
    var previousButton: UIButton!
    var nextButton: UIButton!
    var infoButton: UIButton!
    var favoriteButton: UIButton!
    private var infoRectangle: UIView!
    private var infoLabel: UILabel!

    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup UI
    private func setupUI() {
        self.backgroundColor = .systemBackground
        setupCharacterCard()
        setupCharacterImageView()
        setupInfoRectangle()
        setupNameLabel()
        setupLocationLabel()
        setupNoCharactersLabel()
        setupPreviousButton()
        setupNextButton()
        setupInfoButton()
        setupFavoriteButton()
        setupSearchButton()
        setupConstraints()
    }

    private func setupCharacterCard() {
        characterCard = UIView()
        characterCard.translatesAutoresizingMaskIntoConstraints = false
        characterCard.backgroundColor = UIColor(red: 30 / 255, green: 30 / 255, blue: 30 / 255, alpha: 1)
        characterCard.layer.cornerRadius = 42
        characterCard.layer.masksToBounds = true
        addSubview(characterCard)
    }

    private func setupCharacterImageView() {
        characterImageView = UIImageView()
        characterImageView.translatesAutoresizingMaskIntoConstraints = false
        characterImageView.contentMode = .scaleAspectFill
        characterImageView.clipsToBounds = true
        characterImageView.layer.cornerRadius = 21
        characterCard.addSubview(characterImageView)
    }

    private func setupInfoRectangle() {
        infoRectangle = UIView()
        infoRectangle.translatesAutoresizingMaskIntoConstraints = false
        infoRectangle.backgroundColor = UIColor(red: 49/255, green: 173/255, blue: 75/255, alpha: 1)
        characterCard.addSubview(infoRectangle)
    }

    private func setupNameLabel() {
        nameLabel = UILabel()
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.font = UIFont(name: "Inter", size: 24)
        nameLabel.textColor = .black
        nameLabel.numberOfLines = 0
        characterCard.addSubview(nameLabel)
    }

    private func setupLocationLabel() {
        locationLabel = UILabel()
        locationLabel.translatesAutoresizingMaskIntoConstraints = false
        locationLabel.font = UIFont(name: "Inter", size: 24)
        locationLabel.textColor = .black
        locationLabel.numberOfLines = 0
        characterCard.addSubview(locationLabel)
    }

    private func setupNoCharactersLabel() {
        noCharactersLabel = UILabel()
        noCharactersLabel.translatesAutoresizingMaskIntoConstraints = false
        noCharactersLabel.textAlignment = .center
        noCharactersLabel.text = "No characters found on this planet."
        noCharactersLabel.isHidden = true
        addSubview(noCharactersLabel)
    }

    private func setupPreviousButton() {
        previousButton = UIButton(type: .custom)
        previousButton.setImage(UIImage(named: "left-green"), for: .normal)
        previousButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(previousButton)
    }

    private func setupNextButton() {
        nextButton = UIButton(type: .custom)
        nextButton.setImage(UIImage(named: "right-green"), for: .normal)
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(nextButton)
    }

    private func setupInfoButton() {
        infoButton = UIButton(type: .custom)
        infoButton.translatesAutoresizingMaskIntoConstraints = false
        infoButton.layer.cornerRadius = 31
        infoButton.backgroundColor = .white

        infoLabel = UILabel() // Инициализация infoLabel
        infoLabel.translatesAutoresizingMaskIntoConstraints = false
        infoLabel.text = "ℹ️"
        infoLabel.font = UIFont.systemFont(ofSize: 36)
        infoLabel.textAlignment = .center
        infoButton.addSubview(infoLabel)
        characterCard.addSubview(infoButton)
    }

    private func setupFavoriteButton() {
        favoriteButton = UIButton(type: .custom)
        if let starImage = UIImage(named: "star") {
            favoriteButton.setImage(starImage, for: .normal)
        }
        favoriteButton.translatesAutoresizingMaskIntoConstraints = false
        characterCard.addSubview(favoriteButton)
    }

    private func setupSearchButton() {
        searchButton = UIButton(type: .custom)
        var configuration = UIButton.Configuration.plain()
        configuration.title = "Search by Planet"

        if let planetIcon = UIImage(named: "planet_icon") {
            configuration.image = planetIcon
        }

        configuration.imagePadding = 10
        configuration.imagePlacement = .leading
        configuration.background.backgroundColor = UIColor(red: 49/255, green: 173/255, blue: 75/255, alpha: 1)
        configuration.baseForegroundColor = .black
        configuration.cornerStyle = .medium

        if let interBold = UIFont(name: "Inter-Bold", size: 20) {
            let titleAttributedString = AttributedString("Search by Planet", attributes: AttributeContainer([.font: interBold]))
            configuration.attributedTitle = titleAttributedString
        } else {
            let titleAttributedString = AttributedString("Search by Planet", attributes: AttributeContainer([.font: UIFont.boldSystemFont(ofSize: 20)]))
            configuration.attributedTitle = titleAttributedString
        }

        configuration.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: -60, bottom: 0, trailing: 0)
        configuration.imagePadding = 10
        configuration.imagePlacement = .leading

        searchButton.configuration = configuration
        searchButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(searchButton)
    }

    private func setupConstraints() {
        let triangleImageView = UIImageView(image: UIImage(named: "triangle_icon"))
        triangleImageView.translatesAutoresizingMaskIntoConstraints = false
        searchButton.addSubview(triangleImageView)

        NSLayoutConstraint.activate([
            // Search Button
            searchButton.topAnchor.constraint(equalTo: characterCard.topAnchor, constant: 46),
            searchButton.leadingAnchor.constraint(equalTo: characterCard.leadingAnchor, constant: 21),
            searchButton.trailingAnchor.constraint(equalTo: characterCard.trailingAnchor, constant: -21),
            searchButton.heightAnchor.constraint(equalToConstant: 57),

            triangleImageView.centerYAnchor.constraint(equalTo: searchButton.centerYAnchor),
            triangleImageView.trailingAnchor.constraint(equalTo: searchButton.trailingAnchor, constant: -10),
            triangleImageView.widthAnchor.constraint(equalToConstant: 29),
            triangleImageView.heightAnchor.constraint(equalToConstant: 16),

            // Character Card
            characterCard.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
            characterCard.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 21),
            characterCard.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -21),
            characterCard.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20),

            // Character Image View
            characterImageView.topAnchor.constraint(equalTo: searchButton.bottomAnchor, constant: 42),
            characterImageView.leadingAnchor.constraint(equalTo: characterCard.leadingAnchor, constant: 24),
            characterImageView.trailingAnchor.constraint(equalTo: characterCard.trailingAnchor, constant: -24),
            characterImageView.bottomAnchor.constraint(equalTo: infoRectangle.topAnchor, constant: 70),

            // Info Rectangle
            infoRectangle.leadingAnchor.constraint(equalTo: characterCard.leadingAnchor, constant: 24),
            infoRectangle.trailingAnchor.constraint(equalTo: characterCard.trailingAnchor, constant: -24),
            infoRectangle.topAnchor.constraint(equalTo: locationLabel.topAnchor, constant: -12),
            infoRectangle.bottomAnchor.constraint(equalTo: previousButton.topAnchor, constant: -12),

            // Location Label
            locationLabel.bottomAnchor.constraint(equalTo: nameLabel.topAnchor, constant: -5),
            locationLabel.leadingAnchor.constraint(equalTo: characterCard.leadingAnchor, constant: 39),
            locationLabel.trailingAnchor.constraint(equalTo: characterCard.trailingAnchor, constant: -39),

            // Name Label
            nameLabel.bottomAnchor.constraint(equalTo: previousButton.topAnchor, constant: -33),
            nameLabel.leadingAnchor.constraint(equalTo: characterCard.leadingAnchor, constant: 39),
            nameLabel.trailingAnchor.constraint(equalTo: characterCard.trailingAnchor, constant: -39),

            // No Characters Label
            noCharactersLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            noCharactersLabel.topAnchor.constraint(equalTo: characterCard.bottomAnchor, constant: 20),

            // Previous Button
            previousButton.leadingAnchor.constraint(equalTo: characterCard.leadingAnchor, constant: 74),
            previousButton.bottomAnchor.constraint(equalTo: characterCard.bottomAnchor, constant: -20),
            previousButton.widthAnchor.constraint(equalToConstant: 35),
            previousButton.heightAnchor.constraint(equalToConstant: 62),

            // Next Button
            nextButton.trailingAnchor.constraint(equalTo: characterCard.trailingAnchor, constant: -74),
            nextButton.bottomAnchor.constraint(equalTo: previousButton.bottomAnchor),
            nextButton.widthAnchor.constraint(equalToConstant: 35),
            nextButton.heightAnchor.constraint(equalToConstant: 62),

            // Info Button
            infoButton.topAnchor.constraint(equalTo: infoRectangle.topAnchor, constant: -31),
            infoButton.rightAnchor.constraint(equalTo: infoRectangle.rightAnchor),
            infoButton.widthAnchor.constraint(equalToConstant: 63),
            infoButton.heightAnchor.constraint(equalToConstant: 61),
            
            infoLabel.centerXAnchor.constraint(equalTo: infoButton.centerXAnchor),
            infoLabel.centerYAnchor.constraint(equalTo: infoButton.centerYAnchor),

            // Favorite Button
            favoriteButton.widthAnchor.constraint(equalToConstant: 61),
            favoriteButton.heightAnchor.constraint(equalToConstant: 54),
            favoriteButton.leadingAnchor.constraint(equalTo: characterImageView.leadingAnchor, constant: 10),
            favoriteButton.topAnchor.constraint(equalTo: characterImageView.topAnchor, constant: 10)
        ])
    }
}

// MARK: - Configuration
extension SearchView {
    /// Конфигурирует представление на основе данных о персонаже
    func configure(with character: RMCharacter, isFavorited: Bool, onFavoriteToggled: @escaping (Bool) -> Void) {
        // Настройка изображения персонажа
        if let url = URL(string: character.image) {
            URLSession.shared.dataTask(with: url) { data, _, _ in
                if let data = data {
                    DispatchQueue.main.async {
                        self.characterImageView.image = UIImage(data: data)
                    }
                }
            }.resume()
        }

        // Настройка имени
        setNameLabel(character: character)
        // Настройка локации
        setLocationLabel(character: character)
        
        // Настройка кнопки избранного
        let favoriteImage = isFavorited ? UIImage(named: "filled_star") : UIImage(named: "star")
        favoriteButton.setImage(favoriteImage, for: .normal)
        
        // Устанавливаем обработчик для кнопки избранного
        favoriteButton.addAction(UIAction { _ in
            onFavoriteToggled(!isFavorited)
        }, for: .touchUpInside)
    }

    private func setNameLabel(character: RMCharacter) {
        let nameText = "Name: "
        let nameValue = character.name
        let nameAttributedText = NSMutableAttributedString(string: "\(nameText)\n", attributes: [
            .font: UIFont(name: "Inter-Bold", size: 20) ?? UIFont.boldSystemFont(ofSize: 20),
            .foregroundColor: UIColor.black
        ])
        nameAttributedText.append(NSAttributedString(string: nameValue, attributes: [
            .font: UIFont(name: "Inter-Regular", size: 20) ?? UIFont.systemFont(ofSize: 20),
            .foregroundColor: UIColor.black
        ]))
        nameLabel.attributedText = nameAttributedText
    }

    private func setLocationLabel(character: RMCharacter) {
        let locationText = "Planet: "
        let locationValue = character.location.name ?? "Unknown"
        let locationAttributedText = NSMutableAttributedString(string: "\(locationText)\n", attributes: [
            .font: UIFont(name: "Inter-Bold", size: 20) ?? UIFont.boldSystemFont(ofSize: 20),
            .foregroundColor: UIColor.black
        ])
        locationAttributedText.append(NSAttributedString(string: locationValue, attributes: [
            .font: UIFont(name: "Inter-Regular", size: 20) ?? UIFont.systemFont(ofSize: 20),
            .foregroundColor: UIColor.black
        ]))
        locationLabel.attributedText = locationAttributedText
    }
}

