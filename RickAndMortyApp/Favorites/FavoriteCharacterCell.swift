import UIKit

protocol FavoriteCharacterCellDelegate: AnyObject {
    func didTapInfoButton(for character: RMCharacter)
    func didToggleFavorite(for character: RMCharacter)
}

class FavoriteCharacterCell: UITableViewCell {

    // MARK: - UI Components
    private var infoRectangle: UIView!
    private var characterImageView: UIImageView!
    private var nameLabel: UILabel!
    private var infoButton: UIButton!
    private var favoriteButton: UIButton!
    private var infoLabel: UILabel!

    private weak var delegate: FavoriteCharacterCellDelegate?
    private var character: RMCharacter?

    // MARK: - Initializers
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle
    override func prepareForReuse() {
        super.prepareForReuse()
        characterImageView.image = nil
        nameLabel.attributedText = nil
        favoriteButton.setImage(UIImage(named: "star"), for: .normal)
    }
    
    // MARK: - Configuration
    func configure(with character: RMCharacter, isFavorited: Bool, delegate: FavoriteCharacterCellDelegate) {
        self.character = character
        self.delegate = delegate
        setupNameLabel(for: character)
        loadImage(from: character.image)
        updateFavoriteButton(isFavorited: isFavorited)
    }

    // MARK: - Private Setup Methods
    private func setupCell() {
        backgroundColor = .clear
        selectionStyle = .none
        setupCharacterImageView()
        setupInfoRectangle()
        setupNameLabel()
        setupInfoButton()
        setupFavoriteButton()
        setupConstraints()
    }

    private func setupCharacterImageView() {
        characterImageView = UIImageView()
        characterImageView.translatesAutoresizingMaskIntoConstraints = false
        characterImageView.contentMode = .scaleAspectFill
        characterImageView.clipsToBounds = true
        characterImageView.layer.cornerRadius = 21
        contentView.addSubview(characterImageView)
    }

    private func setupInfoRectangle() {
        infoRectangle = UIView()
        infoRectangle.translatesAutoresizingMaskIntoConstraints = false
        infoRectangle.backgroundColor = UIColor(red: 49 / 255, green: 173 / 255, blue: 75 / 255, alpha: 1)
        contentView.addSubview(infoRectangle)
    }

    private func setupNameLabel() {
        nameLabel = UILabel()
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.font = UIFont(name: "Inter-Bold", size: 24)
        nameLabel.textColor = .black
        infoRectangle.addSubview(nameLabel)
    }

    private func setupInfoButton() {
        infoButton = UIButton(type: .custom)
        infoButton.translatesAutoresizingMaskIntoConstraints = false
        infoButton.layer.cornerRadius = 31
        infoButton.backgroundColor = .white
        infoButton.addTarget(self, action: #selector(infoButtonTapped), for: .touchUpInside)
        contentView.addSubview(infoButton)
        
        infoLabel = UILabel()
        infoLabel.translatesAutoresizingMaskIntoConstraints = false
        infoLabel.text = "ℹ️"
        infoLabel.font = UIFont.systemFont(ofSize: 36)
        infoLabel.textAlignment = .center
        infoButton.addSubview(infoLabel)
    }

    private func setupFavoriteButton() {
        favoriteButton = UIButton(type: .custom)
        favoriteButton.translatesAutoresizingMaskIntoConstraints = false
        favoriteButton.addTarget(self, action: #selector(toggleFavorite), for: .touchUpInside)
        favoriteButton.setImage(UIImage(named: "star"), for: .normal)
        contentView.addSubview(favoriteButton)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            characterImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            characterImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            characterImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            characterImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),

            infoRectangle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            infoRectangle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            infoRectangle.bottomAnchor.constraint(equalTo: characterImageView.bottomAnchor),
            infoRectangle.topAnchor.constraint(equalTo: nameLabel.topAnchor, constant: -10),

            nameLabel.bottomAnchor.constraint(equalTo: characterImageView.bottomAnchor, constant: -10),
            nameLabel.leadingAnchor.constraint(equalTo: characterImageView.leadingAnchor, constant: 10),
            nameLabel.trailingAnchor.constraint(equalTo: characterImageView.trailingAnchor, constant: -10),

            infoButton.topAnchor.constraint(equalTo: infoRectangle.topAnchor, constant: -31.5),
            infoButton.rightAnchor.constraint(equalTo: infoRectangle.rightAnchor),
            infoButton.widthAnchor.constraint(equalToConstant: 63),
            infoButton.heightAnchor.constraint(equalToConstant: 61),
            
            infoLabel.centerXAnchor.constraint(equalTo: infoButton.centerXAnchor),
            infoLabel.centerYAnchor.constraint(equalTo: infoButton.centerYAnchor),

            favoriteButton.topAnchor.constraint(equalTo: characterImageView.topAnchor),
            favoriteButton.leftAnchor.constraint(equalTo: characterImageView.leftAnchor),
            favoriteButton.widthAnchor.constraint(equalToConstant: 63),
            favoriteButton.heightAnchor.constraint(equalToConstant: 63)
        ])
    }

    private func setupNameLabel(for character: RMCharacter) {
        let nameText = "Name:"
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
        nameLabel.numberOfLines = 0
        nameLabel.lineBreakMode = .byWordWrapping
    }

    private func loadImage(from urlString: String) {
        guard let imageUrl = URL(string: urlString) else { return }
        ImageLoader.shared.loadImage(from: imageUrl) { [weak self] image in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.characterImageView.image = image
            }
        }
    }

    private func updateFavoriteButton(isFavorited: Bool) {
        let imageName = isFavorited ? "filled_star" : "star"
        favoriteButton.setImage(UIImage(named: imageName), for: .normal)
    }

    // MARK: - Actions
    @objc private func infoButtonTapped() {
        guard let character = character else { return }
        delegate?.didTapInfoButton(for: character)
    }

    @objc private func toggleFavorite() {
        guard let character = character else { return }
        delegate?.didToggleFavorite(for: character)
    }
}
