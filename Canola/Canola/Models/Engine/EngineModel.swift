//
//  EngineModel.swift
//  Canola
//
//  Created by 史翔新 on 2016/04/21.
//  Copyright © 2016年 史翔新. All rights reserved.
//

import UIKit

class EngineModel: NSObject {
	
	lazy var mainParser: ParserModel? = {
		do {
			let parser = try ParserModel(initialScript: "main")
			return parser
			
		} catch let error {
			Console.shared.warning(error)
			return nil
		}
	}()
	
	private func startGame() {
		self.mainParser?.disableStandbying()
		self.mainParser?.parse()
	}
	
	func runGame() {
		self.startGame()
	}
	
	func enterNext(line: Int? = nil) {
		self.mainParser?.enterNext(line)
	}
	
}
