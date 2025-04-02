//
//  ViewController.swift
//  RandomImage
//
//  Created by Vasiliy on 02.04.2025.
//

import UIKit

class ViewController: UIViewController, UISearchBarDelegate {
    
    @IBOutlet private var imageView: UIImageView!
    @IBOutlet private var searchBar: UISearchBar!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        refreshButton()
        setupUnavailableConfig()
        setupSearchBar()
        
    }
    
    @IBAction func refreshButton() {
        URLSession.shared.dataTask(with: URL(string: "https://picsum.photos/200/300")!) { data, response, error in
            guard let data, let response else {
                print(error?.localizedDescription ?? "No error description")
                return
            }
            
            print(response)
            
            DispatchQueue.main.async { [weak self] in
                guard let self else { return }
                imageView.image = UIImage(data: data)
                contentUnavailableConfiguration = nil
            }
        }.resume()
    }
    
    private func setupUnavailableConfig() {
        var config = UIContentUnavailableConfiguration.loading()
        config.text = "Waiting for a response..."
        config.textProperties.color = .systemBlue
        config.textProperties.font = .boldSystemFont(ofSize: 20)
        contentUnavailableConfiguration = config
    }
    
    internal func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text, !searchText.isEmpty else {
            return
        }
        
        let urlString = "https://picsum.photos/search?query=\(searchText)"
        guard let url = URL(string: urlString) else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data, let response else {
                print(error?.localizedDescription ?? "No error description")
                return
            }
            
            print(response)
            
            DispatchQueue.main.async { [weak self] in
                guard let self else { return }
                imageView.image = UIImage(data: data)
                contentUnavailableConfiguration = nil
            }
        }.resume()
        
        searchBar.resignFirstResponder()
    }
    
    private func setupSearchBar() {
        searchBar.delegate = self
        searchBar.placeholder = "Search images..."
    }
}

