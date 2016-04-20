//
//  ParserModel.swift
//  Canola
//
//  Created by 史翔新 on 2016/04/21.
//  Copyright © 2016年 史翔新. All rights reserved.
//

import UIKit

class ParserModel: NSObject {
	
	var script: Script
	
	override init() {
		do {
			let script = try Script(filename: "general01")
			self.script = script
			
		} catch let error {
			print(error)
			self.script = Script(lines: [])
		}
	}
	
	func parse() {
		self.script.lines.forEach { (command) in
			print(command)
		}
	}
	
}
