//
//  ChatBoxView.swift
//  Kryupa
//
//  Created by Pooja Nenava on 06/06/24.
//

import SwiftUI

struct ChatBoxView: View {
    
    var msg: Message

    var body: some View {
        
        switch msg.chatboxType {
        case .currentUser:
            HStack {
                Spacer()
                
                Text("\(msg.content)")
                    .frame(alignment: .trailing)
                    .font(.custom(FontContent.plusRegular, size: 13))
                    .foregroundColor(Color.white)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 10)
                    .background {
                        Image("MessageBubbleCurrentUser")
                            .resizable()
                    }
            }
            .padding(.horizontal, 20)
            
        case .otherUser:
            HStack {
                Text("\(msg.content)")
                    .font(.custom(FontContent.plusRegular, size: 13))
                    .foregroundStyle(._242426)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 10)
                    .background {
                        Image("MessageBubbleOtherUser")
                            .resizable()
                    }
                
                Spacer()

            }
            .padding(.horizontal, 20)
            
        case .currentUserViewService:
            
            HStack {
                Spacer()
                
            VStack(alignment: .leading) {
                Text("\(msg.content)")
                    .font(.custom(FontContent.plusRegular, size: 13))
                    .foregroundColor(Color.white)
                    .padding(.horizontal, 20)

                Text("View Service")
                    .font(.custom(FontContent.plusRegular, size: 16))
                    .foregroundStyle(.white)
                    .frame(width: 138, height: 32)
                    .background{
                        RoundedRectangle(cornerRadius: 48)
                    }
                    .asButton(.press) {
                        
                    }
                    .padding(.horizontal, 20)
            }
            .padding(.vertical, 15)
            .background {
                Image("MessageBubbleCurrentUser")
                    .resizable()
            }
            }
            .padding(.horizontal, 20)
            
        case .otherUserViewService:
            HStack {
            VStack(alignment: .leading) {
                Text("\(msg.content)")
                    .font(.custom(FontContent.plusRegular, size: 13))
                    .foregroundStyle(._242426)
                    .padding(.horizontal, 20)
                
                Text("View Service")
                    .font(.custom(FontContent.plusRegular, size: 16))
                    .foregroundStyle(.white)
                    .frame(width: 138, height: 32)
                    .background{
                        RoundedRectangle(cornerRadius: 48)
                    }
                    .asButton(.press) {
                        
                    }
                    .padding(.horizontal, 20)

                    
            }
            .padding(.vertical, 15)
            .background {
                Image("MessageBubbleOtherUser")
                    .resizable()
            }
                Spacer()

        }
        .padding(.horizontal, 20)
        }
    }
}

struct Message: Hashable {
    var id = UUID()
    var content: String
    var chatboxType: ChatBoxType
}

struct DataSource {
    
    static let messages = [
        
        Message(content: "Hello [User's Name],\nI am interested in your profile.", chatboxType: .currentUser),
        
        Message(content: "Hello! How can I assist you today?", chatboxType: .otherUser),
        Message(content: "How are you doing?", chatboxType: .otherUser),
        Message(content: "I'm just a computer program, so I don't have feelings, but I'm here and ready to help you with any questions or tasks you have. How can I assist you today?", chatboxType: .currentUserViewService),
        Message(content: "Tell me a joke.", chatboxType: .otherUser),
        Message(content: "Certainly! Here's one for you: Why don't scientists trust atoms? Because they make up everything!", chatboxType: .currentUser),
        Message(content: "How far away is the Moon from the Earth?", chatboxType: .otherUserViewService),
        Message(content: "The average distance from the Moon to the Earth is about 238,855 miles (384,400 kilometers). This distance can vary slightly because the Moon follows an elliptical orbit around the Earth, but the figure I mentioned is the average distance.", chatboxType: .currentUser)
        
    ]
}

enum ChatBoxType {
    case currentUser
    case otherUser
    case currentUserViewService
    case otherUserViewService
}

#Preview {
    ChatBoxView(msg: Message(content: "Hello [User's Name],\nI am interested in your profile.", chatboxType: .currentUserViewService))
}
