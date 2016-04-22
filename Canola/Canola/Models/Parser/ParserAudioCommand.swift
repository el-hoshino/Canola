//
//  ParserAudioCommand.swift
//  Canola
//
//  Created by 史翔新 on 2016/04/23.
//  Copyright © 2016年 史翔新. All rights reserved.
//

import Foundation

extension ParserModel {
	
	func parseAudioCommand(command: Script.Command.AudioControlCommand) {
		
		switch command {
		case .PlayBGM(file: _, channel: _):
			break
			
		case .StopBGM(channel: _):
			break
		}
		
	}
	
}
