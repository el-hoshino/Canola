//
//  FlowControlCommand.swift
//  Canola
//
//  Created by 史翔新 on 2016/04/23.
//  Copyright © 2016年 史翔新. All rights reserved.
//

import Foundation

extension Script.Command {
	
	enum FlowControlCommand {
		case Jump(script: String?, label: String)
		case Call(script: String?, label: String)
		case Return
		case End
	}
	
}

extension Script.Command.FlowControlCommand: CustomStringConvertible {
	
	var description: String {
		
		switch self {
		case .Jump(label: let label):
			return ".Jump\t\(label)"
			
		case .Call(label: let label):
			return ".Call\t\(label)"
			
		case .Return:
			return "Return"
			
		case .End:
			return "End"
		}
		
	}
	
}
