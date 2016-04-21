//
//  Script.swift
//  Canola
//
//  Created by 史翔新 on 2016/04/19.
//  Copyright © 2016年 史翔新. All rights reserved.
//

import Foundation

struct Script {
	
	let labels: [String: Int]
	let lines: [Command]
	
}

extension Script {
	
	enum InitError: ErrorType {
		case FileNotFound(filename: String)
	}
	
	init(filename: String) throws {
		
		guard let fileURL = NSBundle.mainBundle().URLForResource(filename, withExtension: "script") else {
			throw InitError.FileNotFound(filename: filename)
		}
		
		let file = try String(contentsOfURL: fileURL)
		
		let lines = try file.componentsSeparatedByString("\n").flatMap { (line) throws -> Command? in
			return try Command(commandString: line)
		}
		
		let labels = lines.enumerate().reduce([String: Int]()) { (current, nextLine) -> [String: Int] in
			switch nextLine.element {
			case .Label(label: let label):
				var current = current
				current[label] = nextLine.index
				return current
				
			default:
				return current
			}
		}
		
		self.lines = lines
		self.labels = labels
		
	}
	
}
