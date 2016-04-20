//
//  ViewController.swift
//  CanolaSample
//
//  Created by 史翔新 on 2016/04/18.
//  Copyright © 2016年 史翔新. All rights reserved.
//

import UIKit
import Canola

class ViewController: UIViewController {

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	override func viewDidAppear(animated: Bool) {
		let controller = Canola.ViewController()
		self.presentViewController(controller, animated: true, completion: nil)
	}
	
}
