//
//  Command.swift
//  Canola
//
//  Created by 史翔新 on 2016/04/19.
//  Copyright © 2016年 史翔新. All rights reserved.
//

import Foundation

extension Script.Command: CustomStringConvertible {
	
	var description: String {
		
		switch self {
		case .Meta(command: let command):
			return command.description
			
		case .General(command: let command):
			return command.description
			
		case .GraphicControl(command: let command):
			return command.description
			
		case .AudioControl(command: let command):
			return command.description
			
		case .FlowControl(command: let command):
			return command.description
			
		case .UserInteraction(command: let command):
			return command.description
		}
		
	}
	
}
