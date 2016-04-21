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
		
		struct Element {
			let script: String
			let line: Int
		}
		
		private var stack: [Element]
		
		static func initial() -> ScriptStack {
			return ScriptStack(stack: [])
		}
		
	}
	
}
