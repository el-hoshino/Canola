//
//  ScriptStack.swift
//  Canola
//
//  Created by 史翔新 on 2016/04/22.
//  Copyright © 2016年 史翔新. All rights reserved.
//

import Foundation

extension ParserModel {
	
	struct ScriptStack {
		
		private struct Element {
			let script: Script
			let line: Int
		}
		
		private var stack: [Element]
		
		static func initial() -> ScriptStack {
			return ScriptStack(stack: [])
		}
		
		mutating func append(script script: Script, line: Int) {
			let newElement = Element(script: script, line: line)
			self.stack.append(newElement)
		}
		
		mutating func retrieveLast() throws -> (script: Script, line: Int) {
			
			enum Error: ErrorType {
				case StackIsEmpty
			}
			
			guard let lastStack = self.stack.last else {
				throw Error.StackIsEmpty
			}
			
			self.stack.removeLast()
			return (lastStack.script, lastStack.line)
			
		}
		
	}
	
}
