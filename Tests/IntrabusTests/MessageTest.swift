import XCTest
@testable import Intrabus

class MessageTests: XCTestCase {
    func testMessage() {
      let message = Message();
      message.body = Array("Hello".utf8);

      XCTAssertNotNil(message);
      XCTAssertNotNil(message.header);
      XCTAssertNotNil(message.header.id);
      XCTAssertNotNil(message.header.date);
      XCTAssertNotNil(message.body);
      XCTAssertEqual(String(bytes: message.body, encoding: .utf8), "Hello")
    }

    func testMessageWithInitializers() {
      let message = Message(stringMessage: "Hello");

      XCTAssertNotNil(message);
      XCTAssertNotNil(message.header);
      XCTAssertNotNil(message.header.id);
      XCTAssertNotNil(message.header.date);
      XCTAssertNotNil(message.body);
      XCTAssertEqual(String(bytes: message.body, encoding: .utf8), "Hello")
    }


    static var allTests = [
        ("test message", testMessage),
        ("test message with initializers", testMessageWithInitializers)
    ]
}
