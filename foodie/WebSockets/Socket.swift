import SwiftUI
import SocketIO
import Combine

let manager = SocketManager(socketURL: URL(string: UrlConstants.baseUrl)!, config: [.log(false), .compress])
let socket = manager.defaultSocket

class Socket: ObservableObject {
    @ObservedObject var userDefaultsManager: UserDefaultsManager
        
    init(userDefaultsManager: UserDefaultsManager) {
        self.userDefaultsManager = userDefaultsManager
        socket.on(clientEvent: .connect) {data, ack in
            print("connect")
            socket.emit("user_online", ["userId": userDefaultsManager.userId, "socketId": socket.sid])
        }
        
        socket.on("friend_request") {data, ack in
            print("friend request recieved")
        }
        
        self.establishConnection()
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
    
    func addFriend(userId: String) {
        socket.emit("friend_request", ["from": userDefaultsManager.userId, "to": userId])
    }
}
