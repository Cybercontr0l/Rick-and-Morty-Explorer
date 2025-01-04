import UIKit

class CharacterDetailViewController: UIViewController {

    // MARK: - Properties
    private var character: RMCharacter
    private var backgroundImageView: UIImageView!
    
    // UI Elements
    private var mainCard: UIView!
    private var imageCard: UIView!
    private var characterImageView: UIImageView!
    private var detailCard: UIView!
    private var nameLabel: UILabel!
    private var idLabel: UILabel!
    private var statusLabel: UILabel!
    private var speciesLabel: UILabel!
    private var genderLabel: UILabel!
    private var originLabel: UILabel!
    private var locationLabel: UILabel!
    
    // MARK: - Initializers
    init(character: RMCharacter) {
        self.character = character
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupBackground(imageName: "backgroundImage")
        setupUI()
        loadImage()
    }

    // MARK: - Private Methods
    private func setupNavigationBar() {
        self.title = "Details"
        let titleAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.white,
            .font: UIFont(name: "Inter-Regular", size: 24) ?? UIFont.systemFont(ofSize: 24)
        ]
        navigationController?.navigationBar.titleTextAttributes = titleAttributes
    }

    private func setupUI() {
        view.backgroundColor = .systemBackground
        setupMainCard()
        setupImageCard()
        setupCharacterImageView()
        setupDetailCard()
        setupLabels()
        setupConstraints()
    }

    private func setupMainCard() {
        mainCard = UIView()
        mainCard.translatesAutoresizingMaskIntoConstraints = false
        mainCard.backgroundColor = .white
        mainCard.layer.cornerRadius = 40
        mainCard.layer.borderWidth = 3
        mainCard.layer.borderColor = CGColor(red: 49/255, green: 173/255, blue: 75/255, alpha: 1)
        view.addSubview(mainCard)
    }

    private func setupImageCard() {
        imageCard = UIView()
        imageCard.translatesAutoresizingMaskIntoConstraints = false
        imageCard.backgroundColor = UIColor(red: 217/255, green: 217/255, blue: 217/255, alpha: 1)
        imageCard.layer.cornerRadius = 41
        imageCard.layer.borderWidth = 3
        imageCard.layer.borderColor = UIColor.black.cgColor
        mainCard.addSubview(imageCard)
    }

    private func setupCharacterImageView() {
        characterImageView = UIImageView()
        characterImageView.translatesAutoresizingMaskIntoConstraints = false
        characterImageView.contentMode = .scaleAspectFit
        imageCard.addSubview(characterImageView)
    }

    private func setupDetailCard() {
        detailCard = UIView()
        detailCard.translatesAutoresizingMaskIntoConstraints = false
        detailCard.backgroundColor = UIColor(red: 49/255, green: 173/255, blue: 75/255, alpha: 1)
        detailCard.layer.cornerRadius = 37
        detailCard.layer.borderWidth = 2
        detailCard.layer.borderColor = UIColor.black.cgColor
        mainCard.addSubview(detailCard)
    }

    private func setupLabels() {
        nameLabel = createLabel(font: UIFont(name: "Inter-Regular", size: 24) ?? UIFont.systemFont(ofSize: 24), text: character.name, underline: true)
        idLabel = createLabel(boldText: "ID: ", normalText: String(character.id))
        statusLabel = createLabel(boldText: "Status: ", normalText: character.status)
        speciesLabel = createLabel(boldText: "Species: ", normalText: character.species)
        genderLabel = createLabel(boldText: "Gender: ", normalText: character.gender)
        originLabel = createLabel(boldText: "Origin: ", normalText: character.origin.name ?? "Unknown")
        locationLabel = createLabel(boldText: "Planet: ", normalText: character.location.name ?? "Unknown")

        detailCard.addSubview(nameLabel)
        detailCard.addSubview(idLabel)
        detailCard.addSubview(statusLabel)
        detailCard.addSubview(speciesLabel)
        detailCard.addSubview(genderLabel)
        detailCard.addSubview(originLabel)
        detailCard.addSubview(locationLabel)
    }

    private func createLabel(font: UIFont, text: String, underline: Bool = false) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = font
        label.text = text
        label.textAlignment = .center
        if (underline) {
            let attributes: [NSAttributedString.Key: Any] = [
                .underlineStyle: NSUnderlineStyle.single.rawValue,
                .underlineColor: UIColor.black,
                .foregroundColor: UIColor.black
            ]
            label.attributedText = NSAttributedString(string: text, attributes: attributes)
        }
        return label
    }

    private func createLabel(boldText: String, normalText: String) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.setAttributedText(
            boldText: boldText,
            boldFont: UIFont(name: "Inter-Bold", size: 24) ?? UIFont.boldSystemFont(ofSize: 24),
            normalText: normalText,
            normalFont: UIFont(name: "Inter-Regular", size: 24) ?? UIFont.systemFont(ofSize: 24),
            color: .black
        )
        return label
    }

    private func loadImage() {
        if let url = URL(string: character.image) {
            URLSession.shared.dataTask(with: url) { data, _, _ in
                if let data = data {
                    DispatchQueue.main.async {
                        self.characterImageView.image = UIImage(data: data)
                    }
                }
            }.resume()
        }
    }
    
    // MARK: - Constraint Setup
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            
            mainCard.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            mainCard.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 41),
            mainCard.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -41),
            mainCard.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            
            imageCard.topAnchor.constraint(equalTo: mainCard.topAnchor, constant: 45),
            imageCard.leadingAnchor.constraint(equalTo: mainCard.leadingAnchor, constant: 20),
            imageCard.trailingAnchor.constraint(equalTo: mainCard.trailingAnchor, constant: -20),
            imageCard.bottomAnchor.constraint(equalTo: detailCard.topAnchor, constant: -40),
            
            characterImageView.topAnchor.constraint(equalTo: imageCard.topAnchor),
            characterImageView.leadingAnchor.constraint(equalTo: imageCard.leadingAnchor, constant: 41),
            characterImageView.trailingAnchor.constraint(equalTo: imageCard.trailingAnchor, constant: -41),
            characterImageView.bottomAnchor.constraint(equalTo: imageCard.bottomAnchor),
            
            detailCard.topAnchor.constraint(equalTo: nameLabel.topAnchor, constant: -40),
            detailCard.leadingAnchor.constraint(equalTo: mainCard.leadingAnchor, constant: 20),
            detailCard.trailingAnchor.constraint(equalTo: mainCard.trailingAnchor, constant: -20),
            detailCard.bottomAnchor.constraint(equalTo: mainCard.bottomAnchor, constant: -44),
            
            nameLabel.bottomAnchor.constraint(equalTo: idLabel.topAnchor, constant: -10),
            nameLabel.leadingAnchor.constraint(equalTo: detailCard.leadingAnchor, constant: 20),
            nameLabel.trailingAnchor.constraint(equalTo: detailCard.trailingAnchor, constant: -20),

            idLabel.bottomAnchor.constraint(equalTo: statusLabel.topAnchor, constant: -5),
            idLabel.leadingAnchor.constraint(equalTo: detailCard.leadingAnchor, constant: 20),
            idLabel.trailingAnchor.constraint(equalTo: detailCard.trailingAnchor, constant: -20),

            statusLabel.bottomAnchor.constraint(equalTo: speciesLabel.topAnchor, constant: -5),
            statusLabel.leadingAnchor.constraint(equalTo: detailCard.leadingAnchor, constant: 20),
            statusLabel.trailingAnchor.constraint(equalTo: detailCard.trailingAnchor, constant: -20),

            speciesLabel.bottomAnchor.constraint(equalTo: genderLabel.topAnchor, constant: -5),
            speciesLabel.leadingAnchor.constraint(equalTo: detailCard.leadingAnchor, constant: 20),
            speciesLabel.trailingAnchor.constraint(equalTo: detailCard.trailingAnchor, constant: -20),

            genderLabel.bottomAnchor.constraint(equalTo: originLabel.topAnchor, constant: -5),
            genderLabel.leadingAnchor.constraint(equalTo: detailCard.leadingAnchor, constant: 20),
            genderLabel.trailingAnchor.constraint(equalTo: detailCard.trailingAnchor, constant: -20),

            originLabel.bottomAnchor.constraint(equalTo: locationLabel.topAnchor, constant: -5),
            originLabel.leadingAnchor.constraint(equalTo: detailCard.leadingAnchor, constant: 20),
            originLabel.trailingAnchor.constraint(equalTo: detailCard.trailingAnchor, constant: -20),

            locationLabel.bottomAnchor.constraint(lessThanOrEqualTo: detailCard.bottomAnchor, constant: -62),
            locationLabel.leadingAnchor.constraint(equalTo: detailCard.leadingAnchor, constant: 20),
            locationLabel.trailingAnchor.constraint(equalTo: detailCard.trailingAnchor, constant: -20)
        ])
    }
}
