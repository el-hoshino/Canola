//
//  Command.swift
//  Canola
//
//  Created by 史翔新 on 2016/04/19.
//  Copyright © 2016年 史翔新. All rights reserved.
//

import Foundation

private extension NSCharacterSet {
	
	static let commandTypeStringSeperatorSet = NSCharacterSet(charactersInString: " \t")
	
}

private extension String {
	
	typealias Parameter = (name: String?, value: String)
	
	func dropFirst(n: Int = 1) -> String {
		return self.substringFromIndex(self.startIndex.advancedBy(n))
	}
	
	func dropLast(n: Int = 1) -> String {
		return self.substringToIndex(self.endIndex.advancedBy(-n))
	}
	
	var commandComponents: (type: String, parameters: [Parameter])? {
		
		let commandString = self.trimmed
		guard let first = commandString.first else {
			return nil
		}
		
		func retrieveParameters(from string: String) -> [Parameter] {
			let parameters = string.trimmed.flatComponentsSeparatedByString(",").flatMap { (parameter) -> (name: String?, value: String)? in
				let components = parameter.flatComponentsSeparatedByString(":")
				if components.count > 1 {
					let name = components[0]
					let value = components[1]
					return (name, value)
					
				} else if components.count > 0 {
					let value = components[0]
					return (nil, value)
					
				} else {
					return nil
				}
			}
			return parameters
		}
		
		switch first {
		case ".":
			let separatorIndex = commandString.rangeOfCharacterFromSet(.commandTypeStringSeperatorSet)?.startIndex ?? commandString.endIndex
			let type = commandString.substringToIndex(separatorIndex).trimmed
			let parameters = retrieveParameters(from: commandString.substringFromIndex(separatorIndex))
			return (type, parameters)
			
		case "#":
			let type = ".Label"
			let parameters = retrieveParameters(from: commandString.dropFirst())
			return (type, parameters)
			
		default:
			if commandString.hasPrefix("@"), let speakerSeparator = commandString.rangeOfString(":")?.endIndex {
				let type = ".Message"
				let speaker = commandString.substringToIndex(speakerSeparator).dropFirst().dropLast()
				let speakerParameterString = "speaker: \(speaker)"
				let parameterString = speakerParameterString + ", " + commandString.substringFromIndex(speakerSeparator)
				let parameters = retrieveParameters(from: parameterString)
				return (type, parameters)
				
			} else {
				let type = ".Message"
				let parameters = retrieveParameters(from: commandString)
				return (type, parameters)
			}
		}
		
	}
	
}

extension Script {
	
	enum Command {
		
		private static let commandTypeStringSeperatorSet = NSCharacterSet(charactersInString: " \t")
		
		case Label(label: String)
		
		case Init
		
		case ShowScreen(time: NSTimeInterval, wait: Bool)
		case HideScreen(time: NSTimeInterval, color: UIColor, wait: Bool)
		
		case ShowBG(file: String, tag: Int, duration: NSTimeInterval)
		case HideBG(tag: Int, duration: NSTimeInterval)
		
		case ShowCHA(file: String, tag: Int, characterName: String, duration: NSTimeInterval)
		case HideCHA(tag: Int, duration: NSTimeInterval)
		
		case Message(speaker: String?, voice: String?, message: String)
		
		case Return
		
		case End
		
	}
	
}

extension Script.Command {

	enum InitError: ErrorType {
		case NonOptionalParameterMissing(command: String)
		case InvalidCommandString(string: String)
	}
	
