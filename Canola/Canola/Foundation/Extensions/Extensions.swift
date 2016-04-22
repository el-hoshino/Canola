//
//  Extensions.swift
//  Canola
//
//  Created by 史翔新 on 2016/04/19.
//  Copyright © 2016年 史翔新. All rights reserved.
//

import Foundation

extension RandomAccessIndexType {
	
	mutating func increase() {
		self = self.advancedBy(1)
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
