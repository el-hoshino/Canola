//
//  MessageWindowNode.swift
//  Canola
//
//  Created by 史翔新 on 2016/05/02.
//  Copyright © 2016年 史翔新. All rights reserved.
//

import SpriteKit

class MessageWindowNode: SKSpriteNode {
	
	private let fontSize: CGFloat = 40
	private let font = UIFont.systemFontOfSize(40)
	private lazy var _messageLabel: UILabel = {
		let label = UILabel(frame: CGRect(x: 20, y: 20, width: self.size.width - 40, height: self.size.height - 40))
		label.font = self.font
		return label
	}()
	
	lazy var messageLabels: [SKLabelNode] = {
		let nodes = (0 ..< 3).map { (i) -> SKLabelNode in
			let node = SKLabelNode()
			node.fontName = self.font.fontName
			node.fontSize = self.fontSize
			node.color = .redColor()
			node.horizontalAlignmentMode = .Left
			node.verticalAlignmentMode = .Baseline
			node.position = CGPoint(x: (-self.size.width / 2) + 20, y: (CGFloat(-i) * self.fontSize) + self.fontSize)
			self.addChild(node)
			return node
		}
		return nodes
	}()
	
}

extension MessageWindowNode {
	
	func hide() {
		self.alpha = 0
	}

	func setMessage(message: String?) {
		
		if let message = message {
			self.alpha = 1
			self._messageLabel.text = message
			let messageLines = self._messageLabel.getLinesArrayOfText()
			messageLines.enumerate().forEach { (i, message) in
				self.messageLabels[i].text = message
			}
			
		} else {
			self.messageLabels.forEach { (node) in
				node.text = nil
			}
		}
		
	}
	
}
