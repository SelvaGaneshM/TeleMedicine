//
//  MessageController.swift
//  OpenLive
//
//  Created by Rajaguru New Apple CEO on 06/01/20.
//  Copyright © 2020 Agora. All rights reserved.
//

import UIKit

import JSQMessagesViewController

struct User {
  let id: String
  let name: String
}

class MessageController: JSQMessagesViewController {
  let user1 = User(id: "1", name: "Raja")
  let user2 = User(id: "2", name: "Tim")
  
  
  var currentUser: User {
    return user1
  }
  
  // all messages of users1, users2
  var messages = [JSQMessage]()
}

extension MessageController {
  
  override func didPressSend(_ button: UIButton!, withMessageText text: String!, senderId: String!, senderDisplayName: String!, date: Date!) {
    let message = JSQMessage(senderId: senderId, displayName: senderDisplayName, text: text)
    
    messages.append(message!)
    
    finishSendingMessage()
  }
  
  override func collectionView(_ collectionView: JSQMessagesCollectionView!, attributedTextForMessageBubbleTopLabelAt indexPath: IndexPath!) -> NSAttributedString! {
    let message = messages[indexPath.row]
    let messageUsername = message.senderDisplayName
    
    return NSAttributedString(string: messageUsername!)
  }
  
  override func collectionView(_ collectionView: JSQMessagesCollectionView!, layout collectionViewLayout: JSQMessagesCollectionViewFlowLayout!, heightForMessageBubbleTopLabelAt indexPath: IndexPath!) -> CGFloat {
    return 15
  }
  
  override func collectionView(_ collectionView: JSQMessagesCollectionView!, avatarImageDataForItemAt indexPath: IndexPath!) -> JSQMessageAvatarImageDataSource! {
    return nil
  }
  
  override func collectionView(_ collectionView: JSQMessagesCollectionView!, messageBubbleImageDataForItemAt indexPath: IndexPath!) -> JSQMessageBubbleImageDataSource! {
    let bubbleFactory = JSQMessagesBubbleImageFactory()
    
    let message = messages[indexPath.row]
    
    if currentUser.id == message.senderId {
      return bubbleFactory?.outgoingMessagesBubbleImage(with: .green)
    } else {
      return bubbleFactory?.incomingMessagesBubbleImage(with: .blue)
    }
  }
  
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return messages.count
  }
  
  override func collectionView(_ collectionView: JSQMessagesCollectionView!, messageDataForItemAt indexPath: IndexPath!) -> JSQMessageData! {
    return messages[indexPath.row]
  }
}

extension MessageController {
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // tell JSQMessagesViewController
    // who is the current user
    self.senderId = currentUser.id
    self.senderDisplayName = currentUser.name
    
    
    self.messages = getMessages()
  }
}

extension MessageController {
  func getMessages() -> [JSQMessage] {
    var messages = [JSQMessage]()
    
    let message1 = JSQMessage(senderId: "1", displayName: "Raja", text: "Hey Tim how are you?")
    let message2 = JSQMessage(senderId: "2", displayName: "Tim", text: "Fine thanks, and you?")
    
    messages.append(message1!)
    messages.append(message2!)
    
    return messages
  }
}

