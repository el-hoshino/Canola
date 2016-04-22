//
//  GraphicControlCommand.swift
//  Canola
//
//  Created by 史翔新 on 2016/04/23.
//  Copyright © 2016年 史翔新. All rights reserved.
//

import Foundation

extension Script.Command {
	
	enum GraphicControlCommand {
		case ShowScreen(duration: NSTimeInterval, waitUntilEnd: Bool)
		case HideScreen(duration: NSTimeInterval, color: UIColor, waitUntilEnd: Bool)
		
		case ShowBG(file: String, tag: Int, duration: NSTimeInterval, waitUntilEnd: Bool)
		case HideBG(tag: Int, duration: NSTimeInterval, waitUntilEnd: Bool)
		
		case ShowCHA(file: String, tag: Int, characterName: String, duration: NSTimeInterval, waitUntilEnd: Bool)
		case HideCHA(tag: Int, duration: NSTimeInterval, waitUntilEnd: Bool)
	}
	
}

extension Script.Command.GraphicControlCommand: CustomStringConvertible {
	
	var description: String {
		
		switch self {
		case .ShowScreen(duration: let time, waitUntilEnd: let wait):
			return ".ShowScreen\tduration: \(time), waitUntilEnd: \(wait)"
			
		case .HideScreen(duration: let time, color: let color, waitUntilEnd: let wait):
			return ".HideScreen\tduration: \(time), color: \(color), waitUntilEnd: \(wait)"
			
		case .ShowBG(file: let file, tag: let tag, duration: let time, waitUntilEnd: let wait):
			return ".ShowBG\t\(file), tag: \(tag), duration: \(time), waitUntilEnd: \(wait)"
			
		case .HideBG(tag: let tag, duration: let time, waitUntilEnd: let wait):
			return ".HideBG\ttag: \(tag), duration: \(time), waitUntilEnd: \(wait)"
			
		case .ShowCHA(file: let file, tag: let tag, characterName: let name, duration: let time, waitUntilEnd: let wait):
			return ".ShowCHA\t\(file), tag: \(tag), characterName: \(name), duration: \(time), waitUntilEnd: \(wait)"
			
		case .HideCHA(tag: let tag, duration: let time, waitUntilEnd: let wait):
			return ".HideCHA\ttag: \(tag), duration: \(time), waitUntilEnd: \(wait)"
		}
		
	}
	
}
