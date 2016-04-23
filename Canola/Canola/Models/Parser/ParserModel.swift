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
	
	private var isParsingEnabled: Bool {
		return !self.isStandBying
	}
	
	init(initialScript: String) throws {
		
		self.queue = dispatch_queue_create(initialScript, DISPATCH_QUEUE_SERIAL)
		
		let script = try Script(filename: initialScript)
		let startLine = script.getIndex(forLabel: "start") ?? 0
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
			self.parseScript()
		}
		
	}
	
}

extension ParserModel {
	
	private func parseScript() {
		
		guard self.isParsingEnabled else {
			return
		}
		
		do {
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
				self.parseGraphincCommand(command)
				self.currentLine.increase()
				
			case .AudioControl(command: let command):
				self.parseAudioCommand(command)
				self.currentLine.increase()
				
			case .FlowControl(command: let command):
				self.parseFlowControlCommand(command)
				self.currentLine.increase()
				
			case .UserInteraction(command: let command):
				self.parseUserInteractionCommand(command)
				self.currentLine.increase()
			}
			
			return parseScript()
			
		} catch let error {
			Console.shared.warning(error)
			return
		}
		
	}
	
}
