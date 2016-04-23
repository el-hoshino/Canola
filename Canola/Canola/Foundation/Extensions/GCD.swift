//
//  GCD.swift
//  Canola
//
//  Created by 史翔新 on 2016/04/24.
//  Copyright © 2016年 史翔新. All rights reserved.
//

import Foundation

struct GCD {
	
	enum Thread {
		
		case Main
		case Static(queue: dispatch_queue_t)
		case Dynamic(name: String, attribute: QueueAttribute)
		
		var queue: dispatch_queue_t {
			switch self {
			case .Main:
				return dispatch_get_main_queue()
				
			case .Static(queue: let queue):
				return queue
				
			case .Dynamic(name: let name, attribute: let attribute):
				return dispatch_queue_create(name, attribute.queueAttribute)
			}
		}
		
		enum QueueAttribute {
			case Serial
			case Concurrent
			
			var queueAttribute: dispatch_queue_attr_t {
				switch self {
				case .Serial:
					return DISPATCH_QUEUE_SERIAL
					
				case .Concurrent:
					return DISPATCH_QUEUE_CONCURRENT
				}
			}
		}
		
	}
	
	private init() {
		
	}

	static func runSynchronizedQueue(at thread: Thread = .Main, with action: (() -> Void)) {
		
		dispatch_sync(thread.queue) { 
			action()
		}
		
	}
	
	static func runAsynchronizedQueue(at thread: Thread = .Main, waitUntilStart: Bool = false, with action: (() -> Void)) {
		
		if waitUntilStart {
			let semaphore = dispatch_semaphore_create(thread.queue.hash)
			dispatch_async(thread.queue, {
				dispatch_semaphore_signal(semaphore)
				action()
			})
			dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER)
			
		} else {
			dispatch_async(thread.queue) {
				action()
			}
		}
		
	}
	
}
