import XCTest
@testable import Intrabus

class intrabusTests: XCTestCase {
    func testCreateQueue() {
        let bus = Intrabus();
        try! bus.createQueue(queueName: "hello.test");
        XCTAssertEqual(bus.queues.count, 1);

        try! bus.createQueue(queueName: "hello.test.2");
        XCTAssertEqual(bus.queues.count, 2);
    }

    func testSendMessage() {
        let bus = Intrabus();
        try! bus.createQueue(queueName: "hello.test");
        XCTAssertEqual(bus.queues.count, 1);

        let m = Message(stringMessage:"Hello World")
        try! bus.sendMessage(queueName: "hello.test", message: m);
        let m2 = Message(stringMessage:"Hello World2")
        try! bus.sendMessage(queueName: "hello.test", message: m2);
        XCTAssertEqual(bus.queues[0].messages[1], m2)
    }

    func testRegisterListener() {
        let bus = Intrabus();
        bus.start();
        try! bus.createQueue(queueName: "hello.test");
        XCTAssertEqual(bus.queues.count, 1);

        let myListener = EchoListener(bus: bus);
        try! bus.registerListener(queueName: "hello.test", listener: myListener);
        XCTAssertNotNil(bus.queues[0].listener);

        let m = Message(stringMessage:"Hello World")
        try! bus.sendMessage(queueName: "hello.test", message: m);

        bus.stop();
    }

    static var allTests = [
        ("test Create Queue", testCreateQueue),
        ("test send message", testSendMessage),
        ("test listener registration", testRegisterListener)
    ]
}
