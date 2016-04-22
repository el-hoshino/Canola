//
//  AudioControlCommand.swift
//  Canola
//
//  Created by 史翔新 on 2016/04/23.
//  Copyright © 2016年 史翔新. All rights reserved.
//

import Foundation

extension Script.Command {
	
	enum AudioControlCommand {
		case PlayBGM(file: String, channel: Int)
		case StopBGM(channel: Int)
	}
	
}

extension Script.Command.AudioControlCommand: CustomStringConvertible {
	
	var description: String {
		
		switch self {
		case .PlayBGM(file: let file, channel: let channel):
			return ".PlayBGM\t\(file), channel: \(channel)"
			
		case .StopBGM(channel: let channel):
			return ".StopBGM\tchannel: \(channel)"
		}
		
	}
	
}
