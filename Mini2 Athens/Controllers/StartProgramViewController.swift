//
//  StartProgramViewController.swift
//  Mini2 Athens
//
//  Created by Maurice Tin on 11/06/21.
//

import UIKit
import AVFoundation

class StartProgramViewController: UIViewController, ExerciseTimerDelegate {
    
    @IBOutlet weak var videoLayer: UIView!
    @IBOutlet weak var workoutLabel: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var pauseButton: UIButton!
    @IBOutlet weak var pauseResumeLabel: UILabel!
    @IBOutlet weak var DoneButton: UIButton!
    
    
    var playerLooper: AVPlayerLooper!
    var queuePlayer: AVQueuePlayer!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        playVideo()
        let exerciseTimer = ExerciseTimer(duration: 10, timerLabel: timerLabel)
        
        exerciseTimer.delegate = self
        
        exerciseTimer.runTimer()
    }
    
    func playVideo(){
        guard let path = Bundle.main.path(forResource: "testVideo1", ofType: "mp4") else {return}
        
       
        let player = AVPlayer(url: URL(fileURLWithPath: path))
        let playerLayer = AVPlayerLayer(player: player)
        player.isMuted = true
        playerLayer.frame = videoLayer.bounds
        playerLayer.videoGravity = .resizeAspectFill
        self.videoLayer.layer.addSublayer(playerLayer)
        player.play()
        loopVideo(videoPlayer: player)
    }

    func loopVideo(videoPlayer: AVPlayer){
        NotificationCenter.default.addObserver(forName: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: nil, queue: nil){ notification in

            videoPlayer.seek(to: CMTime.zero)
            self.playVideo()
        }
    }
    
    func timesUp() {
        //Implement later
        print("timer ends!!")
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
