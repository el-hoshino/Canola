//
//  ParserModel.swift
//  Canola
//
//  Created by 史翔新 on 2016/04/21.
//  Copyright © 2016年 史翔新. All rights reserved.
//

import UIKit

class ParserModel: NSObject {
	
	private let queue: dispatch_queue_t
	
	private var currentScript: Script
	private var currentLine: Int
	private var scriptStack: ScriptStack
	
	private var isStandBying = true
	private var isGameEnded = false
	
	private var isParsingEnabled: Bool {
		return !self.isStandBying && !self.isGameEnded
	}
	
	init(initialScript: String) throws {
		
		self.queue = dispatch_queue_create(initialScript, DISPATCH_QUEUE_SERIAL)
		
		let script = try Script(filename: initialScript)
		let startLine = (try? script.getIndex(forLabel: "start")) ?? 0
		self.currentScript = script
		self.currentLine = startLine
		self.scriptStack = ScriptStack.initial()
		
	}
	
	deinit {
		
		Console.shared.info("ParserModel deinited")
		
	}
	
	func enableParsing() {
		self.isStandBying = false
	}
	
	func parse() {
		
		GCD.runAsynchronizedQueue(at: .Static(queue: self.queue)) {
			do {
				try self.parseScript()
				
			} catch let error {
				Console.shared.warning(error)
				return
			}
		}
		
	}
	
}

// MARK: ParseCommand
extension ParserModel {
	
	private func parseScript() throws {
		
		guard self.isParsingEnabled else {
			return
		}
		
		let command = try self.currentScript.getCommand(at: self.currentLine)
		Console.shared.info(command)
		
		switch command {
		case .Meta(command: let command):
			try self.parseMetaCommand(command)
			self.currentLine.increase()
			
		case .General(command: let command):
			try self.parseGeneralCommand(command)
			self.currentLine.increase()
			
		case .GraphicControl(command: let command):
			try self.parseGraphincCommand(command)
			self.currentLine.increase()
			
		case .AudioControl(command: let command):
			try self.parseAudioCommand(command)
			self.currentLine.increase()
			
		case .FlowControl(command: let command):
			try self.parseFlowControlCommand(command)
			
		case .UserInteraction(command: let command):
			try self.parseUserInteractionCommand(command)
			self.currentLine.increase()
		}
		
		return try parseScript()
		
	}
	
}

// MARK: MetaCommand
extension ParserModel {
	
	private func parseMetaCommand(command: Script.Command.MetaCommand) throws {
		
		switch command {
		case .Label:
			break
		}
		
	}
	
}

// MARK: GeneralCommand
extension ParserModel {
	
	private func parseGeneralCommand(command: Script.Command.GeneralCommand) throws {
		
		switch command {
		case .Init:
			break
		}
		
	}
	
}

// MARK: GraphicControlCommand
extension ParserModel {
	
	private func parseGraphincCommand(command: Script.Command.GraphicControlCommand) throws {
		
		switch command {
		case .ShowScreen(duration: _, waitUntilEnd: _):
			break
			
		case .HideScreen(duration: _, color: _, waitUntilEnd: _):
			break
			
		case .ShowBG(file: _, tag: _, duration: _, waitUntilEnd: _):
			break
			
		case .HideBG(tag: _, duration: _, waitUntilEnd: _):
			break
			
		case .ShowCHA(file: _, tag: _, characterName: _, duration: _, waitUntilEnd: _):
			break
			
		case .HideCHA(tag: _, duration: _, waitUntilEnd: _):
			break
		}
		
	}
	
}

// MARK: AudioControlCommand
extension ParserModel {
	
	private func parseAudioCommand(command: Script.Command.AudioControlCommand) throws {
		
		switch command {
		case .PlayBGM(file: _, channel: _):
			break
			
		case .StopBGM(channel: _):
			break
		}
		
	}
	
}

// MARK: FlowControlCommand
extension ParserModel {
	
	private func parseFlowControlCommand(command: Script.Command.FlowControlCommand) throws {
		
		switch command {
		case .Jump(script: let script, label: let label):
			try self.jumpTo(script, at: label)
			
		case .Call(script: let script, label: let label):
			self.appendCurrentStack()
			try self.jumpTo(script, at: label)
			
		case .Return:
			try self.returnToLastStack()
			
		case .End:
			self.endGame()
		}
		
	}
	
	private func appendCurrentStack() {
		
		self.scriptStack.append(script: self.currentScript, line: self.currentLine)
		
	}
	
	private func jumpTo(script: String?, at label: String) throws {
		
		if let scriptName = script {
			let script = try Script(filename: scriptName)
			let targetLine = try script.getIndex(forLabel: label)
			self.currentScript = script
			self.currentLine = targetLine
			
		} else {
			let targetLine = try self.currentScript.getIndex(forLabel: label)
			self.currentLine = targetLine
		}
		
	}
	
	private func returnToLastStack() throws {
		
		let lastStack = try self.scriptStack.retrieveLast()
		self.currentScript = lastStack.script
		self.currentLine = lastStack.line.increased
		
	}
	
	private func endGame() {
		
		self.isGameEnded = true
		
	}
	
}

// MARK: UserInteractionControl
extension ParserModel {
	
	private func parseUserInteractionCommand(command: Script.Command.UserInteractionCommand) throws {
		
		switch command {
		case .Message(speaker: _, voice: _, message: _):
			break
			
		case .Selection:
			break
		}
		
	}
	
}

