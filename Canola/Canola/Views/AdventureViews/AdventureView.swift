//
//  AdventureView.swift
//  Canola
//
//  Created by 史翔新 on 2016/04/26.
//  Copyright © 2016年 史翔新. All rights reserved.
//

import SpriteKit

class AdventureView: SKView {
	
	private lazy var gameScene: SKScene = {
		let scene = SKScene(size: GlobalSettings.shared.viewSettings.gameScreenSize)
		scene.backgroundColor = .blueColor()
		return scene
	}()
	
	override func didMoveToSuperview() {
		self.presentScene(self.gameScene)
		self.showsFPS = true
		self.showsNodeCount = true
	}
	
}
