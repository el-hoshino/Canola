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
		
		case InitBG(tag: Int)
		case SetBG(tag: Int, file: String, duration: NSTimeInterval, waitUntilEnd: Bool)
		case ShowBG(tag: Int, duration: NSTimeInterval, waitUntilEnd: Bool)
		case HideBG(tag: Int, duration: NSTimeInterval, waitUntilEnd: Bool)
		
		case InitCHA(tag: Int)
		case SetCHA(tag: Int, file: String, characterName: String?, duration: NSTimeInterval, waitUntilEnd: Bool)
		case ShowCHA(tag: Int, duration: NSTimeInterval, waitUntilEnd: Bool)
		case HideCHA(tag: Int, duration: NSTimeInterval, waitUntilEnd: Bool)
		
		case HideMessageWindow
	}
	
}

extension Script.Command.GraphicControlCommand: CustomStringConvertible {
	
	var description: String {
		
		switch self {
		case .ShowScreen(duration: let time, waitUntilEnd: let wait):
			return ".ShowScreen\tduration: \(time), waitUntilEnd: \(wait)"
			
		case .HideScreen(duration: let time, color: let color, waitUntilEnd: let wait):
			return ".HideScreen\tduration: \(time), color: \(color), waitUntilEnd: \(wait)"
			
		case .InitBG(tag: let tag):
			return ".InitBG\ttag: \(tag)"
			
		case .SetBG(tag: let tag, file: let file, duration: let time, waitUntilEnd: let wait):
			return ".SetBG\ttag: \(tag), file: \(file), duration: \(time), waitUntilEnd: \(wait)"
			
		case .ShowBG(tag: let tag, duration: let time, waitUntilEnd: let wait):
			return ".ShowBG\ttag: \(tag), duration: \(time), waitUntilEnd: \(wait)"
			
		case .HideBG(tag: let tag, duration: let time, waitUntilEnd: let wait):
			return ".HideBG\ttag: \(tag), duration: \(time), waitUntilEnd: \(wait)"
			
		case .InitCHA(tag: let tag):
			return ".ResetCHA\ttag: \(tag)"
			
		case .SetCHA(tag: let tag, file: let file, characterName: let name, duration: let time, waitUntilEnd: let wait):
			return ".SetCHA\ttag: \(tag), file: \(file), name: \(name), duration: \(time), waitUntilEnd: \(wait)"
			
		case .ShowCHA(tag: let tag, duration: let time, waitUntilEnd: let wait):
			return ".ShowCHA\ttag: \(tag), duration: \(time), waitUntilEnd: \(wait)"
			
		case .HideCHA(tag: let tag, duration: let time, waitUntilEnd: let wait):
			return ".HideCHA\ttag: \(tag), duration: \(time), waitUntilEnd: \(wait)"
			
		case .HideMessageWindow:
			return ".HideMessageWindow"
		}
		
	}
	
}
