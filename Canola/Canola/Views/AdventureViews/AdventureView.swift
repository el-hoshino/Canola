//
//  AdventureView.swift
//  Canola
//
//  Created by 史翔新 on 2016/04/26.
//  Copyright © 2016年 史翔新. All rights reserved.
//

import SpriteKit

class AdventureView: SKView {
	
	private lazy var gameScene: AdventureScene = {
		let scene = AdventureScene(size: GlobalSettings.shared.viewSettings.gameScreenSize)
		scene.scaleMode = .AspectFit
		scene.backgroundColor = .blackColor()
		return scene
	}()
	
	override func didMoveToSuperview() {
		self.presentScene(self.gameScene)
		self.showsFPS = true
		self.showsNodeCount = true
	}
	
}

extension AdventureView: ParserModelGraphicDelegate {
	
	func showScreen(within duration: NSTimeInterval, waitUntilEnd shouldWait: Bool) {
		self.gameScene.showScreen(within: duration, waitUntilEnd: shouldWait)
	}
	
	func hideScreen(within duration: NSTimeInterval, usingColor color: UIColor, waitUntilEnd shouldWait: Bool) {
		self.gameScene.hideScreen(within: duration, usingColor: color, waitUntilEnd: shouldWait)
	}
	
	func initializeBackground(on tag: Int) throws {
		try self.gameScene.initializeBackground(on: tag)
	}
	
	func setBackground(on tag: Int, with file: String, within duration: NSTimeInterval) throws {
		try self.gameScene.setBackground(on: tag, with: file, within: duration)
	}
	
	func showBackground(on tag: Int, within duration: NSTimeInterval, waitUntilEnd shouldWait: Bool) throws {
		try self.gameScene.fadeBackground(on: tag, to: 1, within: duration, waitUntilEnd: shouldWait)
	}
	
	func hideBackground(on tag: Int, within duration: NSTimeInterval, waitUntilEnd shouldWait: Bool) throws {
		try self.gameScene.fadeBackground(on: tag, to: 0, within: duration, waitUntilEnd: shouldWait)
	}
	
	func initializeCharacter(on tag: Int) throws {
		try self.gameScene.initializeCharacter(on: tag)
	}
	
	func setCharacter(on tag: Int, with file: String, within duration: NSTimeInterval, `as` name: String?) throws {
		try self.gameScene.setCharacter(on: tag, with: file, within: duration, as: name)
	}
	
	func showCharacter(on tag: Int, within duration: NSTimeInterval, waitUntilEnd shouldWait: Bool) throws {
		try self.gameScene.fadeCharacter(on: tag, to: 1, within: duration, waitUntilEnd: shouldWait)
	}
	
	func hideCharacter(on tag: Int, within duration: NSTimeInterval, waitUntilEnd shouldWait: Bool) throws {
		try self.gameScene.fadeCharacter(on: tag, to: 0, within: duration, waitUntilEnd: shouldWait)
	}
	
}
