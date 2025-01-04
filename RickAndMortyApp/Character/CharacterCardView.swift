import UIKit

class CharacterCardView: UIView {

    // MARK: - UI Components
    private var characterImageView: UIImageView!
    private var nameLabel: UILabel!
    private var statusLabel: UILabel!
    private var createdLabel: UILabel!
    private var locationLabel: UILabel!
    private var infoButton: UIButton!
    var favoriteButton: UIButton!
    private var previousButton: UIButton!
    private var nextButton: UIButton!
    private var cardBackgroundView: UIView!

    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup Methods
    private func setupView() {
        self.backgroundColor = .systemBackground
        setupCardBackgroundView()
        setupCharacterImageView()
        setupLabels()
        setupButtons()
        setupConstraints()
    }

    // MARK: - UI Setup Methods

    private func setupCardBackgroundView() {
        let cardBackgroundView = UIView()
        cardBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        cardBackgroundView.backgroundColor = UIColor(red: 30 / 255, green: 30 / 255, blue: 30 / 255, alpha: 1)
        cardBackgroundView.layer.cornerRadius = 42
        cardBackgroundView.layer.masksToBounds = true
        self.addSubview(cardBackgroundView)
        self.cardBackgroundView = cardBackgroundView
    }

    private func setupCharacterImageView() {
        characterImageView = UIImageView()
        characterImageView.translatesAutoresizingMaskIntoConstraints = false
        characterImageView.contentMode = .scaleAspectFill
        characterImageView.clipsToBounds = true
        characterImageView.layer.cornerRadius = 32
        characterImageView.layer.masksToBounds = true
        self.addSubview(characterImageView)
    }

    private func setupLabels() {
        locationLabel = createLabel()
        nameLabel = createLabel()
        statusLabel = createLabel()
        createdLabel = createLabel()
        
        [locationLabel, nameLabel, statusLabel, createdLabel].forEach {
            self.addSubview($0)
        }
    }

    private func setupButtons() {
        infoButton = createRoundedButton(withText: "ℹ️", size: 36)
        favoriteButton = UIButton(type: .custom)
        favoriteButton.setImage(UIImage(named: "star"), for: .normal)
        favoriteButton.translatesAutoresizingMaskIntoConstraints = false
        
        previousButton = UIButton(type: .custom)
        previousButton.setImage(UIImage(named: "leftArrow"), for: .normal)
        previousButton.translatesAutoresizingMaskIntoConstraints = false
        
        nextButton = UIButton(type: .custom)
        nextButton.setImage(UIImage(named: "rightArrow"), for: .normal)
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        
        [infoButton, favoriteButton, previousButton, nextButton].forEach {
            self.addSubview($0)
        }
    }

