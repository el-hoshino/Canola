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

}

extension GCD { // MARK: Semaphores
	
	enum DispatchTime {
		case Forever
		case TimeAfter(delta: NSTimeInterval)
		
		var dispatchTimeType: dispatch_time_t {
			switch self {
			case .Forever:
				return DISPATCH_TIME_FOREVER
				
			case .TimeAfter(delta: let delta):
				let nanoseconds = Int64(delta * NSTimeInterval(NSEC_PER_SEC))
				let time = dispatch_time(DISPATCH_TIME_NOW, nanoseconds)
				return time
			}
		}
	}
	
	static func createSemaphore(value: Int) -> dispatch_semaphore_t {
		return dispatch_semaphore_create(value)
	}
	
	static func fireSemaphore(semaphore: dispatch_semaphore_t) {
		dispatch_semaphore_signal(semaphore)
	}
	
	static func waitForSemaphore(semaphore: dispatch_semaphore_t, until deadLine: DispatchTime = .Forever) {
		dispatch_semaphore_wait(semaphore, deadLine.dispatchTimeType)
	}
	
}

extension GCD { // MARK: Queues
	
	static func runSynchronizedQueue(at thread: Thread = .Main, with action: (() -> Void)) {
		
		dispatch_sync(thread.queue) {
			action()
		}
		
	}
	
	static func runAsynchronizedQueue(at thread: Thread = .Main, waitUntilStartForMax waitTime: NSTimeInterval? = nil, with action: (() -> Void)) {
		
		if let waitTime = waitTime {
			let semaphore = GCD.createSemaphore(thread.queue.hash)
			dispatch_async(thread.queue, {
				GCD.fireSemaphore(semaphore)
				action()
			})
			GCD.waitForSemaphore(semaphore, until: waitTime == 0 || waitTime == .infinity ? .Forever : .TimeAfter(delta: waitTime))
			
		} else {
			dispatch_async(thread.queue) {
				action()
			}
		}
		
	}
	
}
