//
//  ViewSettings.swift
//  Canola
//
//  Created by 史翔新 on 2016/04/26.
//  Copyright © 2016年 史翔新. All rights reserved.
//

import Foundation

extension GlobalSettings {
	
	struct ViewSettings {
		
		let gameScreenSize: CGSize
		let supportedOrientationMask: UIInterfaceOrientationMask
		
		init(object: [String: NSObject]) {
			
			var gameScreenSize = CGSize(width: 1280, height: 720)
			var supportedOrientationMask = UIInterfaceOrientationMask.All
			
			object.forEach { (name, value) in
				switch name.lowercaseString {
				case "viewsize":
					if let value = value as? [Int] where value.count > 1 {
						gameScreenSize = CGSize(width: value[0], height: value[1])
					}
					
				case "vieworientationmask":
					if let value = value as? String {
						switch value.lowercaseString {
						case "landscape":
							supportedOrientationMask = .Landscape
							
						case "portrait":
							supportedOrientationMask = .Portrait
							
						case "all":
							supportedOrientationMask = .All
							
						default:
							break
						}
					}
					
				default:
					break
				}
			}
			
			self.gameScreenSize = gameScreenSize
			self.supportedOrientationMask = supportedOrientationMask
			
		}
		
		static let defaultSettings = ViewSettings(object: [:])
		
	}
	
}