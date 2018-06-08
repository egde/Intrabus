import SwiftContainer;
import Strand;

class Intrabus {
  var queues: [Queue] = [Queue]();
  var dispatcher : Dispatcher;

  init() {
  self.dispatcher = Dispatcher( &self.queues );
  }

  func start() {
    print ("Starting Dispatcher...");

    self.dispatcher.mustStop = false;
    let s = try! Strand {
      self.dispatcher.run();
    }
    print ("Dispatcher Started!");
  }

  func stop() {
    print("Stopping Dispatcher");
    dispatcher.mustStop = true;
  }

  func createQueue(queueName: String) throws {
    var isUnique = true;
    for q in queues {
      if q.name == queueName {
        isUnique = false;
      }
    }
    if (isUnique) {
      queues.append(Queue(name: queueName));
      print ("my \(queues)");
    } else {
      throw IntraBusError.QueueNameNotUnique(queueName: queueName);
    }
  }

  func removeQueue(queueName: String) throws {
    var isQueueFound = false;
    var i = 0;

    for q in queues {
      if q.name == queueName {
        isQueueFound = true;
        break;
      }
      i+=1
    }

    if !isQueueFound {
      throw IntraBusError.QueueNameNotFound(queueName: queueName);
    }

    queues[i].purgeAll();
    queues.remove(at: i);
  }

  func sendMessage(queueName: String, message: Message) throws {
    let queue = try getQueueByName(queueName: queueName)

    queue.sendMessage(message: message);
  }

  private func getQueueByName(queueName: String) throws -> Queue {
    var queue : Queue?;
    for q in queues {
      if q.name == queueName {
        queue = q;
      }
    }

    if queue == nil {
      throw IntraBusError.QueueNameNotFound(queueName: queueName);
    }

    return queue!
  }

  func ackMessage(queueName: String, messageId: String) throws {
    let queue = try getQueueByName(queueName: queueName)

    queue.ackMessage(messageId: messageId);
  }

  func registerListener(queueName: String, listener: Listener) throws {
    let queue = try getQueueByName(queueName: queueName)

    queue.registerListener(l: listener)
  }
}

enum IntraBusError: Error {
case QueueNameNotUnique(queueName: String)
case QueueNameNotFound(queueName: String)
}
