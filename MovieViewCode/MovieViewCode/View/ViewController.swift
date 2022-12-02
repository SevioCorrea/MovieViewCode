//
//  ViewController.swift
//  MovieViewCode
//
//  Created by Sévio Basilio Corrêa on 29/11/22.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Requisição da API
    private var requestNetworking = Network()
    private var movies: [Filmes] = [] {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    // MARK: - Criação das Labels
    private lazy var titleView: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Dimensa Movies"
        label.textColor = UIColor(red: 0.47, green: 0.60, blue: 0.00, alpha: 1.00)
        label.font = .systemFont(ofSize: 24.0, weight: .bold)
        return label
    }()
    
    // MARK: - Criação da tableView
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        tableView.register(MovieTableViewCell.self, forCellReuseIdentifier: "movieCell")
        tableView.separatorStyle = .none
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // MARK: - Carregando Layout Setado
        //view.setBackground()
        setLayout()
        getPopularMovies()
        
    }
    
    private func getPopularMovies() {
        requestNetworking.fetchPopularMovies { movies in
            self.movies = movies
        }
    }
    
    // MARK: - Setando o Layout
    private func setLayout() {
        view.addSubview(titleView)
        view.addSubview(tableView)
        view.backgroundColor = UIColor(red: 0.13, green: 0.18, blue: 0.16, alpha: 1.00)
        
        NSLayoutConstraint.activate([
            titleView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            titleView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            tableView.topAnchor.constraint(equalTo: titleView.bottomAnchor, constant: 32.0),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
}
// MARK: - Extensão para a Table View
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell") as? MovieTableViewCell {
            cell.selectionStyle = .none
            cell.configureCell(movie: movies[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let detailsVC = MovieDetailsViewController(movie: movies[indexPath.row])
        navigationController?.pushViewController(detailsVC, animated: true)
    }
}
