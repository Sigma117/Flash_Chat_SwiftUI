//
//  FirestoreMessageManager.swift
//  Flash Chat
//
//  Created by Stefano Zhao on 09/11/24.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class FirestoreMessageManager {
    
    private let db = Firestore.firestore()
    
    func sendMessage(_ newMessage: String, completion: @escaping (Error?) -> Void) {
        if let messageSender = Auth.auth().currentUser?.email {
            let messageBody = newMessage
            db.collection(K.FStore.collectionName).addDocument(data: [
                K.FStore.senderField: messageSender,
                K.FStore.bodyField: messageBody,
                K.FStore.dateField: Date().timeIntervalSince1970 //second from 1/1/1970
            ]) { error in
                if let e = error {
                    completion(e)
                } else {
                    completion(nil)
                }
            }
        }
    }
    
    func loadMessages(completion: @escaping ([Message], Error?) -> Void) {
        db.collection(K.FStore.collectionName)
            .order(by: K.FStore.dateField)
            .addSnapshotListener { querySnapshot, error in
                var messages: [Message] = []
                if let e = error {
                    completion([], e)
                } else {
                    if let snapshotDocuments = querySnapshot?.documents {
                        for doc in snapshotDocuments {
                            let data = doc.data()
                            if let sender = data[K.FStore.senderField] as? String, let messageBody = data[K.FStore.bodyField] as? String {
                                let newMessage = Message(sender: sender, body: messageBody)
                                messages.append(newMessage)
                            }
                        }
                        completion(messages, nil)
                    }
                }
            }
    }
}


/*
func loadMessages() {
    self.messages = []
    db.collection(K.FStore.collectionName)
        .order(by: K.FStore.dateField)
        .addSnapshotListener { querySnapshot, error in
            if let e = error {
                print("There was an issue retrieving data from Firestore. \(e)")
            } else {
                if let snapshotDocuments = querySnapshot?.documents {
                    messages = []
                    for doc in snapshotDocuments {
                        let data = doc.data()
                        if let sender = data[K.FStore.senderField] as? String, let messageBody = data[K.FStore.bodyField] as? String {
                            let newMessage = Message(sender: sender, body: messageBody)
                            self.messages.append(newMessage)
                        }
                    }
                }
            }
        }
}
*/