    // MARK: - Constraints Setup

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            // cardBackgroundView Constraints
            cardBackgroundView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
            cardBackgroundView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 21),
            cardBackgroundView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -21),
            cardBackgroundView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20),

            // characterImageView Constraints
            characterImageView.bottomAnchor.constraint(equalTo: cardBackgroundView.bottomAnchor, constant: -90),
            characterImageView.leadingAnchor.constraint(equalTo: cardBackgroundView.leadingAnchor, constant: 24),
            characterImageView.trailingAnchor.constraint(equalTo: cardBackgroundView.trailingAnchor, constant: -24),
            characterImageView.topAnchor.constraint(equalTo: createdLabel.bottomAnchor, constant: 10),

            // Labels Constraints
            locationLabel.topAnchor.constraint(equalTo: cardBackgroundView.topAnchor, constant: 20),
            locationLabel.leadingAnchor.constraint(equalTo: cardBackgroundView.leadingAnchor, constant: 39),
            locationLabel.trailingAnchor.constraint(equalTo: cardBackgroundView.trailingAnchor, constant: -39),

            nameLabel.topAnchor.constraint(equalTo: locationLabel.bottomAnchor, constant: 10),
            nameLabel.leadingAnchor.constraint(equalTo: locationLabel.leadingAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: locationLabel.trailingAnchor),

            statusLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
            statusLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            statusLabel.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor),

            createdLabel.topAnchor.constraint(equalTo: statusLabel.bottomAnchor, constant: 10),
            createdLabel.leadingAnchor.constraint(equalTo: statusLabel.leadingAnchor),
            createdLabel.trailingAnchor.constraint(equalTo: statusLabel.trailingAnchor),

            // Buttons Constraints
            infoButton.widthAnchor.constraint(equalToConstant: 63),
            infoButton.heightAnchor.constraint(equalToConstant: 61),
            infoButton.trailingAnchor.constraint(equalTo: characterImageView.trailingAnchor),
            infoButton.bottomAnchor.constraint(equalTo: characterImageView.bottomAnchor),

            favoriteButton.widthAnchor.constraint(equalToConstant: 61),
            favoriteButton.heightAnchor.constraint(equalToConstant: 54),
            favoriteButton.leadingAnchor.constraint(equalTo: characterImageView.leadingAnchor, constant: 10),
            favoriteButton.topAnchor.constraint(equalTo: characterImageView.topAnchor, constant: 10),

            previousButton.leadingAnchor.constraint(equalTo: cardBackgroundView.leadingAnchor, constant: 74),
            previousButton.bottomAnchor.constraint(equalTo: cardBackgroundView.bottomAnchor, constant: -20),
            previousButton.widthAnchor.constraint(equalToConstant: 35),
            previousButton.heightAnchor.constraint(equalToConstant: 62),

            nextButton.trailingAnchor.constraint(equalTo: cardBackgroundView.trailingAnchor, constant: -74),
            nextButton.bottomAnchor.constraint(equalTo: previousButton.bottomAnchor),
            nextButton.widthAnchor.constraint(equalToConstant: 35),
            nextButton.heightAnchor.constraint(equalToConstant: 62),
        ])
    }


    // MARK: - Configuration Methods
    func configure(
        infoAction: Selector,
        favoriteAction: Selector,
        previousAction: Selector,
        nextAction: Selector,
        target: Any
    ) {
        infoButton.addTarget(target, action: infoAction, for: .touchUpInside)
        favoriteButton.addTarget(target, action: favoriteAction, for: .touchUpInside)
        previousButton.addTarget(target, action: previousAction, for: .touchUpInside)
        nextButton.addTarget(target, action: nextAction, for: .touchUpInside)
    }

    func updateView(
        with character: RMCharacter,
        isFavorited: Bool,
        onFavoriteToggled: @escaping (Bool) -> Void
    ) {
        configureTextLabels(for: nameLabel, title: "Name: ", value: character.name)
        configureTextLabels(for: statusLabel, title: "Status: ", value: character.status)
        configureTextLabels(for: locationLabel, title: "Planet: ", value: character.location.name ?? "Unknown")
        configureTextLabels(for: createdLabel, title: "Created: ", value: character.created ?? "Unknown")

        if let url = URL(string: character.image) {
            ImageLoader.shared.loadImage(from: url) { [weak self] image in
                DispatchQueue.main.async {
                    self?.characterImageView.image = image
                }
            }
        }

        updateFavoriteButton(isFavorited: isFavorited)
        favoriteButton.addAction(UIAction { _ in onFavoriteToggled(isFavorited) }, for: .touchUpInside)
    }

    func updateFavoriteButton(isFavorited: Bool) {
        let imageName = isFavorited ? "filled_star" : "star"
        favoriteButton.setImage(UIImage(named: imageName), for: .normal)
    }

    // MARK: - Utility Methods
    private func createLabel() -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }

    private func createRoundedButton(withText text: String, size: CGFloat) -> UIButton {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 31
        button.backgroundColor = .white
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = text
        label.font = UIFont.systemFont(ofSize: size)
        label.textAlignment = .center
        button.addSubview(label)
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: button.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: button.centerYAnchor)
        ])
        return button
    }

    private func configureTextLabels(for label: UILabel, title: String, value: String, isBoldTitle: Bool = true) {
        let titleFont = isBoldTitle ? UIFont(name: "Inter-Bold", size: 16) ?? UIFont.boldSystemFont(ofSize: 16) : UIFont.systemFont(ofSize: 16)
        let valueFont = UIFont(name: "Inter-Regular", size: 16) ?? UIFont.systemFont(ofSize: 16)
        
        let attributedText = NSMutableAttributedString(string: title, attributes: [.font: titleFont, .foregroundColor: UIColor.white])
        attributedText.append(NSAttributedString(string: value, attributes: [.font: valueFont, .foregroundColor: UIColor.white]))
        
        label.attributedText = attributedText
    }
}
