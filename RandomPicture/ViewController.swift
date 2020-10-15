import UIKit
import AVFoundation

class MyJon: Codable {
    var number = ""
    var language = ""
    var insult = ""
    var created = ""
    var shown = ""
    var createdby = ""
    var active = ""
    var comment = ""
}

class ViewController: UIViewController {
    
    private let imageUrl = "https://picsum.photos/200"
    private let unsultUrl = "https://evilinsult.com/generate_insult.php?lang=en&type=json"
    
    @IBOutlet var button: UIButton!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var messageLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func actionButton() {
        fetchImage()
        insultMessag()
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
    
    private func insultMessag(){
        guard let insultMsg = URL(string: unsultUrl) else { return }
        
        URLSession.shared.dataTask(with: insultMsg) { (data, response, error) in
            if  let error = error {
                print(error.localizedDescription)
                return
            }
            if let response = response {
                print(response)
            }
            guard let data = data else { return }
            DispatchQueue.main.async {
            do{
                let message = try JSONDecoder().decode(MyJon.self, from: data)
                
                self.messageLabel.text = message.insult
                
                let synthesizer = AVSpeechSynthesizer()
                let utterance = AVSpeechUtterance(string: self.messageLabel.text!)
                //utterance.voice = AVSpeechSynthesisVoice(language: "ru-RU")
                synthesizer.speak(utterance)
            } catch let error{
                print(error)
            }
            }
        }.resume()
        
        
            
    }
    
    
}




