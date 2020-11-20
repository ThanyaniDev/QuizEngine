//
//  FlowTest.swift
//  QuizEngineTests
//
//  Created by Thanyani on 2020/11/20.
//

import XCTest
@testable import QuizEngine

class FlowTest: XCTestCase {
	let router = RouterSpy()
	
	func  test_start_withNoQuestions_doesNotRouteToQuestion() {
		makeSystemUnderTest(questions: []).start()
		
		XCTAssertTrue(router.routerQuestions.isEmpty)
	}
	
	func  test_start_withQuestions_routesToCorretQuestion() {
		makeSystemUnderTest(questions: ["Q1"]).start()
		
		XCTAssertEqual(router.routerQuestions, ["Q1"])
	}
	
	func  test_start_withQuestions_routesToCorretQuestion_2() {
		makeSystemUnderTest(questions: ["Q2"]).start()
		
		XCTAssertEqual(router.routerQuestions, ["Q2"])
	}
	
	func  test_start_withTwoQuestions_routesToFirstQuestion() {
		makeSystemUnderTest(questions: ["Q1","Q2"]).start()
		
		XCTAssertEqual(router.routerQuestions, ["Q1"])
	}
	
	func  test_starTwice_withTwoQuestions_routesToFirstQuestionTwice() {
		let systemUndetTest = makeSystemUnderTest(questions: ["Q1","Q2"])
		
		systemUndetTest.start()
		systemUndetTest.start()
		
		XCTAssertEqual(router.routerQuestions, ["Q1","Q1"])
	}
	
	func  test_startAndAnsweerFirstQuestion_withTwoQuestions_routesToSecondQuestion() {
		let systemUndetTest = makeSystemUnderTest(questions: ["Q1","Q2"])
		
		systemUndetTest.start()
		router.answerCallback("A1")
		
		XCTAssertEqual(router.routerQuestions, ["Q1","Q2"])
	}
	
	func  test_startAndAnsweerFirstAndSeconQuestion_withThreeQuestions_routesToSecondandThirdQuestion() {
		let systemUndetTest = makeSystemUnderTest(questions: ["Q1","Q2","Q3"])
		
		systemUndetTest.start()
		router.answerCallback("A1")
		router.answerCallback("A2")
		
		XCTAssertEqual(router.routerQuestions, ["Q1","Q2","Q3"])
	}
	
	func  test_startAndAnsweerFirstQuestion_withOneQuestions_doesNOtRouteToAnotherQuestion() {
		let systemUndetTest = makeSystemUnderTest(questions: ["Q1"])
		
		systemUndetTest.start()
		router.answerCallback("A1")
		
		XCTAssertEqual(router.routerQuestions, ["Q1"])
	}
	
	// MARK: Helpers
	
	func makeSystemUnderTest(questions: [String]) -> Flow {
		return Flow(router: router, questions: questions)
	}
	
	class RouterSpy: Router {
		var routerQuestions: [String] = []
		var routedResult: [String: String]? = nil
		var answerCallback: ( (String) -> Void) = {_ in}
		
		func routeTo(result: [String : String]) {
			routedResult = result
		}
		func routeTo(question: String, answerCallback: @escaping (String) -> Void) {
			routerQuestions.append(question)
			self.answerCallback = answerCallback
		}
	}
}


