//
//  SpriteKitExtensions.swift
//  Canola
//
//  Created by 史翔新 on 2016/05/02.
//  Copyright © 2016年 史翔新. All rights reserved.
//

import SpriteKit

extension SKSpriteNode {
	
	convenience init(referenceNode: SKSpriteNode) {
		self.init(texture: referenceNode.texture)
		self.anchorPoint = referenceNode.anchorPoint
		self.size = referenceNode.size
		self.position = referenceNode.position
		self.zPosition = referenceNode.zPosition
		self.alpha = referenceNode.alpha
	}
	
}
