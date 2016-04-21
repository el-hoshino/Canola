//
//  ParserModel.swift
//  Canola
//
//  Created by 史翔新 on 2016/04/21.
//  Copyright © 2016年 史翔新. All rights reserved.
//

import UIKit

class ParserModel: NSObject {
	
	private var currentScript: Script
	private var currentLine: Int
	private var scriptStack: ScriptStack
	
	override init() {
		
		do {
			let script = try Script(filename: "general01")
			let startLine = script.labels["start"] ?? 0
			self.currentScript = script
			self.currentLine = startLine
			self.scriptStack = ScriptStack.initial()
			
		} catch let error {
			print(error)
			self.currentScript = Script(labels: [:], lines: [])
			self.currentLine = 0
			self.scriptStack = ScriptStack.initial()
		}
		
	}
	
	func parse() {
		self.currentScript.lines.forEach { (command) in
			print(command)
		}
	}
	
}
