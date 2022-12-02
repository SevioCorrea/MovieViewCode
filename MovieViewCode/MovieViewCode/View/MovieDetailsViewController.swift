//
//  MovieDetailsViewController.swift
//  MovieViewCode
//
//  Created by Sévio Basilio Corrêa on 29/11/22.
//

import UIKit
import Kingfisher

class MovieDetailsViewController: UIViewController {
    
    let contentScrollView: UIScrollView = {
        let scrollView = UIScrollView(frame: .zero)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private var movie: Filmes
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = movie.title
        label.textAlignment = .center
        label.numberOfLines = 0
        label.textColor = UIColor(red: 0.47, green: 0.60, blue: 0.00, alpha: 1.00)
        label.font = .systemFont(ofSize: 24.0, weight: .bold)
        return label
    }()
    
    private lazy var userScoreLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Classificação dos usuários: \(movie.voteAverage)"
        label.numberOfLines = 0
        label.textColor = UIColor(red: 0.47, green: 0.60, blue: 0.00, alpha: 1.00)
        label.font = .systemFont(ofSize: 16.0, weight: .bold)
        return label
    }()
    
    private lazy var userPopularity: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Popularidade: \(movie.formatPoints(from: movie.popularity))"
        label.numberOfLines = 0
        label.textColor = UIColor(red: 0.47, green: 0.60, blue: 0.00, alpha: 1.00)
        label.font = .systemFont(ofSize: 16.0, weight: .bold)
        return label
    }()
    
    private lazy var voteCount: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Likes: \(movie.formatPoints(from: movie.vote_count))"
        label.numberOfLines = 0
        label.textColor = UIColor(red: 0.47, green: 0.60, blue: 0.00, alpha: 1.00)
        label.font = .systemFont(ofSize: 16.0, weight: .bold)
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textColor = UIColor(red: 0.47, green: 0.60, blue: 0.00, alpha: 0.75)
        label.attributedText = NSAttributedString(string: movie.overview).withLineSpacing(8.0)
        return label
    }()
    
    private lazy var imagePoster: UIImageView = {
        let imgView = UIImageView()
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.layer.cornerRadius = 10.0
        imgView.layer.masksToBounds = true
        return imgView
    }()
    
    private lazy var likeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textColor = UIColor(red: 0.47, green: 0.60, blue: 0.00, alpha: 1.00)
        label.attributedText = NSAttributedString(string: "Like").withLineSpacing(8.0)
        return label
    }()
    
    private lazy var buttonFav: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "heart"), for: .normal)
        button.tintColor = UIColor(red: 0.47, green: 0.60, blue: 0.00, alpha: 1.00)
        button.addTarget(self, action: #selector(self.tappedButton(sender:)), for: .touchUpInside)
        return button
    }()
    var boleano: Bool = true
    @objc func tappedButton(sender: UIButton) {
        
        switch boleano {
        case true:
            buttonFav.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            
            return boleano = false
        case false:
            buttonFav.setImage(UIImage(systemName: "heart"), for: .normal)
            return boleano = true
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setBackground()
        setLayout()
        // Do any additional setup after loading the view.
    }
    
    
    
    private func setBackground() {
        view.backgroundColor = UIColor(red: 0.13, green: 0.18, blue: 0.16, alpha: 1.00)
    }
    
    init(movie: Filmes) {
        self.movie = movie
        super.init(nibName: nil, bundle: nil)
        guard let imageURL = movie.image else { return }
        imagePoster.configureImage(imageURL)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setLayout() {
        
        view.addSubview(titleLabel)
        view.addSubview(imagePoster)
        view.addSubview(userScoreLabel)
        view.addSubview(descriptionLabel)
        view.addSubview(userPopularity)
        view.addSubview(voteCount)
        view.addSubview(buttonFav)
        view.addSubview(likeLabel)
        view.addSubview(contentScrollView)
        
        NSLayoutConstraint.activate([
            
            buttonFav.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: -10),
            buttonFav.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 380),
            likeLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: -9),
            likeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 345),
            
            
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32.0),
            titleLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            
            userScoreLabel.topAnchor.constraint(equalTo: imagePoster.bottomAnchor, constant: 32.0),
            userScoreLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            userPopularity.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 32.0),
            userPopularity.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            voteCount.topAnchor.constraint(equalTo: userPopularity.bottomAnchor, constant: 32.0),
            voteCount.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            
            imagePoster.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imagePoster.widthAnchor.constraint(equalToConstant: 192.0),
            imagePoster.heightAnchor.constraint(equalToConstant: 264.0),
            imagePoster.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 32.0),
            
            descriptionLabel.topAnchor.constraint(equalTo: userScoreLabel.bottomAnchor, constant: 32.0),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16.0),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16.0),
        ])
    }
}

