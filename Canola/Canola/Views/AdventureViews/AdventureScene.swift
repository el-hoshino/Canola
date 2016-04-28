//
//  AdventureScene.swift
//  Canola
//
//  Created by 史翔新 on 2016/04/27.
//  Copyright © 2016年 史翔新. All rights reserved.
//

import SpriteKit

class AdventureScene: SKScene {
	
	enum Error: ErrorType {
		
		enum NodeType {
			case Background
			case Character
		}
		
		case TagIDInvalid(tag: Int, nodeType: NodeType)
		case FileNotExist(filename: String)
	}
	
	lazy var screenCurtain: SKSpriteNode = {
		let node = SKSpriteNode()
		node.size = self.size
		node.color = .blackColor()
		node.alpha = 0
		node.zPosition = 100
		return node
	}()
	
	lazy var backgrounds: [SKSpriteNode] = {
		let backgrounds = (0 ..< 5).map({ (_) -> SKSpriteNode in
			let node = SKSpriteNode()
			node.alpha = 0
			node.zPosition = 0
			return node
		})
		return backgrounds
	}()
	
	lazy var characters: [SKSpriteNode] = {
		let characters = (0 ..< 10).map({ (_) -> SKSpriteNode in
			let node = SKSpriteNode()
			node.alpha = 0
			node.zPosition = 10
			return node
		})
		return characters
	}()
	
	override func didMoveToView(view: SKView) {
		
		self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
		
		self.addChild(self.screenCurtain)
		
		self.backgrounds.forEach { (node) in
			self.addChild(node)
		}
		self.characters.forEach { (node) in
			self.addChild(node)
		}
		
	}
	
	func showScreen(within duration: NSTimeInterval, waitUntilEnd shouldWait: Bool) {
		
		let action = SKAction.fadeAlphaTo(0, duration: duration)
		
		if shouldWait {
			let semaphore = GCD.createSemaphore(0)
			GCD.runAsynchronizedQueue(with: { 
				self.screenCurtain.runAction(action, completion: {
					GCD.fireSemaphore(semaphore)
				})
			})
			GCD.waitForSemaphore(semaphore)
			
		} else {
			GCD.runAsynchronizedQueue(with: { 
				self.screenCurtain.runAction(action)
			})
		}
		
	}
	
	func hideScreen(within duration: NSTimeInterval, usingColor color: UIColor, waitUntilEnd shouldWait: Bool) {
		
		let action = SKAction.fadeAlphaTo(1, duration: duration)
		self.screenCurtain.color = color
		
		if shouldWait {
			let semaphore = GCD.createSemaphore(0)
			GCD.runAsynchronizedQueue(with: { 
				self.screenCurtain.runAction(action, completion: { 
					GCD.fireSemaphore(semaphore)
				})
			})
			GCD.waitForSemaphore(semaphore)
			
		} else {
			GCD.runAsynchronizedQueue(with: { 
				self.screenCurtain.runAction(action)
			})
		}
		
	}
	
	func setBackground(on tag: Int, with file: String) throws {
		
		guard tag …= self.backgrounds.indexRange else {
			throw Error.TagIDInvalid(tag: tag, nodeType: .Background)
		}
		
		guard let image = UIImage(named: file) ?? UIImage(named: file + ".png") ?? UIImage(named: file + ".jpg") else {
			throw Error.FileNotExist(filename: file)
		}
		
		let background = self.backgrounds[tag]
		let texture = SKTexture(image: image)
		background.texture = texture
		background.size = texture.size()
		
	}
	
	func fadeBackground(on tag: Int, to alpha: CGFloat, within duration: NSTimeInterval, waitUntilEnd shouldWait: Bool) throws {
		
		guard tag …= self.backgrounds.indexRange else {
			throw Error.TagIDInvalid(tag: tag, nodeType: .Background)
		}
		
		let background = self.backgrounds[tag]
		let action = SKAction.fadeAlphaTo(alpha, duration: duration)
		if shouldWait {
			let semaphore = GCD.createSemaphore(0)
			GCD.runAsynchronizedQueue(with: { 
				background.runAction(action, completion: { 
					GCD.fireSemaphore(semaphore)
				})
			})
			GCD.waitForSemaphore(semaphore)
			
		} else {
			GCD.runAsynchronizedQueue(with: { 
				background.runAction(action)
			})
		}
		
	}
	
	func setCharacter(on tag: Int, with file: String, `as` name: String?) throws {
		
		guard tag …= self.characters.indexRange else {
			throw Error.TagIDInvalid(tag: tag, nodeType: .Character)
		}
		
		guard let image = UIImage(named: file) ?? UIImage(named: file + ".png") ?? UIImage(named: file + ".jpg") else {
			throw Error.FileNotExist(filename: file)
		}
		
		let character = self.characters[tag]
		let texture = SKTexture(image: image)
		character.texture = texture
		character.size = texture.size()
		
	}
	
	func fadeCharacter(on tag: Int, to alpha: CGFloat, within duration: NSTimeInterval, waitUntilEnd shouldWait: Bool) throws {
		
		guard tag …= self.characters.indexRange else {
			throw Error.TagIDInvalid(tag: tag, nodeType: .Background)
		}
		
		let character = self.characters[tag]
		let action = SKAction.fadeAlphaTo(alpha, duration: duration)
		if shouldWait {
			let semaphore = GCD.createSemaphore(0)
			GCD.runAsynchronizedQueue(with: {
				character.runAction(action, completion: {
					GCD.fireSemaphore(semaphore)
				})
			})
			GCD.waitForSemaphore(semaphore)
			
		} else {
			GCD.runAsynchronizedQueue(with: {
				character.runAction(action)
			})
		}
		
	}
	
}
