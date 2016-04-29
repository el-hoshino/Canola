//
//  Extensions.swift
//  Canola
//
//  Created by 史翔新 on 2016/04/19.
//  Copyright © 2016年 史翔新. All rights reserved.
//

import Foundation
import SpriteKit

extension RandomAccessIndexType {
	
	var increased: Self {
		return self.advancedBy(1)
	}
	
	mutating func increase() {
		self = self.advancedBy(1)
	}
	
	var decreased: Self {
		return self.advancedBy(-1)
	}
	
	mutating func decrease() {
		self = self.advancedBy(-1)
	}
	
}

extension CollectionType {
	
	var indexRange: Range<Self.Index> {
		return self.startIndex ..< self.endIndex
	}
	
}

extension String {
	
	var trimmed: String {
		return self.stringByTrimmingCharactersInSet(.whitespaceAndNewlineCharacterSet())
	}
	
	var first: Character? {
		return self.characters.first
	}
	
	func flatComponentsSeparatedByString(seperator: String) -> [String] {
		let components = self.componentsSeparatedByString(seperator).flatMap { (component) -> String? in
			let component = component.trimmed
			return component.isEmpty ? nil : component
		}
		return components
	}
	
}

extension Array {
	
	func appending(element: Element) -> Array<Element> {
		var array = self
		array.append(element)
		return array
	}
	
}

extension Dictionary {
	
	func appendingValue(value: Value, forKey key: Key) -> Dictionary<Key, Value> {
		var dictionary = self
		dictionary[key] = value
		return dictionary
	}
	
}

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
