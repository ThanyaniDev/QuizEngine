//
//  FlowTest.swift
//  QuizEngineTests
//
//  Created by Thanyani on 2020/11/20.
//

import XCTest
@testable import QuizEngine

class FlowTest: XCTestCase {
	func  test_start_withNoQuestions_doesNotRouteToQuestion() {
		let router = RouterSpy()
		let systemUndetTest = Flow(router: router, questions: [])
	
		systemUndetTest.start()
		
		XCTAssertEqual(router.routerQuestionCount, 0)
	}
	
	func  test_start_withQuestions_routesToQuestion() {
		let router = RouterSpy()
		let systemUndetTest = Flow(router: router, questions: ["Q1"])
		
		systemUndetTest.start()
		
		XCTAssertEqual(router.routerQuestionCount, 1)
	}
	
	func  test_start_withQuestions_routesToCorretQuestion() {
		let router = RouterSpy()
		let systemUndetTest = Flow(router: router, questions: ["Q1"])
		
		systemUndetTest.start()
		
		XCTAssertEqual(router.routerQuestion, "Q1")
	}
}

class RouterSpy: Router {
	var routerQuestionCount: Int = 0
	var routerQuestion: String? = nil
	
	
	func routeTo(question: String) {
		routerQuestionCount += 1
		routerQuestion = question
	}
}
