//
//  ViewController.swift
//  Hustle-Bro
//
//  Created by Fowler, Creighton on 11/12/19.
//  Copyright © 2019 Fowler, Creighton. All rights reserved.
//

import UIKit
import AVFoundation
import UserNotifications

class ViewController: UIViewController {
    
    @IBOutlet weak var powerBtn: UIButton!
    @IBOutlet weak var rocket: UIImageView!
    
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var activationLabel: UILabel!
    @IBOutlet weak var hustleLabel: UILabel!
    
    var player: AVAudioPlayer!

    
    let userNotificationCenter = UNUserNotificationCenter.current()
    func requestNotificationPower() {
        let authOptions = UNAuthorizationOptions.init(arrayLiteral: .alert, .badge, .sound)
        self.userNotificationCenter.requestAuthorization(options: authOptions) { (success, error) in
            if let error = error {
                print("Error: ", error)
            }
            
        }
    }
    
    func sendNotification() {
        let notificationContent = UNMutableNotificationContent()
        notificationContent.title = "Test"
        notificationContent.body = "Test body"
        notificationContent.badge = NSNumber(value: 3)
        
        if let url = Bundle.main.url(forResource: "dune",
                                     withExtension: "png") {
            if let attachment = try? UNNotificationAttachment(identifier: "dune",
                                                              url: url,
                                                              options: nil) {
                notificationContent.attachments = [attachment]
            }
        }
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5,
                                                        repeats: false)
        let request = UNNotificationRequest(identifier: "testNotification",
                                            content: notificationContent,
                                            trigger: trigger)
        
        userNotificationCenter.add(request) { (error) in
            if let error = error {
                print("Notification Error: ", error)
            }
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        let path = Bundle.main.path(forResource: "hustle-on", ofType: "wav")!
        let url = URL(fileURLWithPath: path)
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player.prepareToPlay()
        } catch let error as NSError {
            print("error")
        }
    
    }
    
    func animate() {
        UIView.animate(withDuration: 5.0, animations: {
            self.rocket.layer.position.y = -400
        }) { (finished) in
            self.hustleLabel.isHidden = true
            self.activationLabel.isHidden = true
            self.powerBtn.isHidden = false
        }
    }
    
    @IBAction func powerBtnPressed(_ sender: Any) {
        let content = UNMutableNotificationContent()
        content.title = "Hustle Mode"
        content.body = "Hustle Mode Activated"
        EasyAnimation.enable()
        backgroundImage.isHidden = false
        rocket.isHidden = false
        activationLabel.isHidden = false
        hustleLabel.isHidden = false
        rocket.isHidden = false
        powerBtn.isHidden = true
        player.play()
        animate();
        sendNotification();
        
    }
    

}

