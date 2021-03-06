//
//  RecordSoundsViewController.swift
//  PitchPerfect
//
//  Created by Erik Olson on 7/2/17.
//  Copyright © 2017 Erik Olson. All rights reserved. test
//

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate {
    
//    MARK: Setup
    
    //    Added a UIAlertController to alert the user if recording fails
    var alertRecordingFailedController: UIAlertController = UIAlertController()
    
    var audioRecorder: AVAudioRecorder!

    @IBOutlet weak var recordingLabel: UILabel!
    @IBOutlet weak var stopRecordingButton: UIButton!
    @IBOutlet weak var recordButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stopRecordingButton.isEnabled = false
    }

//    MARK: Start/Stop Recording
    
    @IBAction func recordAudio(_ sender: UIButton) {
        
        toggleUIRecording(recording: true)
        
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        let recordingName = "recordedVoice.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = URL(string: pathArray.joined(separator: "/"))
        
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSessionCategoryPlayAndRecord, with: .defaultToSpeaker)
        
        try! audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
        audioRecorder.delegate = self
        audioRecorder.isMeteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
    }

    @IBAction func stopRecordingAudio(_ sender: Any) {
        toggleUIRecording(recording: false)
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
    }
    
//    MARK: Transition After Recording
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if flag {
            performSegue(withIdentifier: "stopRecording", sender: audioRecorder.url)
        } else {
            alertRecordingFailedController = UIAlertController(title: "Error", message: "Recording Failed", preferredStyle: .alert)
            self.present(alertRecordingFailedController, animated: true, completion: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "stopRecording" {
            let playSoundsVC = segue.destination as! PlaySoundsViewController
            let recordedAudioURL = sender as! URL
            playSoundsVC.recordedAudioURL = recordedAudioURL
        }
    }
    
//    MARK: UI Toggling to Enable/Disable Recording
    
    func toggleUIRecording(recording: Bool) {
        recordingLabel.text = recording ? "Recording in Progress" : "Tap to Record"
        stopRecordingButton.isEnabled = recording
        recordButton.isEnabled = !recording
        
        /* if recording {
            recordingLabel.text = "Recording in Progress"
            stopRecordingButton.isEnabled = true
            recordButton.isEnabled = false
        }
        else {
            recordingLabel.text = "Tap to Record"
            recordButton.isEnabled = true
            stopRecordingButton.isEnabled = false
        } this original block has been refactored */
    }
    
}

