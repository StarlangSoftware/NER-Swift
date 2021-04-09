import XCTest
@testable import NER

final class NERTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(NER().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
