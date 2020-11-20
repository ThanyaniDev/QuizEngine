//
//  Flow.swift
//  QuizEngine
//
//  Created by Thanyani on 2020/11/20.
//

import Foundation

protocol Router {
	func routeTo(question: String)
}

class Flow {
	let router: Router
	let questions: [String]
	
	init(router: Router, questions: [String]) {
		self.router = router
		self.questions = questions
	}
	
	func start() {
		if !questions.isEmpty {
			router.routeTo(question: "Q1")
		}
	}
}
