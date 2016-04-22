//
//  MetaCommand.swift
//  Canola
//
//  Created by 史翔新 on 2016/04/23.
//  Copyright © 2016年 史翔新. All rights reserved.
//

import Foundation

extension Script.Command {
	
	enum MetaCommand {
		case Label(label: String)
	}
	
}

extension Script.Command.MetaCommand: CustomStringConvertible {
	
	var description: String {
		
		switch self {
		case .Label(label: let label):
			return ".Label:\t\(label)"
		}
		
	}
	
}
