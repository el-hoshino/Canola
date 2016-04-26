//
//  GlobalSettings.swift
//  Canola
//
//  Created by 史翔新 on 2016/04/26.
//  Copyright © 2016年 史翔新. All rights reserved.
//

import Foundation

struct GlobalSettings {
	
	static let shared = GlobalSettings()
	
	let viewSettings: ViewSettings
	
	private init() {
		
		if let settingsFileURL = NSBundle.mainBundle().URLForResource("Settings", withExtension: "json"), settingsFileData = NSData(contentsOfURL: settingsFileURL), settingsFileObject = (try? NSJSONSerialization.JSONObjectWithData(settingsFileData, options: [])) as? [String: NSObject] {
			let viewSettingsData = settingsFileObject["ViewSettings"] as? [String: NSObject] ?? [:]
			self.viewSettings = ViewSettings(object: viewSettingsData)
			
		} else {
			self.viewSettings = ViewSettings.defaultSettings
			
		}
		
		
	}
	
}
