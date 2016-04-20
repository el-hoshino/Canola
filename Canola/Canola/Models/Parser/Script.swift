//
//  Script.swift
//  Canola
//
//  Created by 史翔新 on 2016/04/19.
//  Copyright © 2016年 史翔新. All rights reserved.
//

import Foundation

struct Script {
	
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
		
		self.lines = lines
		
	}
	
}
