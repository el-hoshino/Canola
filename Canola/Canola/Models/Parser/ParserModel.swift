//
//  ParserModel.swift
//  Canola
//
//  Created by 史翔新 on 2016/04/21.
//  Copyright © 2016年 史翔新. All rights reserved.
//

import UIKit

protocol ParserModelGraphicDelegate {
	
	func showScreen(within duration: NSTimeInterval, waitUntilEnd shouldWait: Bool)
	func hideScreen(within duration: NSTimeInterval, usingColor color: UIColor, waitUntilEnd shouldWait: Bool)
	
	func initializeBackground(on tag: Int) throws
	func setBackground(on tag: Int, with file: String, within duration: NSTimeInterval) throws
	func showBackground(on tag: Int, within duration: NSTimeInterval, waitUntilEnd shouldWait: Bool) throws
	func hideBackground(on tag: Int, within duration: NSTimeInterval, waitUntilEnd shouldWait: Bool) throws
	
	func initializeCharacter(on tag: Int) throws
	func setCharacter(on tag: Int, with file: String, within duration: NSTimeInterval, `as` name: String?) throws
	func showCharacter(on tag: Int, within duration: NSTimeInterval, waitUntilEnd shouldWait: Bool) throws
	func hideCharacter(on tag: Int, within duration: NSTimeInterval, waitUntilEnd shouldWait: Bool) throws
	
}

class ParserModel: NSObject {
	
	var graphicDelegate: ParserModelGraphicDelegate?
	
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
	
	func disableStandbying() {
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
	
	func enterNext(line: Int? = nil) {
		
		guard self.isStandBying else {
			return
		}
		
		if let line = line {
			self.currentLine = line
		} else {
			self.currentLine.increase()
		}
		
		self.disableStandbying()
		self.parse()
		
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
			self.parseMetaCommand(command)
			self.currentLine.increase()
			
		case .General(command: let command):
			self.parseGeneralCommand(command)
			self.currentLine.increase()
			
		case .GraphicControl(command: let command):
			try self.parseGraphincCommand(command)
			self.currentLine.increase()
			
		case .AudioControl(command: let command):
			self.parseAudioCommand(command)
			self.currentLine.increase()
			
		case .FlowControl(command: let command):
			try self.parseFlowControlCommand(command)
			
		case .UserInteraction(command: let command):
			self.parseUserInteractionCommand(command)
			self.isStandBying = true
		}
		
		return try self.parseScript()
		
	}
	
}

// MARK: MetaCommand
extension ParserModel {
	
	private func parseMetaCommand(command: Script.Command.MetaCommand) {
		
		switch command {
		case .Label:
			break
		}
		
	}
	
}

// MARK: GeneralCommand
extension ParserModel {
	
	private func parseGeneralCommand(command: Script.Command.GeneralCommand) {
		
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
		case .ShowScreen(duration: let duration, waitUntilEnd: let shouldWait):
			self.graphicDelegate?.showScreen(within: duration, waitUntilEnd: shouldWait)
			
		case .HideScreen(duration: let duration, color: let color, waitUntilEnd: let shouldWait):
			self.graphicDelegate?.hideScreen(within: duration, usingColor: color, waitUntilEnd: shouldWait)
			
		case .InitBG(tag: let tag):
			try self.graphicDelegate?.initializeBackground(on: tag)
			
		case .SetBG(tag: let tag, file: let file, duration: let duration):
			try self.graphicDelegate?.setBackground(on: tag, with: file, within: duration)
			
		case .ShowBG(tag: let tag, duration: let duration, waitUntilEnd: let shouldWait):
			try self.graphicDelegate?.showBackground(on: tag, within: duration, waitUntilEnd: shouldWait)
			
		case .HideBG(tag: let tag, duration: let duration, waitUntilEnd: let shouldWait):
			try self.graphicDelegate?.hideBackground(on: tag, within: duration, waitUntilEnd: shouldWait)
			
		case .InitCHA(tag: let tag):
			try self.graphicDelegate?.initializeCharacter(on: tag)
			
		case .SetCHA(tag: let tag, file: let file, duration: let duration, characterName: let name):
			try self.graphicDelegate?.setCharacter(on: tag, with: file, within: duration, as: name)
			
		case .ShowCHA(tag: let tag, duration: let duration, waitUntilEnd: let shouldWait):
			try self.graphicDelegate?.showCharacter(on: tag, within: duration, waitUntilEnd: shouldWait)
			
		case .HideCHA(tag: let tag, duration: let duration, waitUntilEnd: let shouldWait):
			try self.graphicDelegate?.hideCharacter(on: tag, within: duration, waitUntilEnd: shouldWait)
		}
		
	}
	
}

// MARK: AudioControlCommand
extension ParserModel {
	
	private func parseAudioCommand(command: Script.Command.AudioControlCommand) {
		
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
	
	private func parseUserInteractionCommand(command: Script.Command.UserInteractionCommand) {
		
		switch command {
		case .Message(speaker: _, voice: _, message: _):
			break
			
		case .Selection:
			break
		}
		
	}
	
}

