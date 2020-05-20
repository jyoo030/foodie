//
//  UserProfileView.swift
//  foodie
//
//  Created by Jae Hyun on 4/29/20.
//  Copyright © 2020 Joftware. All rights reserved.
//

import SwiftUI

enum FriendStatus{
    case addFriend, pending, friends
}

struct UserProfileView: View {
    @EnvironmentObject var socket: Socket
    @EnvironmentObject var userDefaultsManager: UserDefaultsManager
    @EnvironmentObject var notificationManager: NotificationManager
    private var user: User
    
    init(user: User) {
        self.user = user
    }
    
    func getFriendStatus() -> FriendStatus {
        if userDefaultsManager.friends.contains(user) {
            return .friends
        }
        else if notificationManager.sent.contains(where: { notification in notification.reciever.id == user.id }) {
            return .pending
        } else {
            return .addFriend
        }
    }
    
    func getButtonText() -> String {
        switch self.getFriendStatus() {
            case .addFriend:
                return "Add Friend"
            case .friends:
                return "Friends"
            case .pending:
                return "Pending"
        }
    }
    
    var body: some View {
        GeometryReader { g in
            VStack(alignment: .center, spacing: 20) {
                Image("chicken")
                    .resizable()
                .frame(width: 150, height: 150)
                .cornerRadius(100)
                    .padding(.top, 20)
                
                VStack(spacing: 5) {
                    Text("\(self.user.firstName) \(self.user.lastName)")
                    Text("@\(self.user.userName)")
                        .foregroundColor(.gray)
                }
                
                // Add Friend/friends button
                // Possible switch out for image
                HStack(spacing: 20) {
                    Spacer()
                    
                    Button(action: {
                        switch self.getFriendStatus() {
                            case FriendStatus.addFriend:
                                self.socket.addFriend(userId: self.user.id, onComplete: { notification in
                                    self.notificationManager.sent.append(notification)
                                })
                                break
                            case FriendStatus.friends:
                                self.socket.deleteFriend(currentUserId: self.userDefaultsManager.userId, friendId: self.user.id) {
                                    self.userDefaultsManager.friends.removeAll{$0.id == self.user.id}
                                }
                                break
                            case FriendStatus.pending:
                                let notificationId = self.notificationManager.sent.first(where: { $0.reciever.id == self.user.id })!.id
                                    self.socket.cancelRequest(notificationId: notificationId) { notification in
                                   self.notificationManager.sent.removeAll{$0.id == notification.id}
                                }
                                break
                        }
                    }) {
                        HStack {
                            Image(systemName: "person.badge.plus.fill")
                                .resizable()
                                .frame(width: 15, height: 15)
                                .scaledToFit()
                            Text(self.getButtonText())
                                .font(.caption)
                        }
                        .padding(10)
                        .border(Color.black, width: 3)
                        .cornerRadius(5)
                        
                    }

                    Button(action: {
                        // Show User's friends
                    }) {
                        HStack {
                            Text("\(self.user.friends!.count) Friends")
                                .font(.caption)
                        }
                        .padding(10)
                        .border(Color.black, width: 3)
                        .cornerRadius(5)
                    }
                    
                    Spacer()
                }
                
                
                
                Spacer()
                ScrollView {
                    Text("Put liked restaurants in this scrollview")
                }
            }
            
        }.navigationBarTitle("\(user.firstName) \(user.lastName)")
        .navigationBarItems(trailing:
            Button(action: {
                // open popup to show 'block' user
            }, label: {
                Image(systemName: "ellipsis")
                    .renderingMode(.original)
            }
        ))
    }
}

struct UserProfile_Previews: PreviewProvider {
    struct BindingTestHolder: View {
        var user = User()
        init() {
            user.firstName = "Jae"
            user.lastName = "Jae"
            user.userName = "jyim"
        }
        
        var body: some View {
            UserProfileView(user: user)
        }
    }
    
    static var previews: some View {
        BindingTestHolder()
    }
}
