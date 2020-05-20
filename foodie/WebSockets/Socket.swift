import SwiftUI
import SocketIO
import Combine

let manager = SocketManager(socketURL: URL(string: UrlConstants.baseUrl)!, config: [.log(false), .compress])
let socket = manager.defaultSocket

class Socket: ObservableObject {
    @ObservedObject var userDefaultsManager: UserDefaultsManager
    @ObservedObject var notificationManager: NotificationManager
    @ObservedObject var userManager: UserManager
        
    init(userDefaultsManager: UserDefaultsManager, notificationManager: NotificationManager, userManager: UserManager) {
        self.userDefaultsManager = userDefaultsManager
        self.notificationManager = notificationManager
        self.userManager = userManager
        
        socket.on(clientEvent: .connect) {data, ack in
            socket.emit("user_online", ["userId": userDefaultsManager.userId, "socketId": socket.sid])
        }
        
        socket.on("friend_request") {data, ack in
            let notification = data[0] as! NSDictionary
    
            self.notificationManager.recieved.append(NotificationModel(dictionary: notification))
        }
        
        socket.on("friend_request_response") {data, ack in
            let notification = data[0] as! NSDictionary
            let accept = data[1] as! Bool
            
            if accept {
                self.userDefaultsManager.friends.append(User(dictionary: notification["reciever"] as! NSDictionary))
            }
            
            self.notificationManager.sent.removeAll{$0.id == notification["_id"] as! String}
        }
        
        socket.on("cancel_friend_request") { data, ack in
            let notification = data[0] as! NSDictionary

            self.notificationManager.recieved.removeAll{$0.id == notification["_id"] as! String}
        }
        
        socket.on("delete_friend") { data, ack in
            let friendId = data[0] as! String
            self.userDefaultsManager.friends.removeAll{$0.id == friendId }
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
    
    // Friends
    func addFriend(userId: String, onComplete: ((_ notification: NotificationModel)->Void)?) {
        socket.emitWithAck("friend_request", ["from": userDefaultsManager.userId, "to": userId]).timingOut(after: 0) { data in
            let dictionary = data[0] as! NSDictionary
            onComplete?(NotificationModel(dictionary: dictionary))
        }
    }
    
    func friendRequestResponse(notificationId: String, accept: Bool, onComplete: ((_ notification: NotificationModel)->Void)?) {
        socket.emitWithAck("friend_request_response", ["id": notificationId, "accept": accept]).timingOut(after: 0) { data in
            let notification = data[0] as! NSDictionary
            onComplete?(NotificationModel(dictionary: notification))
        }
    }
    
    func cancelRequest(notificationId: String, onComplete: @escaping (_ notification: NotificationModel) -> ()) {
        socket.emitWithAck("cancel_friend_request", ["id": notificationId]).timingOut(after: 0) { data in
            // Type cast the __NSDictionaryM to NotificationModel and pass it to onComplete
            onComplete(NotificationModel(dictionary: data[0] as! NSDictionary))
        }
    }
    
    func deleteFriend(currentUserId: String, friendId: String, onComplete: @escaping () -> ()) {
        socket.emitWithAck("delete_friend", ["currentUserId": currentUserId, "friendId": friendId]).timingOut(after: 0) { data in
            // Type cast the __NSDictionaryM to NotificationModel and pass it to onComplete
            onComplete()
        }
    }
    
    // Groups
    func like(restaurantId: String) {
        socket.emit("like",
                   ["userId": userDefaultsManager.userId,
                    "restaurantId": restaurantId,
                    "groupId": userDefaultsManager.currentGroup.id])
    }
}
