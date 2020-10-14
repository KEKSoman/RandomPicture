//
//  ViewController.swift
//  RandomPicture
//
//  Created by Евгений колесников on 14.10.2020.
//

import UIKit

class ViewController: UIViewController {
    private let imageUrl = "https://picsum.photos/200"
    @IBOutlet var button: UIButton!
    @IBOutlet var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func actionButton() {
        fetchImage()
    }
    private func fetchImage(){
        guard let url = URL(string: imageUrl) else { return }
        let session = URLSession.shared
        session.dataTask(with: url) { (data, response, error) in
            if  let error = error {
                print(error.localizedDescription)
                return
            }
            if let response = response {
                print(response)
            }
            if let data = data, let image = UIImage(data: data){
                DispatchQueue.main.async {
                self.imageView.image = image
            }
        }
        }.resume()
    }
}

