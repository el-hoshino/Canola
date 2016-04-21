//
//  EngineModel.swift
//  Canola
//
//  Created by 史翔新 on 2016/04/21.
//  Copyright © 2016年 史翔新. All rights reserved.
//

import UIKit

class EngineModel: NSObject {
	
	lazy var mainParser: ParserModel = {
		let parser = ParserModel()
		return parser
	}()
	
	private func startGame() {
		self.mainParser.parse()
	}
	
	func runGame() {
		self.startGame()
	}
	
}
