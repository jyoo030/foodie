import SwiftUI
import SocketIO
import Combine

let manager = SocketManager(socketURL: URL(string: UrlConstants.baseUrl)!, config: [.log(false), .compress])
let socket = manager.defaultSocket

class Socket: ObservableObject {
    @ObservedObject var userDefaultsManager: UserDefaultsManager
    @ObservedObject var notificationManager: NotificationManager
        
    init(userDefaultsManager: UserDefaultsManager, notificationManager: NotificationManager) {
        self.userDefaultsManager = userDefaultsManager
        self.notificationManager = notificationManager
        
        socket.on(clientEvent: .connect) {data, ack in
            print("connect")
            socket.emit("user_online", ["userId": userDefaultsManager.userId, "socketId": socket.sid])
        }
        
        socket.on("friend_request") {data, ack in
            print("friend request recieved")
            notificationManager.getNotifications(userId: userDefaultsManager.userId)
        }
    }
     
    func getSid() -> String {
        return socket.sid
    }

    func establishConnection() {
        socket.connect()
    }

    func closeConnection() {
        socket.disconnect()
    }
    
    func addFriend(userId: String, onComplete: (()->Void)?) {
        socket.emitWithAck("friend_request", ["from": userDefaultsManager.userId, "to": userId]).timingOut(after: 0) { data in
            onComplete?()
        }
    }
}
