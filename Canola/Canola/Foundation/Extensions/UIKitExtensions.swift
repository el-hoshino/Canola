//
//  UIKitExtensions.swift
//  Canola
//
//  Created by 史翔新 on 2016/05/02.
//  Copyright © 2016年 史翔新. All rights reserved.
//

import UIKit

extension UILabel {
	
	func getLinesArrayOfText() -> [String] {
		
		guard let text = self.text else {
			return []
		}
		
		let font = self.font
		let size = self.frame.size
		
		let myFont = CTFontCreateWithName(font.fontName, font.pointSize, nil)
		let attributes = [String(kCTFontAttributeName): myFont]
		let attributedString = NSAttributedString(string: text, attributes: attributes)
		
		let frameSetter = CTFramesetterCreateWithAttributedString(attributedString)
		let path = CGPathCreateWithRect(CGRect(origin: .zero, size: size), nil)
		
		let frame = CTFramesetterCreateFrame(frameSetter, CFRange(location: 0, length: 0), path, nil)
		let lines = CTFrameGetLines(frame) as [AnyObject]
		
		let linesArray = lines.map { (line) -> String in
			let line = line as! CTLine
			let lineRange = CTLineGetStringRange(line)
			let range = NSRange(location: lineRange.location, length: lineRange.length)
			let lineString = (text as NSString).substringWithRange(range)
			return lineString
		}
		
		return linesArray
	}
	
}
