import XCTest
@testable import Intrabus

class QueueTests: XCTestCase {
    func testSendMessage() {
      let queue = Queue(name: "test");
      XCTAssertNotNil(queue);
      XCTAssertEqual(queue.count(), 0)

      let message = Message();
      message.body = Array("Hello".utf8);
      queue.sendMessage(message: message);

      XCTAssertNotNil(queue.messages);
      XCTAssertEqual(queue.count(), 1);
    }

    func testAckMessage() {
      let queue = Queue(name: "test");

      let message = Message();
      message.body = Array("Hello".utf8);
      queue.sendMessage(message: message);
      let message2 = Message();
      message2.body = Array("Hello2".utf8);
      queue.sendMessage(message: message2);
      XCTAssertEqual(queue.count(), 2);

      queue.ackMessage(messageId: message.header.id);

      XCTAssertEqual(queue.count(), 1);
      XCTAssertEqual(queue.messages[0], message2);
    }


    static var allTests = [
        ("test send message", testSendMessage),
        ("test acknowledge message", testAckMessage)
    ]
}
