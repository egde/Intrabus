import Strand;

class Dispatcher {
  var mustStop = false
  var queues: [Queue]?;

  init(_ queues:inout [Queue]) {
    self.queues = queues;
  }

  func run() {
      while (!self.mustStop) {
        dispatchQueues();
      }
  }

  func dispatchQueues() {
    if (self.queues != nil) {
      print("Queues: \(queues!)")
      for q in self.queues! {
        if q.count() > 0 {
          if q.unacknowlegdedMessage == nil {
            let message = q.messages[0];

            if (q.listener != nil) {
              let s = try! Strand {
                q.listener!.onReceiveMessage(message: message)
              }
              try! s.join();
              q.setUnacknowledgedMessage(message: message, listener: q.listener!)
            }
          }
        }
      }
    }
  }
}
