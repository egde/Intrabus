class EchoListener : Listener {
  var bus: Intrabus

  init(bus: Intrabus) {
      self.bus = bus
  }

  func onReceiveMessage(message: Message) {
    print("EchoListener: \(message.body)")
    try! bus.ackMessage(queueName: message.header.srcQueue!, messageId: message.header.id)
  }
}
