//
//  ParserFlowControlCommand.swift
//  Canola
//
//  Created by 史翔新 on 2016/04/23.
//  Copyright © 2016年 史翔新. All rights reserved.
//

import Foundation

extension ParserModel {
	
	func parseFlowControlCommand(command: Script.Command.FlowControlCommand) {
		
		switch command {
		case .Jump(label: _):
			break
			
		case .Call(label: _):
			break
			
		case .Return:
			break
			
		case .End:
			break
		}
		
	}
	
}
