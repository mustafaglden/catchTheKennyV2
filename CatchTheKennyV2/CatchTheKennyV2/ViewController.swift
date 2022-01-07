//
//  ViewController.swift
//  CatchTheKennyV2
//
//  Created by Mustafa Gülden on 7.01.2022.
//

import UIKit

class ViewController: UIViewController {
    let imageView = UIImageView()
    let baseImage = UIImage(named: "kenny")!
    var timer = Timer()
    var counter = 0
    var hideTimer = Timer()
    var highScore = 0
    var score = 0
    
    var timeLabel = UILabel()
    var scoreLabel = UILabel()
    var highScoreLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let width = view.frame.size.width
        let height = view.frame.size.height
        
        scoreLabel.text = "Score: \(score)"
        
        highScoreLabel.frame = CGRect(x: (width * 0.5) - 50, y: (height * 0.5) - 350, width: 100, height: 100)
        highScoreLabel.textColor = .black
        highScoreLabel.textAlignment = .center
        let storedHighScore = UserDefaults.standard.object(forKey: "highscore")
        if storedHighScore == nil {
            highScore = 0
            highScoreLabel.text = "Highscore: \(highScore)"
        }
        
        if let newScore = storedHighScore as? Int {
            highScore = newScore
            highScoreLabel.text = "Highscore: \(highScore)"
        }
        
        timeLabel.frame = CGRect(x: (width * 0.5) - 50, y: (height * 0.5) - 400, width: 100, height: 100)
        timeLabel.textColor = .black
        timeLabel.textAlignment = .center
        
        scoreLabel.frame = CGRect(x: (width * 0.5) - 50, y: (height * 0.5) - 375, width: 100, height: 100)
        scoreLabel.textColor = .black
        scoreLabel.textAlignment = .center
        
        imageView.frame = CGRect(x:0, y:200, width:width, height: height-300)
        imageView.isUserInteractionEnabled = true
        //imageView.backgroundColor = .red
        
        let resizedSize = CGSize(width: imageView.bounds.width / 3, height: imageView.bounds.height / 3)
        imageView.image = resizeImage(image: baseImage, targetSize: resizedSize)
        
        counter = 10
        timeLabel.text = String(counter)
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countDown), userInfo: nil, repeats: true)
        hideTimer = Timer.scheduledTimer(timeInterval: 0.75, target: self, selector: #selector(changeKenny), userInfo: nil, repeats: true)
        
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(increaseScore))

        imageView.addGestureRecognizer(recognizer)
        
        self.view.addSubview(imageView)
        self.view.addSubview(timeLabel)
        self.view.addSubview(scoreLabel)
        self.view.addSubview(highScoreLabel)
        imageView.contentMode = .center
    }

    @objc func changeKenny() {
        let randomLocation = Int(arc4random_uniform(UInt32(8)))
        switch randomLocation {
        case 0:
            imageView.contentMode = .topLeft
        case 1:
            imageView.contentMode = .top
        case 2:
            imageView.contentMode = .topRight
        case 3:
            imageView.contentMode = .left
        case 4:
            imageView.contentMode = .center
        case 5:
            imageView.contentMode = .right
        case 6:
            imageView.contentMode = .bottomLeft
        case 7:
            imageView.contentMode = .bottom
        case 8:
            imageView.contentMode = .bottomRight
        default:
            imageView.contentMode = .center
        }
    }

    func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage? {
        let rect = CGRect(origin: .zero, size: targetSize)
        UIGraphicsBeginImageContextWithOptions(targetSize, false, UIScreen.main.scale)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
    
    @objc func increaseScore(recognizer: UIGestureRecognizer) {
        let location = recognizer.location(in: imageView)
        let x_size = imageView.bounds.width / 3
        let y_size = imageView.bounds.height / 3
        let y_origin = imageView.frame.origin.y - 200
        
        if imageView.contentMode == .topLeft {
            let view = CGRect(x: 0,y: y_origin, width: x_size, height: y_size)
            if view.contains(location) {
                score += 1
                scoreLabel.text = "Score: \(score)"
            }
        } else if imageView.contentMode == .top {
            let view = CGRect(x: x_size, y: y_origin, width: x_size, height: y_size)
            if view.contains(location) {
                score += 1
                scoreLabel.text = "Score: \(score)"
            }
        } else if imageView.contentMode == .topRight {
            let view = CGRect(x: x_size * 2, y: y_origin, width: x_size, height: y_size)
            if view.contains(location) {
                score += 1
                scoreLabel.text = "Score: \(score)"
            }
        } else if imageView.contentMode == .left {
            let view = CGRect(x: 0, y: y_origin + y_size, width: x_size, height: y_size)
            if view.contains(location) {
                score += 1
                scoreLabel.text = "Score: \(score)"
            }
        } else if imageView.contentMode == .center {
            let view = CGRect(x: x_size, y: y_origin + y_size, width: x_size, height: y_size)
            if view.contains(location) {
                score += 1
                scoreLabel.text = "Score: \(score)"
            }
        } else if imageView.contentMode == .right {
            let view = CGRect(x: x_size * 2, y: y_origin + y_size, width: x_size, height: y_size)
            if view.contains(location) {
                score += 1
                scoreLabel.text = "Score: \(score)"
            }
        } else if imageView.contentMode == .bottomLeft {
            let view = CGRect(x: 0, y: y_origin + (2 * y_size), width: x_size, height: y_size)
            if view.contains(location) {
                score += 1
                scoreLabel.text = "Score: \(score)"
            }
        } else if imageView.contentMode == .bottom {
            let view = CGRect(x: x_size, y: y_origin + (2 * y_size), width: x_size, height: y_size)
            if view.contains(location) {
                score += 1
                scoreLabel.text = "Score: \(score)"
            }
        } else if imageView.contentMode == .bottomRight {
            let view = CGRect(x: x_size * 2, y: y_origin + (2 * y_size), width: x_size, height: y_size)
            if view.contains(location) {
                score += 1
                scoreLabel.text = "Score: \(score)"
            }
        }
    }
    
    @objc func countDown() {
        counter -= 1
        timeLabel.text = String(counter)
        
        if counter == 0 {
            timer.invalidate()
            hideTimer.invalidate()
            
            if self.score > self.highScore {
                self.highScore = self.score
                highScoreLabel.text = "Highscore: \(self.highScore)"
                UserDefaults.standard.set(self.highScore, forKey: "highScore")
            }
            
            let alert = UIAlertController(title: "Time's Up", message: "Do you want to play again?", preferredStyle: UIAlertController.Style.alert)
            let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil)
            let replayButton = UIAlertAction(title: "Replay", style: UIAlertAction.Style.default) { (UIAlertAction) in
                self.score = 0
                self.scoreLabel.text = "Score: \(self.score)"
                self.counter = 10
                self.timeLabel.text = String(self.counter)
                
                self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.countDown), userInfo: nil, repeats: true)
                self.hideTimer = Timer.scheduledTimer(timeInterval: 0.75, target: self, selector: #selector(self.changeKenny), userInfo: nil, repeats: true)
                
            }
            alert.addAction(okButton)
            alert.addAction(replayButton)
            self.present(alert, animated: true, completion: nil)
        }
    }
}
