//
//  ParserGraphicCommand.swift
//  Canola
//
//  Created by 史翔新 on 2016/04/23.
//  Copyright © 2016年 史翔新. All rights reserved.
//

import Foundation

extension ParserModel {
	
	func parseGraphincCommand(command: Script.Command.GraphicControlCommand) {
		
		switch command {
		case .ShowScreen(duration: _, waitUntilEnd: _):
			break
			
		case .HideScreen(duration: _, color: _, waitUntilEnd: _):
			break
			
		case .ShowBG(file: _, tag: _, duration: _, waitUntilEnd: _):
			break
			
		case .HideBG(tag: _, duration: _, waitUntilEnd: _):
			break
			
		case .ShowCHA(file: _, tag: _, characterName: _, duration: _, waitUntilEnd: _):
			break
			
		case .HideCHA(tag: _, duration: _, waitUntilEnd: _):
			break
		}
		
	}
	
}
