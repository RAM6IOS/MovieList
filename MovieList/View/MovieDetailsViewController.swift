//
//  MovieDetailsViewController.swift
//  MovieList
//
//  Created by MACBOOK PRO on 29/6/2024.
//

import UIKit

import SDWebImage

class MovieDetailsViewController: UIViewController {
    var movieId: Int?
    var movie: Movie?
    let scrollView = UIScrollView()
    let contentView = UIView()
    
    let titleLabel = UILabel()
    let movieImageView = UIImageView()
    let releaseDateLabel = UILabel()
    var originalLanguage = UILabel()
    let ratingLabel = UILabel()
    let overviewLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        fetchMovieDetails()
    }
    
    func setupUI() {
        //view.backgroundColor = .white
        view.backgroundColor = UIColor(red: 0/255, green: 80/255, blue: 100/255, alpha: 1)
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
        
        titleLabel.font = UIFont.boldSystemFont(ofSize: 24)
        titleLabel.textColor = UIColor(red: 0.0, green: 191/255, blue: 255/255, alpha: 1.0) // اللون الأزرق السماوي
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .center
        
        movieImageView.contentMode = .scaleAspectFit
        movieImageView.clipsToBounds = true
        
        releaseDateLabel.font = UIFont.systemFont(ofSize: 16)
        releaseDateLabel.textColor = .darkGray
        releaseDateLabel.textColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0);
        
        
        originalLanguage.font =  UIFont.systemFont(ofSize: 16);
        originalLanguage.textColor = .darkGray
        originalLanguage.textColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0);

        
        ratingLabel.font = UIFont.systemFont(ofSize: 16)
        ratingLabel.textColor = .darkGray
        ratingLabel.textColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0);
        
        overviewLabel.font = UIFont.systemFont(ofSize: 16)
        overviewLabel.numberOfLines = 0
        overviewLabel.textColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0);

        
        contentView.addSubview(titleLabel)
        contentView.addSubview(movieImageView)
        contentView.addSubview(releaseDateLabel)
        contentView.addSubview(ratingLabel)
        contentView.addSubview(originalLanguage)
        contentView.addSubview(overviewLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        movieImageView.translatesAutoresizingMaskIntoConstraints = false
        releaseDateLabel.translatesAutoresizingMaskIntoConstraints = false
        originalLanguage.translatesAutoresizingMaskIntoConstraints = false
        ratingLabel.translatesAutoresizingMaskIntoConstraints = false
        overviewLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            movieImageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 23),
            movieImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            movieImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            movieImageView.heightAnchor.constraint(equalToConstant: 300),
            
            releaseDateLabel.topAnchor.constraint(equalTo: movieImageView.bottomAnchor, constant: 16),
            releaseDateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            releaseDateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            ratingLabel.topAnchor.constraint(equalTo: releaseDateLabel.bottomAnchor, constant: 23),
            ratingLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            ratingLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
           
            originalLanguage.topAnchor.constraint(equalTo: releaseDateLabel.bottomAnchor, constant: 2),
            originalLanguage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            originalLanguage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
           // originalLanguage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 20),
            
            overviewLabel.topAnchor.constraint(equalTo: ratingLabel.bottomAnchor, constant: 10),
            overviewLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            overviewLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            overviewLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        ])
    }
    
    func fetchMovieDetails() {
        guard let movieId = movieId else { return }
        NetworkManager.shared.fetchMovieDetails(movieId: movieId) { [weak self] movie in
            DispatchQueue.main.async {
                self?.movie = movie
                self?.updateUI()
            }
        }
    }
    
    func updateUI() {
        guard let movie = movie else { return }
        
        titleLabel.text = movie.title
        releaseDateLabel.text = "Release Date: \(movie.releaseDate ?? "N/A")"
        ratingLabel.text = "Rating: \(movie.voteAverage)"
        
        originalLanguage.text = "language:\(movie.originalLanguage)"
        overviewLabel.text = movie.overview
        
        if let posterPath = movie.posterPath {
            let imageUrl = URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)")!
            movieImageView.sd_setImage(with: imageUrl, completed: nil)
        }
    }
}
