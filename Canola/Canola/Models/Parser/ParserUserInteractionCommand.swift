//
//  ParserUserInteractionCommand.swift
//  Canola
//
//  Created by 史翔新 on 2016/04/23.
//  Copyright © 2016年 史翔新. All rights reserved.
//

import Foundation

extension ParserModel {
	
	func parseUserInteractionCommand(command: Script.Command.UserInteractionCommand) {
		
		switch command {
		case .Message(speaker: _, voice: _, message: _):
			break
			
		case .Selection:
			break
		}
		
	}
	
}