	init?(commandString: String) throws {
		
		guard let command = commandString.commandComponents else {
			return nil
		}
		
		switch command.type {
		case ".Label":
			var label: String?
			command.parameters.forEach({ (parameter) in
				if parameter.name == nil {
					label = parameter.value
				}
			})
			guard let labelName = label else {
				throw InitError.NonOptionalParameterMissing(command: commandString)
			}
			self = .Label(label: labelName)
			
		case ".Init":
			self = .Init
			
		case ".ShowScreen":
			var time: NSTimeInterval = 1
			var wait = false
			command.parameters.forEach({ (parameter) in
				if let name = parameter.name {
					switch name {
					case "time":
						let timeValue = NSTimeInterval(parameter.value) ?? time
						time = timeValue
						
					case "wait":
						let waitValue = parameter.value
						wait = waitValue == "true" ? true : false
						
					default:
						break
					}
				}
			})
			self = .ShowScreen(time: time, wait: wait)
			
		case ".HideScreen":
			var time: NSTimeInterval = 1
			var color = UIColor.blackColor()
			var wait = false
			command.parameters.forEach({ (parameter) in
				if let name = parameter.name {
					switch name {
					case "time":
						time =? NSTimeInterval(parameter.value)
						
					case "color":
						let colorValue = parameter.value
						switch colorValue {
						case "black":
							color = .blackColor()
							
						case "white":
							color = .whiteColor()
							
						default:
							//TODO: ColorFromInt
							break
						}
						
					case "wait":
						let waitValue = parameter.value
						wait = waitValue == "true" ? true : false
						
					default:
						break
					}
				}
			})
			self = .HideScreen(time: time, color: color, wait: wait)
			
		case ".ShowBG":
			var bgFile: String?
			var bgTag = 0
			var time: NSTimeInterval = 1
			command.parameters.forEach({ (parameter) in
				if let name = parameter.name {
					switch name {
					case "tag":
						bgTag =? Int(parameter.value)
						
					case "time":
						time =? NSTimeInterval(parameter.value)
						
					default:
						break
					}
					
				} else {
					bgFile = parameter.value
				}
			})
			guard let file = bgFile else {
				throw InitError.InvalidCommandString(string: commandString)
			}
			self = .ShowBG(file: file, tag: bgTag, duration: time)
			
		case ".HideBG":
			var bgTag = 0
			var time: NSTimeInterval = 1
			command.parameters.forEach({ (parameter) in
				if let name = parameter.name {
					switch name {
					case "tag":
						bgTag =? Int(parameter.value)
						
					case "time":
						time =? NSTimeInterval(parameter.value)
						
					default:
						break
					}
				}
			})
			self = .HideBG(tag: bgTag, duration: time)
			
		case ".ShowCHA":
			var chaFile: String?
			var chaTag = 0
			var chaName = String()
			var time: NSTimeInterval = 1
			command.parameters.forEach({ (parameter) in
				if let name = parameter.name {
					switch name {
					case "tag":
						chaTag =? Int(parameter.value)
						
					case "name":
						chaName = parameter.value
						
					case "time":
						time =? NSTimeInterval(parameter.value)
						
					default:
						break
					}
					
				} else {
					chaFile = parameter.value
				}
			})
			guard let file = chaFile else {
				throw InitError.NonOptionalParameterMissing(command: commandString)
			}
			self = .ShowCHA(file: file, tag: chaTag, characterName: chaName, duration: time)
			
		case ".HideCHA":
			var chaTag = 0
			var time: NSTimeInterval = 1
			command.parameters.forEach({ (parameter) in
				if let name = parameter.name {
					switch name {
					case "tag":
						chaTag =? Int(parameter.value)
						
					case "time":
						time =? NSTimeInterval(parameter.value)
						
					default:
						break
					}
				}
			})
			self = .HideCHA(tag: chaTag, duration: time)
			
		case ".Message":
			var speaker: String?
			var voice: String?
			var message: String?
			command.parameters.forEach({ (parameter) in
				if let name = parameter.name {
					switch name {
					case "speaker":
						speaker = parameter.value
						
					case "voice":
						voice = parameter.value
						
					default:
						break
					}
					
				} else {
					message = parameter.value
				}
			})
			guard let messageText = message else {
				throw InitError.NonOptionalParameterMissing(command: commandString)
			}
			self = .Message(speaker: speaker, voice: voice, message: messageText)
			
		case ".Return":
			self = .Return
			
		case ".End":
			self = .End
			
		default:
			throw InitError.InvalidCommandString(string: commandString)
		}
	}
}
