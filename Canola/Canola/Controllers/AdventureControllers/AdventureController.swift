//
//  AdventureController.swift
//  Canola
//
//  Created by 史翔新 on 2016/04/21.
//  Copyright © 2016年 史翔新. All rights reserved.
//

import UIKit

class AdventureController: UIViewController {
	
	lazy var engine: EngineModel = {
		let engine = EngineModel()
		return engine
	}()
	
	lazy var interactionView: UIView = {
		let view = UIView(frame: self.view.bounds)
		let tapGesture = UITapGestureRecognizer(target: self, action: #selector(AdventureController.enterNext))
		view.addGestureRecognizer(tapGesture)
		return view
	}()
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
        // Do any additional setup after loading the view.
		self.view.addSubview(self.interactionView)
		self.startGame()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
	func startGame() {
		self.engine.runGame()
	}
	
	func enterNext() {
		self.engine.enterNext()
	}
	
}
