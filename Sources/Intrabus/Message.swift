import Foundation;

class Message : Equatable{
  var header: MessageHeader = MessageHeader()
  var body: [UInt8] = [UInt8]()
  public var description: String {
    return "Intrabus.Message \(header.id)"
  }

  init() {}

  init(stringMessage: String) {
    body = Array(stringMessage.utf8);
  }
}

func == (lhs: Message, rhs: Message) -> Bool {
  return (lhs.header == rhs.header) && (lhs.body == rhs.body)
}

class MessageHeader: Equatable {
  var id: String = UUID().uuidString;
  var date: Date = Date();
  var srcQueue: String?;
}

func == (lhs: MessageHeader, rhs: MessageHeader) -> Bool {
  return (lhs.id == rhs.id) && (lhs.date == rhs.date) && (lhs.srcQueue == rhs.srcQueue)
}
