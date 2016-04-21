//
//  Console.swift
//  Canola
//
//  Created by 史翔新 on 2016/04/22.
//  Copyright © 2016年 史翔新. All rights reserved.
//

import Foundation

class Console {
	
	private init() {
		
	}
	
	static let shared = Console()
	
	func info(items: Any...) {
		print(items)
	}
	
	func warning(items: Any...) {
		print("---!!!", terminator: "")
		print(items, terminator: "")
		print("!!!---")
	}
	
}
