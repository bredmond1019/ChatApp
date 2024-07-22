use crate::models::conversation::ConversationId;
use crate::models::{
    chat_message::ClientMessage, conversation::Conversation,
    conversation_membership::ConversationMembership,
};
use crate::ChatServer;
use actix::prelude::*;
use actix_web_actors::ws;
use log::info;
use serde::{Deserialize, Serialize};
use uuid::Uuid;

#[derive(Debug, Clone, Copy, PartialEq, Eq, PartialOrd, Ord, Hash, Serialize, Deserialize)]
pub struct SessionId(pub Uuid);

pub struct ChatSession {
    pub id: SessionId,
    pub addr: Addr<ChatServer>,
    pub member: ConversationMembership,
    pub conversation_id: i32,
}

#[derive(Message)]
#[rtype(result = "()")]
pub struct ChatServerConnect {
    pub chat_session_id: SessionId,
    pub addr: Addr<ChatSession>,
    pub conversation_id: ConversationId,
}

#[derive(Message)]
#[rtype(result = "()")]
pub struct ChatServerDisconnect {
    pub chat_session_id: SessionId,
}

impl ChatSession {
    pub fn new(
        addr: Addr<ChatServer>,
        conversation: Conversation,
        member: ConversationMembership,
    ) -> Self {
        ChatSession {
            id: SessionId(Uuid::new_v4()),
            addr,
            member,
            conversation_id: conversation.id,
        }
    }
}

impl Actor for ChatSession {
    type Context = ws::WebsocketContext<Self>;

    fn started(&mut self, ctx: &mut Self::Context) {
        self.addr.do_send(ChatServerConnect {
            chat_session_id: self.id,
            addr: ctx.address(),
            conversation_id: ConversationId(self.conversation_id),
        });

        let response = serde_json::json!({
            "type": "chat_session_started",
            "conversation_id": self.conversation_id,
        });

        info!("Chat Session Started: {:?}", self.id);
        info!("Conversation Member: {:?}", self.member);
        info!("Conversation ID: {:?}", self.conversation_id);

        ctx.text(response.to_string());
    }

    fn stopping(&mut self, ctx: &mut Self::Context) -> Running {
        self.addr.do_send(ChatServerDisconnect {
            chat_session_id: self.id,
        });
        ctx.text("Chat Session Stopped");
        Running::Stop
    }
}

impl StreamHandler<Result<ws::Message, ws::ProtocolError>> for ChatSession {
    fn handle(&mut self, msg: Result<ws::Message, ws::ProtocolError>, ctx: &mut Self::Context) {
        match msg {
            Ok(ws::Message::Text(text)) => {
                info!("Received message: {:?}", text);
                let message: ClientMessage = match serde_json::from_str(&text) {
                    Ok(msg) => msg,
                    Err(err) => {
                        // Error if failed to deserialize ClientMessage
                        let error_message = format!("Error deserializing ClientMessage: {:?}", err);
                        ctx.text(error_message);
                        return;
                    }
                };

                self.addr.do_send(message);
            }
            _ => (),
        }
    }
}

impl Handler<ClientMessage> for ChatSession {
    type Result = ();

    fn handle(&mut self, msg: ClientMessage, ctx: &mut Self::Context) {
        // Serialize the message to JSON
        let response = serde_json::to_string(&msg).expect("Failed to serialize ClientMessage");

        // Send the JSON message to the WebSocket client
        ctx.text(response);
    }
}
