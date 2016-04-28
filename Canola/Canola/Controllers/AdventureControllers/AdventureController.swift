//
//  AdventureController.swift
//  Canola
//
//  Created by 史翔新 on 2016/04/21.
//  Copyright © 2016年 史翔新. All rights reserved.
//

import UIKit

class AdventureController: UIViewController {
	
	private lazy var engine: EngineModel = {
		let engine = EngineModel()
		return engine
	}()
	
	private lazy var adventureView: AdventureView = {
		let view = AdventureView(frame: self.view.bounds)
		view.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
		let tapGesture = UITapGestureRecognizer(target: self, action: #selector(AdventureController.onSingleTap))
		view.addGestureRecognizer(tapGesture)
		return view
	}()
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
        // Do any additional setup after loading the view.
		self.engine.mainParser?.graphicDelegate = self.adventureView
		
		self.view.addSubview(self.adventureView)
		self.startGame()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
	override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
		let mask = GlobalSettings.shared.viewSettings.supportedOrientationMask
		return mask
	}
	
	func startGame() {
		self.engine.runGame()
	}
	
	func onSingleTap() {
		self.engine.enterNext()
	}
	
}
