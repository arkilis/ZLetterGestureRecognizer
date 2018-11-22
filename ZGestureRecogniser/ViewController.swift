//
//  ViewController.swift
//  ZGestureRecogniser
//
//  Created by Ben Liu on 22/11/18.
//  Copyright © 2018 SunSuper. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let gesture = ZLetterGestureRecognizer.init(target: self, action: #selector(self.dialog))
        self.view.addGestureRecognizer(gesture)
    }

    @objc func dialog() {
        let alert = UIAlertController(title: "Gesture", message: "Message", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
