//
//  Operators.swift
//  Canola
//
//  Created by 史翔新 on 2016/04/23.
//  Copyright © 2016年 史翔新. All rights reserved.
//

import Foundation

infix operator =? {
	assignment
}

func =? <T> (inout lhs: T, rhs: T?) {
	if let rhs = rhs {
		lhs = rhs
	}
}

infix operator …= {

}

func …= <T where T: Comparable> (lhs: T, rhs: Range<T>) -> Bool {
	return lhs >= rhs.startIndex && lhs < rhs.endIndex
}

func …= <T where T: Comparable> (lhs: T, rhs: HalfOpenInterval<T>) -> Bool {
	return lhs >= rhs.start && lhs < rhs.end
}

func …= <T where T: Comparable> (lhs: T, rhs: ClosedInterval<T>) -> Bool {
	return lhs >= rhs.start && lhs <= rhs.end
}
