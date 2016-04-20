//
//  EngineModel.swift
//  Canola
//
//  Created by 史翔新 on 2016/04/21.
//  Copyright © 2016年 史翔新. All rights reserved.
//

import UIKit

class EngineModel: NSObject {
	
	private var _mainParser: ParserModel?
	var mainParser: ParserModel {
		if let parser = self._mainParser {
			return parser
			
		} else {
			let parser = ParserModel()
			self._mainParser = parser
			return parser
		}
	}
	
	private func startGame() {
		self.mainParser.parse()
	}
	
	func runGame() {
		self.startGame()
	}
	
}
