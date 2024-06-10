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

/*struct DataSource {
    
    static var messages = [
        
        Message(content: "Hello [User's Name],\nI am interested in your profile.", chatboxType: .otherUser),
        
        Message(content: "Scheduled a call for 9:40 AM", chatboxType: .otherUser),
        Message(content: "Booking confirmed by user!", chatboxType: .otherUser)

    ]
}*/

enum ChatBoxType {
    case currentUser
    case otherUser
    case currentUserViewService
    case otherUserViewService
}

#Preview {
    ChatBoxView(msg: Message(content: "Hello [User's Name],\nI am interested in your profile.", chatboxType: .currentUserViewService))
}
