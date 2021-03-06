//
//  Flow.swift
//  QuizEngine
//
//  Created by Thanyani on 2020/11/20.
//

import Foundation

protocol Router {
	typealias AnswerCallback = (String) -> Void
	func routeTo(question: String, answerCallback: @escaping AnswerCallback)
	func routeTo(result: [String: String])
}

class Flow {
	private let router: Router
	private let questions: [String]
	private var result: [String: String] = [:]
	
	init(router: Router, questions: [String]) {
		self.router = router
		self.questions = questions
	}
	
	func start() {
		if let firstQuestion = questions.first {
			router.routeTo(question: firstQuestion, answerCallback: nextCallback(from: firstQuestion))
		} else {
			router.routeTo(result: result)
		}
	}
	
	private func nextCallback(from question: String) -> Router.AnswerCallback {
		return {[weak self] in self?.routeNext(from: question, at: $0) }
	}
	
	private func routeNext(from question:  String, at answer: String) {
		if let currentQuestionIndex = questions.firstIndex(of: question) {
			result[question] = answer
			
			let nextQuestionIndex =  currentQuestionIndex + 1
			if nextQuestionIndex < questions.count {
				let nextQuestion =  questions[nextQuestionIndex]
				router.routeTo(question: nextQuestion, answerCallback: nextCallback(from: nextQuestion))
			} else {
				router.routeTo(result: result)
			}
		}
	}
}
