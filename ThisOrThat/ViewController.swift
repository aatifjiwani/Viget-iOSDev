//
//  ViewController.swift
//  ThisOrThat
//
//  Created by Aatif Jiwani on 7/19/18.
//  Copyright © 2018 Aatif Jiwani. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        present(IndexController(), animated: true, completion: nil)
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

