//
//  UserInteractionCommand.swift
//  Canola
//
//  Created by 史翔新 on 2016/04/23.
//  Copyright © 2016年 史翔新. All rights reserved.
//

import Foundation

extension Script.Command {
	
	enum UserInteractionCommand {
		case Message(speaker: String?, voice: String?, message: String)
		case Selection
	}
	
}

extension Script.Command.UserInteractionCommand: CustomStringConvertible {
	
	var description: String {
		
		switch self {
		case .Message(speaker: let speaker, voice: let voice, message: let message):
			return ".Message\tspeaker: \(speaker), voice: \(voice), \(message)"
			
		case .Selection:
			return "Selection"
		}
		
	}
	
}
