//
//  GeneralCommand.swift
//  Canola
//
//  Created by 史翔新 on 2016/04/23.
//  Copyright © 2016年 史翔新. All rights reserved.
//

import Foundation

extension Script.Command {
	
	enum GeneralCommand {
		case Init
	}
	
}

extension Script.Command.GeneralCommand: CustomStringConvertible {
	
	var description: String {
		
		switch self {
		case .Init:
			return ".Init"
		}
		
	}
	
}
