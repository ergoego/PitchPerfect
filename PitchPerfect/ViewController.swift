//
//  ViewController.swift
//  PitchPerfect
//
//  Created by Erik Olson on 7/2/17.
//  Copyright © 2017 Erik Olson. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var recordingLabel: UILabel!
    
    var isRecording = false // not a part of the project, but added because if this were real I would need a way to keep track of when recording has actually started/stopped. I need a variable to reference outside by some record method that actually calls upon the iPhone/iPad system resources to record audio.
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func recordAudio(_ sender: Any) {
        print("record button was pressed")
        isRecording = true //added to keep track of recording; not required from project
        recordingLabel.text = "Recording in Progress"
    }
    
    @IBAction func stopRecordAudio(_ sender: Any) { //changing this func name broke it :( Have to delete and rewire to change name? Changing then re-wiring didn't work... have to destroy completely and rewire from scratch?
        print("stop recording button was pressed")
        isRecording = false //added to keep track of recording; not required from project
        recordingLabel.text = "Tap to Record"
    }

}

