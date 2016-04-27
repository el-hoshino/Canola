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
		
		case SetBG(tag: Int, file: String)
		case ShowBG(tag: Int, duration: NSTimeInterval, waitUntilEnd: Bool)
		case HideBG(tag: Int, duration: NSTimeInterval, waitUntilEnd: Bool)
		
		case SetCHA(tag: Int, file: String, characterName: String?)
		case ShowCHA(tag: Int, duration: NSTimeInterval, waitUntilEnd: Bool)
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
			
		case .SetBG(tag: let tag, file: let file):
			return ".SetBG\ttag: \(tag), file: \(file)"
			
		case .ShowBG(tag: let tag, duration: let time, waitUntilEnd: let wait):
			return ".ShowBG\ttag: \(tag), duration: \(time), waitUntilEnd: \(wait)"
			
		case .HideBG(tag: let tag, duration: let time, waitUntilEnd: let wait):
			return ".HideBG\ttag: \(tag), duration: \(time), waitUntilEnd: \(wait)"
			
		case .SetCHA(tag: let tag, file: let file, characterName: let name):
			return ".SetCHA\ttag: \(tag), file: \(file), name: \(name)"
			
		case .ShowCHA(tag: let tag, duration: let time, waitUntilEnd: let wait):
			return ".ShowCHA\ttag: \(tag), duration: \(time), waitUntilEnd: \(wait)"
			
		case .HideCHA(tag: let tag, duration: let time, waitUntilEnd: let wait):
			return ".HideCHA\ttag: \(tag), duration: \(time), waitUntilEnd: \(wait)"
		}
		
	}
	
}
