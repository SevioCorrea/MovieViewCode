//
//  MovieTableViewCell.swift
//  MovieViewCode
//
//  Created by Sévio Basilio Corrêa on 29/11/22.
//

import UIKit

// MARK: - Criando arquivo da célula customizada
class MovieTableViewCell: UITableViewCell {
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(red: 0.47, green: 0.60, blue: 0.00, alpha: 1.00)
        label.font = .boldSystemFont(ofSize: 20.0)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var releaseDateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(red: 0.47, green: 0.60, blue: 0.00, alpha: 0.75)
        return label
    }()
    
    private lazy var imagePoster: UIImageView = {
        let imgView = UIImageView()
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.layer.cornerRadius = 18.0
        imgView.layer.masksToBounds = true
        imgView.backgroundColor = .black
        return imgView
    }()
    
    private lazy var textStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        [titleLabel, releaseDateLabel].forEach { view in
            stack.addArrangedSubview(view)
        }
        stack.distribution = .fillProportionally
        stack.spacing = 8
        return stack
    }()
    
    // MARK: - Stack Horizontal, dividida em duas partes: a imagem e a parte dos textos.
    private lazy var mainStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        [imagePoster, textStackView].forEach { view in
            stack.addArrangedSubview(view)
        }
        stack.distribution = .fillProportionally
        stack.spacing = 16.0
        stack.alignment = .center
        return stack
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // MARK: - Configurando a célula para a ViewController
    func configureCell(movie: Filmes) {
        setConstraints()
        titleLabel.text = movie.title
        releaseDateLabel.text = "Lançamento: \(movie.releaseDate.formatDate())"
        guard let imageURL = movie.image else { return }
        imagePoster.configureImage(imageURL)
    }
    
    private func setLayout() {
        backgroundColor = .clear
    }
    
    private func setConstraints() {
        addSubview(mainStackView)
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: topAnchor, constant: 16.0),
            mainStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16.0),
            mainStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24.0),
            mainStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24.0),
            
            imagePoster.widthAnchor.constraint(equalToConstant: 90),
            imagePoster.heightAnchor.constraint(equalToConstant: 120),
        ])
    }
    
}
