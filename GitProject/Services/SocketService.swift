//
//  SocketService.swift
//  GitProject
//
//  Created by Ziyad almohisen on 14/04/2019.
//  Copyright © 2019 Ziyad almohisen. All rights reserved.
//

import UIKit
import SocketIO

class SocketService: NSObject {
    static let instance = SocketService()
    
    override init() {
        super.init()
    }
//
//    let manager = SocketManager(socketURL: URL(string: BASE_URL)!, config: [.log(true), .compress])
//
//    func establishConnection() {
//        manager.defaultSocket.connect()
//    }
//
//    func closeConnection() {
//        manager.defaultSocket.disconnect()
//    }
//
//    func addChannel(name: String, description: String, completion: @escaping completionHandler) {
//        manager.defaultSocket.emit(SOCKET_EVENT_NEW_CHANNEL, name, description)
//        completion(true)
//    }
//
//    func getChannel(completion: @escaping completionHandler) {
//        manager.defaultSocket.on(SOCKET_EVENT_CHANNEL_CREATED) { (dataArray, ack) in
//            guard let name = dataArray[0] as? String else { return }
//            guard let description = dataArray[1] as? String else { return }
//            guard let id = dataArray[2] as? String else { return }
//            let newChannel = Channel(channelTitle: name, channelDescription: description, id: id)
//            MessageService.instance.channels.append(newChannel)
//            completion(true)
//        }
//    }
    
//    let manager = SocketManager(socketURL: URL(string: BASE_URL)!)
//    lazy var socket:SocketIOClient = manager.defaultSocket
//    let manager = SocketManager(socketURL: URL(string:BASE_URL)!, config: manager)
    
    let manager = SocketManager(socketURL: URL(string: "\(BASE_URL)")!)
    lazy var socket: SocketIOClient = manager.defaultSocket
    




    func establishConnection() {
        socket.connect()
    }

    func closeConnection() {
        socket.disconnect()
    }

    func addChannel(channelName: String, channelDescription: String, completion: @escaping completionHandler) {
        socket.emit("newChannel", channelName, channelDescription)
        completion(true)
    }

    func getChannel(completion: @escaping completionHandler) {
        socket.on("channelCreated") { (dataArray, ack) in
            guard let channelName = dataArray[0] as? String else { return }
            guard let channelDesc = dataArray[1] as? String else { return }
            guard let channelId = dataArray[2] as? String else { return }

            let newChannel = Channel(channelTitle: channelName, channelDescription: channelDesc, id: channelId)
            MessageService.instance.channels.append(newChannel)
            completion(true)
        }
    }
    
    func addMessage(messageBody: String, userId: String, channelId: String, completion: @escaping completionHandler) {
        let user = UserDataService.instance
        socket.emit("newMessage", messageBody, userId, channelId, user.name, user.avatarName, user.avatarColor)
        completion(true)
    }
    
    func getChatMessage(completion: @escaping (_ newMessage: Message) -> Void){
        socket.on("messageCreated") { (dataArray, ack) in
            guard let msgBody = dataArray[0] as? String else { return }
            guard let channelId = dataArray[2] as? String else { return }
            guard let userName = dataArray[3] as? String else { return }
            guard let userAvatar = dataArray[4] as? String else { return }
            guard let userAvatarColor = dataArray[5] as? String else { return }
            guard let id = dataArray[6] as? String else { return }
            guard let timeStamp = dataArray[7] as? String else { return }
            
            let newMessage = Message(message: msgBody, userName: userName, channelId: channelId, userAvatar: userAvatar, userAvatarColor: userAvatarColor, id: id, timeStamp: timeStamp)
            
            completion(newMessage)
           
        }
    }
    
    
    func getTypingUsers(_ comlpetionHandler: @escaping (_ typingUsers: [String: String]) -> Void) {
        socket.on("userTypingUpdate") { (dataArray, ack) in
            guard let typingUser = dataArray[0] as? [String: String] else {return}
            comlpetionHandler(typingUser)
        }
    }
    

}
