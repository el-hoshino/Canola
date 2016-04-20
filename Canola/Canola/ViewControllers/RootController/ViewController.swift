//
//  ViewController.swift
//  Canola
//
//  Created by 史翔新 on 2016/04/21.
//  Copyright © 2016年 史翔新. All rights reserved.
//

import UIKit

public class ViewController: UIViewController {
	
	private var _adventureController: AdventureController?
	var adventureController: AdventureController {
		if let controller = self._adventureController {
			return controller
			
		} else {
			let controller = AdventureController()
			self._adventureController = controller
			return controller
		}
	}
	
    override public func viewDidLoad() {
        super.viewDidLoad()
		
        // Do any additional setup after loading the view.
    }
	
    override public func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
	
	override public func viewDidAppear(animated: Bool) {
		self.presentViewController(self.adventureController, animated: true, completion: nil)
	}

}
