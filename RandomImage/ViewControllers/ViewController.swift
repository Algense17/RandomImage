//
//  ViewController.swift
//  RandomImage
//
//  Created by Vasiliy on 02.04.2025.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet private var imageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        refreshButton()
        setupUnavailableConfig()
        
    }

    @IBAction func refreshButton() {
        URLSession.shared.dataTask(with: URL(string: "https://picsum.photos/400/700")!) { data, response, error in
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
}

