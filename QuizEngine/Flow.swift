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
}

class Flow {
	private let router: Router
	private let questions: [String]
	
	init(router: Router, questions: [String]) {
		self.router = router
		self.questions = questions
	}
	
	func start() {
		if let firstQuestion = questions.first {
			router.routeTo(question: firstQuestion, answerCallback: routeNext(from: firstQuestion))
		}
	}
	
	
	private func routeNext(from question:  String) -> Router.AnswerCallback {
		return { [ weak self] _ in
			guard let stronSelf = self else { return  }
			if let currentQuestionIndex = stronSelf.questions.firstIndex(of: question) {
				if currentQuestionIndex + 1 < stronSelf.questions.count {
					let nextQuestion = stronSelf.questions[currentQuestionIndex + 1]
					stronSelf.router.routeTo(question: nextQuestion, answerCallback: stronSelf.routeNext(from: nextQuestion))
				}
			}
		}
	}
}
