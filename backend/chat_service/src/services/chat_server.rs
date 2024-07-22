use std::collections::HashMap;

use crate::models::chat_message::ClientMessage;
use crate::models::conversation::ConversationId;
use crate::{db::DbPool, models::chat_message::ChatMessage};
use actix::{Actor, Addr, Context, Handler};
use log::info;

use super::chat_session::{ChatServerConnect, ChatServerDisconnect, ChatSession, SessionId};

pub struct ChatServer {
    sessions: HashMap<SessionId, Addr<ChatSession>>,
    conversation_sessions: HashMap<ConversationId, Vec<Addr<ChatSession>>>,
    db_pool: DbPool,
}

impl ChatServer {
    pub fn new(db_pool: DbPool) -> Self {
        ChatServer {
            sessions: HashMap::new(),
            conversation_sessions: HashMap::new(),
            db_pool,
        }
    }

    fn connect_session(&mut self, session_data: ChatServerConnect) {
        // Insert the chat session into the sessions HashMap
        self.sessions
            .insert(session_data.chat_session_id, session_data.addr.clone());

        // Insert the chat session into the conversation_sessions HashMap
        self.conversation_sessions
            .entry(session_data.conversation_id)
            .or_insert_with(Vec::new)
            .push(session_data.addr);
    }

    fn send_message_to_sessions(&self, message: ClientMessage) {
        let conversation_sessions = self
            .conversation_sessions
            .get(&message.conversation_id)
            .expect("No sessions found for conversation");

        for session in conversation_sessions {
            session.do_send(message.clone());
        }
    }
}

impl Actor for ChatServer {
    type Context = Context<Self>;
}

impl Handler<ChatServerConnect> for ChatServer {
    type Result = ();

    fn handle(&mut self, msg: ChatServerConnect, _: &mut Self::Context) {
        info!("Adding chat session: {:?}", msg.chat_session_id);

        self.connect_session(msg);
    }
}

impl Handler<ClientMessage> for ChatServer {
    type Result = ();

    fn handle(&mut self, msg: ClientMessage, _: &mut Self::Context) {
        let mut conn = self.db_pool.get().expect("Failed to get DB connection");
        ChatMessage::create(&msg, &mut conn);

        self.send_message_to_sessions(msg);
    }
}

impl Handler<ChatServerDisconnect> for ChatServer {
    type Result = ();

    fn handle(&mut self, msg: ChatServerDisconnect, _: &mut Self::Context) {
        self.sessions.remove(&msg.chat_session_id);
    }
}

// {
//     "sender_id": 1,
//     "receiver_id": 2,
//     "content": "Hello, world!",
//     "conversation_id": 1
// }
