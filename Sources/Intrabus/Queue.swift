import Strand;

class Queue {
  var name: String;
  var messages: [Message] = [Message]();
  var listener: Listener?;
  var unacknowlegdedMessage: UnacknowlegdedMessage?;

  init(name: String) {
    self.name = name;
  }

  func sendMessage(message: Message) {
    message.header.srcQueue = self.name
    self.messages.append(message);
  }

  func setUnacknowledgedMessage(message: Message, listener: Listener) {
    self.unacknowlegdedMessage = UnacknowlegdedMessage(message: message, listener: listener)
  }

  func count() -> Int {
    return self.messages.count;
  }

  func ackMessage(messageId: String) {
    var i = 0;
    var messageFound = false;

    for m in self.messages {
      if m.header.id == messageId {
        messageFound = true;
        break;
      }
      i+=1;
    }

    if messageFound {
      self.messages.remove(at: i);
    }
    unacknowlegdedMessage = nil;
  }

  func purgeAll() {
    self.messages.removeAll();
  }

  func registerListener(l: Listener) {
    self.listener = l;
  }
}

struct UnacknowlegdedMessage {
    var message: Message;
    var listener: Listener;
}
