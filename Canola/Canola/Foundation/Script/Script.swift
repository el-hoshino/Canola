//
//  Script.swift
//  Canola
//
//  Created by 史翔新 on 2016/04/19.
//  Copyright © 2016年 史翔新. All rights reserved.
//

import Foundation

struct Script {
	
	enum Command {
		
		case Meta(command: MetaCommand)
		case General(command: GeneralCommand)
		case GraphicControl(command: GraphicControlCommand)
		case AudioControl(command: AudioControlCommand)
		case FlowControl(command: FlowControlCommand)
		case UserInteraction(command: UserInteractionCommand)
		
	}
	
	private let labels: [String: Int]
	private let lines: [Command]
	
	func getCommand(at lineIndex: Int) throws -> Command {
		
		enum Error: ErrorType {
			case InvalidLineIndex(index: Int)
		}
		
		guard lineIndex …= self.lines.startIndex ..< self.lines.endIndex else {
			throw Error.InvalidLineIndex(index: lineIndex)
		}
		
		return self.lines[lineIndex]
		
	}
	
	func getIndex(forLabel label: String) -> Int? {
		return self.labels[label]
	}
	
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
			case .Meta(command: let command):
				switch command {
				case .Label(label: let label):
					return current.appendingValue(nextLine.index, forKey: label)
				}
				
			default:
				return current
			}
		}
		
		self.lines = lines
		self.labels = labels
		
	}
	
}
