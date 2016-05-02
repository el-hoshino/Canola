//
//  CommandCreator.swift
//  Canola
//
//  Created by 史翔新 on 2016/04/23.
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

extension Script.Command {
	
	static func createCommandArray(from commandString: String) throws -> [Script.Command] {
		
		enum Error: ErrorType {
			case NonOptionalParameterMissing(command: String)
			case InvalidCommandString(string: String)
		}
		
		guard let command = commandString.commandComponents else {
			return []
		}
		
		switch command.type {
			
			// MARK: MetaCommand
		case ".Label":
			var label: String?
			command.parameters.forEach({ (parameter) in
				if parameter.name == nil {
					label = parameter.value
				}
			})
			guard let labelName = label else {
				throw Error.NonOptionalParameterMissing(command: commandString)
			}
			let metaCommand = MetaCommand.Label(label: labelName)
			return [.Meta(command: metaCommand)]
			
			// MARK: GeneralCommand
		case ".Init":
			let generalCommand = GeneralCommand.Init
			return [.General(command: generalCommand)]
			
			// MARK: GraphicControlCommand
		case ".ShowScreen":
			var time: NSTimeInterval = 1
			var wait = false
			command.parameters.forEach({ (parameter) in
				if let name = parameter.name {
					switch name {
					case "time":
						time =? NSTimeInterval(parameter.value)
						
					case "wait":
						let waitValue = parameter.value
						wait = waitValue == "true" ? true : false
						
					default:
						break
					}
				}
			})
			let graphicCommand = GraphicControlCommand.ShowScreen(duration: time, waitUntilEnd: wait)
			return [.GraphicControl(command: graphicCommand)]
			
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
			let graphicCommand = GraphicControlCommand.HideScreen(duration: time, color: color, waitUntilEnd: wait)
			return [.GraphicControl(command: graphicCommand)]
			
		case ".InitBG":
			var bgTag = 0
			command.parameters.forEach({ (parameter) in
				if let name = parameter.name {
					switch name {
					case "tag":
						bgTag =? Int(parameter.value)
						
					default:
						break
					}
				}
			})
			let graphicCommand = GraphicControlCommand.InitBG(tag: bgTag)
			return [.GraphicControl(command: graphicCommand)]
			
		case ".SetBG":
			var bgTag = 0
			var bgFile: String?
			var time: NSTimeInterval = 0
			var wait = false
			command.parameters.forEach({ (parameter) in
				if let name = parameter.name {
					switch name {
					case "tag":
						bgTag =? Int(parameter.value)
						
					case "file":
						bgFile = parameter.value
						
					case "time":
						time =? NSTimeInterval(parameter.value)
						
					case "wait":
						let waitValue = parameter.value
						wait = waitValue == "true" ? true : false
						
					default:
						break
					}
				}
			})
			guard let file = bgFile else {
				throw Error.NonOptionalParameterMissing(command: commandString)
			}
			let graphicCommand = GraphicControlCommand.SetBG(tag: bgTag, file: file, duration: time, waitUntilEnd: wait)
			return [.GraphicControl(command: graphicCommand)]
			
		case ".ShowBG":
			var bgTag = 0
			var time: NSTimeInterval = 1
			var wait = false
			command.parameters.forEach({ (parameter) in
				if let name = parameter.name {
					switch name {
					case "tag":
						bgTag =? Int(parameter.value)
						
					case "time":
						time =? NSTimeInterval(parameter.value)
						
					case "wait":
						let waitValue = parameter.value
						wait = waitValue == "true" ? true : false
						
					default:
						break
					}
				}
			})
			let graphicCommand = GraphicControlCommand.ShowBG(tag: bgTag, duration: time, waitUntilEnd: wait)
			return [.GraphicControl(command: graphicCommand)]
			
		case ".HideBG":
			var bgTag = 0
			var time: NSTimeInterval = 1
			var wait = false
			command.parameters.forEach({ (parameter) in
				if let name = parameter.name {
					switch name {
					case "tag":
						bgTag =? Int(parameter.value)
						
					case "time":
						time =? NSTimeInterval(parameter.value)
						
					case "wait":
						let waitValue = parameter.value
						wait = waitValue == "true" ? true : false
						
					default:
						break
					}
				}
			})
			let graphicCommand = GraphicControlCommand.HideBG(tag: bgTag, duration: time, waitUntilEnd: wait)
			return [.GraphicControl(command: graphicCommand)]
			
		case ".InitCHA":
			var chaTag = 0
			command.parameters.forEach({ (parameter) in
				if let name = parameter.name {
					switch name {
					case "tag":
						chaTag =? Int(parameter.value)
						
					default:
						break
					}
				}
			})
			let graphicCommand = GraphicControlCommand.InitCHA(tag: chaTag)
			return [.GraphicControl(command: graphicCommand)]
			
		case ".SetCHA":
			var chaTag = 0
			var chaFile: String?
			var chaName: String?
			var time: NSTimeInterval = 0
			var wait = false
			command.parameters.forEach({ (parameter) in
				if let name = parameter.name {
					switch name {
					case "tag":
						chaTag =? Int(parameter.value)
						
					case "file":
						chaFile = parameter.value
						
					case "name":
						chaName = parameter.value
						
					case "time":
						time =? NSTimeInterval(parameter.value)
						
					case "wait":
						let waitValue = parameter.value
						wait = waitValue == "true" ? true : false
						
					default:
						break
					}
				}
			})
			guard let file = chaFile else {
				throw Error.NonOptionalParameterMissing(command: commandString)
			}
			let graphicCommand = GraphicControlCommand.SetCHA(tag: chaTag, file: file, characterName: chaName, duration: time, waitUntilEnd: wait)
			return [.GraphicControl(command: graphicCommand)]
			
		case ".ShowCHA":
			var chaTag = 0
			var time: NSTimeInterval = 1
			var wait = false
			command.parameters.forEach({ (parameter) in
				if let name = parameter.name {
					switch name {
					case "tag":
						chaTag =? Int(parameter.value)
						
					case "time":
						time =? NSTimeInterval(parameter.value)
						
					case "wait":
						let waitValue = parameter.value
						wait = waitValue == "true" ? true : false
						
					default:
						break
					}
				}
			})
			let graphicCommand = GraphicControlCommand.ShowCHA(tag: chaTag, duration: time, waitUntilEnd: wait)
			return [.GraphicControl(command: graphicCommand)]
			
		case ".HideCHA":
			var chaTag = 0
			var time: NSTimeInterval = 1
			var wait = false
			command.parameters.forEach({ (parameter) in
				if let name = parameter.name {
					switch name {
					case "tag":
						chaTag =? Int(parameter.value)
						
					case "time":
						time =? NSTimeInterval(parameter.value)
						
					case "wait":
						let waitValue = parameter.value
						wait = waitValue == "true" ? true : false
						
					default:
						break
					}
				}
			})
			let graphicCommand = GraphicControlCommand.HideCHA(tag: chaTag, duration: time, waitUntilEnd: wait)
			return [.GraphicControl(command: graphicCommand)]
			
		case ".HideMessageWindow":
			let graphicCommand = GraphicControlCommand.HideMessageWindow
			return [.GraphicControl(command: graphicCommand)]
			
			// MARK: AudioControlCommand
		case ".PlayBGM":
			var bgmFile: String?
			var channel = 0
			command.parameters.forEach({ (parameter) in
				if let name = parameter.name {
					switch name {
					case "channel":
						channel =? Int(parameter.value)
						
					default:
						break
					}
					
				} else {
					bgmFile = parameter.value
				}
			})
			guard let file = bgmFile else {
				throw Error.NonOptionalParameterMissing(command: commandString)
			}
			let audioCommand = AudioControlCommand.PlayBGM(file: file, channel: channel)
			return [.AudioControl(command: audioCommand)]
			
		case ".StopBGM":
			var channel = 0
			command.parameters.forEach({ (parameter) in
				if let name = parameter.name {
					switch name {
					case "channel":
						channel =? Int(parameter.value)
						
					default:
						break
					}
				}
			})
			let audioCommand = AudioControlCommand.StopBGM(channel: channel)
			return [.AudioControl(command: audioCommand)]
			
			// MARK: FlowControlCommand
		case ".Jump":
			var jumpScript: String?
			var jumpLabel: String?
			command.parameters.forEach({ (parameter) in
				if let name = parameter.name {
					switch name {
					case "file":
						jumpScript = parameter.value
						
					case "label":
						jumpLabel = parameter.value
						
					default:
						break
					}
				} else {
					jumpLabel = parameter.value
				}
			})
			guard let label = jumpLabel else {
				throw Error.NonOptionalParameterMissing(command: commandString)
			}
			let flowControlCommand = FlowControlCommand.Jump(script: jumpScript, label: label)
			return [.FlowControl(command: flowControlCommand)]
			
		case ".Call":
			var callScript: String?
			var callLabel: String?
			command.parameters.forEach({ (parameter) in
				if let name = parameter.name {
					switch name {
					case "file":
						callScript = parameter.value
						
					case "label":
						callLabel = parameter.value
						
					default:
						break
					}
				} else {
					callLabel = parameter.value
				}
			})
			guard let label = callLabel else {
				throw Error.NonOptionalParameterMissing(command: commandString)
			}
			let flowControlCommand = FlowControlCommand.Call(script: callScript, label: label)
			return [.FlowControl(command: flowControlCommand)]
			
		case ".Return":
			let flowControlCommand = FlowControlCommand.Return
			return [.FlowControl(command: flowControlCommand)]
			
		case ".StandBy":
			let flowControlCommand = FlowControlCommand.StandBy
			return [.FlowControl(command: flowControlCommand)]
			
		case ".End":
			let flowControlCommand = FlowControlCommand.End
			return [.FlowControl(command: flowControlCommand)]
			
			// MARK: UserInteractionCommand
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
				throw Error.NonOptionalParameterMissing(command: commandString)
			}
			let userInteractionCommand = UserInteractionCommand.Message(speaker: speaker, voice: voice, message: messageText)
			let standByCommand = FlowControlCommand.StandBy
			let clearMessageCommand = UserInteractionCommand.ClearMessage
			return [.UserInteraction(command: userInteractionCommand), .FlowControl(command: standByCommand), .UserInteraction(command: clearMessageCommand)]
			
		case ".ClearMessage":
			let userInteractionCommand = UserInteractionCommand.ClearMessage
			return [.UserInteraction(command: userInteractionCommand)]
			
		case ".Selection":
			let userInteractionCommand = UserInteractionCommand.Selection
			return [.UserInteraction(command: userInteractionCommand)]
			
		default:
			throw Error.InvalidCommandString(string: commandString)
		}
	}
}
